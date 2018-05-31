//
// Created by Jean-Luc Thumm on 5/28/18.
//

#include <iostream>
#include "Assembler.hpp"

using namespace std;

const unordered_map<string, OpEntry> Assembler::opTable = { // NOLINT(cert-err58-cpp)
    {"add",   {
                  2,
                  0x00,
                  R,
                  false,
              }},
    {"cmp",   {
                  2,
                  0x01,
                  R,
                  false,
              }},
    {"clr",   {
                  1,
                  0x02,
                  R,
                  false,
              }},
    {"shl",   {
                  2,
                  0x03,
                  R,
                  false,
              }},
    {"lfsrs", {
                  1,
                  0x04,
                  R,
                  false,
              }},
    {"lfsrn", {
                  2,
                  0x05,
                  R,
                  false,
              }},
    {"lfsrp", {
                  2,
                  0x06,
                  R,
                  false,
              }},
    {"ld",    {
                  2,
                  0x07,
                  R,
                  false,
              }},
    {"st",    {
                  2,
                  0x08,
                  R,
                  false,
              }},
    {"moved", {
                  2,
                  0x09,
                  R,
                  false,
              }},
    {"mover", {
                  2,
                  0x0A,
                  R,
                  false,
              }},
    {"inc",   {
                  1,
                  0x0B,
                  R,
                  false,
              }},
    {"xor",   {
                  2,
                  0x0C,
                  R,
                  false,
              }},
    {"be",    {
                  1,
                  0x0D,
                  B,
                  false,
              }},
    {"bne",   {
                  1,
                  0x0E,
                  B,
                  false,
              }},
    {"jump",  {
                  1,
                  0x0F,
                  B,
                  false,
              }},
    {"set",   {
                  2,
                  0x00,
                  R,
                  true,
              }},
    {"mov",   {
                  2,
                  0x00,
                  R,
                  true,
              }},
};

const std::unordered_map<std::string, RegEntry> Assembler::regTable = { // NOLINT(cert-err58-cpp)
    {"r0", {
               0x00,
               false,
           }},
    {"r1", {
               0x01,
               false,
           }},
    {"r2", {
               0x10,
               false,
           }},
    {"r3", {
               0x11,
               false,
           }},
    {"s0", {
               0x00,
               true,
           }},
    {"s1", {
               0x01,
               true,
           }},
    {"s2", {
               0x10,
               true,
           }},
    {"s3", {
               0x11,
               true,
           }},
};

Assembler::Assembler(Scanner &scanner, Writer &writer)
    : scanner{scanner}, writer{writer}, counter{0} {}

bool Assembler::assemble() {
    try {
        scanner.reset();
        while (!scanner.eof()) {
            vector<string> tokens = scanner.nextOp();

            // DEBUG
            cout << "Assembling: ";
            for (auto &token : tokens) {
                cout << token << ", ";
            }
            cout << endl;

            vector<instr_t> instructions = assmInstr(tokens);

            for (instr_t instr : instructions) {
                writer.write(instr);
            }
        }
    }
    catch (runtime_error &error) {
        cerr << error.what() << endl;
        return false;
    }
    return true;
}

/// \pre parameters contain only 0s for non-relevant bits
instr_t Assembler::rFormat(int opCode, int rd, int rs, int sbit) {
    instr_t res = 0x0000;
    opCode <<= 5;
    rd <<= 3;
    rs <<= 1;

    res |= opCode;
    res |= rd;
    res |= rs;
    res |= sbit;

    return res;
}

/// \pre parameters contain only 0s for non-relevant bits
instr_t Assembler::bFormat(int opCode, int immediate) {
    instr_t res = 0x0000;
    opCode <<= 5;

    // clear trivial bits
    immediate &= 0x0000001F;

    res |= opCode;
    res |= immediate;

    return res;
}

/// \throw Unknown register exception
vector<instr_t> Assembler::assmInstr(std::vector<std::string> &tokens) {
    // handle labels
    if (tokens[0].find(':') != string::npos) { // only labels have ':'
        tokens[0].erase(std::remove(tokens[0].begin(), tokens[0].end(), ':'), tokens[0].end());
        labelTable[tokens[0]] = counter + 1; // label refers to next instruction
        return {};
    }

    auto op = opLookup(tokens[0]);

    if (op.composite) {
        vector<instr_t> res = handleComp(tokens);
        counter += res.size();
        return res;
    }

    if (op.format == R) {
        instr_t instr;

        auto rd = regLookup(tokens[1]);

        // handle shl which has amt in rs
        if (tokens[0] == "shl") {
            auto sbit = (rd.special) ? 1 : 0;

            instr = rFormat(op.code, rd.code, std::atoi(tokens[2].c_str()), sbit);
        }

        if (tokens.size() == 3) {
            auto rs = regLookup(tokens[2]);
            int sbit = (rs.special) ? 1 : 0;

            instr = rFormat(op.code, rd.code, rs.code, sbit);
        }
        else if (tokens.size() == 2) {
            int sbit = (rd.special) ? 1 : 0;

            instr = rFormat(op.code, rd.code, 0, sbit);
        }
        else {
            return {};
        }

        counter++;
        return {instr};
    }
    else if (op.format == B) {
        // lookup label
        auto itr = labelTable.find(tokens[1]);
        if (itr == labelTable.end()) {
            throw runtime_error{"unknown label: \"" + tokens[1] + "\""};
        }
        int addr = itr->second;

        int offset = addr - (counter + 2); // PC + 1, relative

        if (offset < -16 || offset > 15) {
            throw runtime_error{"label \"" + tokens[1] + "\" refers to an offset" +
                                " outside of [-15, 16]"};
        }

        instr_t instr = bFormat(op.code, offset);
        counter++;
        return {instr};
    }
    return {};
}

/// \throw regLookup() opLookup()
std::vector<instr_t> Assembler::handleComp(std::vector<std::string> tokens) {
    if (tokens[0] == "mov") {
        auto rdEntry = regLookup(tokens[1]);
        auto rsEntry = regLookup(tokens[2]);
        bool rds = rdEntry.special;
        bool rss = rsEntry.special;

        int sbit;
        string op;

        if (rds && rss) {
            sbit = 1;
            op = "mover";
        }
        else if (!rds && !rss) {
            sbit = 0;
            op = "mover";
        }
        else if (!rds) {
            sbit = 1;
            op = "moved";
        }
        else {
            sbit = 0;
            op = "moved";
        }

        auto opEntry = opLookup(op);
        instr_t instr = rFormat(opEntry.code, rdEntry.code, rsEntry.code, sbit);
        return {instr};
    }
    else if (tokens[0] == "set") {
        int num = std::stoi(tokens[2]);

        auto inc = opLookup("inc");
        auto shl = opLookup("shl");
        auto rd = regLookup(tokens[1]);
        auto sbit = (rd.special) ? 1 : 0;

        vector<instr_t> compInstructions;

        // decompose into shifts and increments
        while (num != 0) {
            if (num % 2 == 1) {
                instr_t instr = rFormat(inc.code, rd.code, 0, sbit);
                compInstructions.push_back(instr);
                num -= 1;
            }
            if (num == 0) break;
            int amt = 0;
            while (amt < 3 && num % 2 != 1) {
                num /= 2;
                amt++;
            }
            instr_t instr = rFormat(shl.code, rd.code, amt, sbit);
            compInstructions.push_back(instr);
        }

        std::reverse(compInstructions.begin(), compInstructions.end());

        return compInstructions;
    }
    return {};
}

/// \throw Unknown register error
RegEntry Assembler::regLookup(const std::string &reg) {
    auto itr = regTable.find(reg);
    if (itr == regTable.end()) {
        throw runtime_error{"unknown register: " + reg};
    }
    return itr->second;
}

/// \throw Unknown register error
OpEntry Assembler::opLookup(const std::string &op) {
    auto itr = opTable.find(op);
    if (itr == opTable.end()) {
        throw runtime_error{"unknown register: " + op};
    }
    return itr->second;
}
