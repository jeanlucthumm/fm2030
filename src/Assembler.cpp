//
// Created by Jean-Luc Thumm on 5/28/18.
//

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

Assembler::Assembler(Scanner &scanner) : scanner{scanner}, counter{0} {}

/// \throw Any error from Scanner::nextOp()
void Assembler::assemble(const std::ofstream &out) {
    scanner.reset();
    while (!scanner.eof()) {
        vector<string> tokens = scanner.nextOp();

        // TODO
    }
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

    res |= opCode;
    res |= immediate;

    return res;
}

/// \throw Unknown register exception
std::vector<instr_t> Assembler::assmInstr(std::vector<std::string> &tokens) {
    OpEntry entry = (*opTable.find(tokens[0])).second;

    if (entry.composite) {
        return handleComp(tokens);
    }

    if (entry.format == R) {
        // lookup registers
        auto itr = regTable.find(tokens[1]);
        if (itr == regTable.end()) {
            throw runtime_error{"unknown register: " + tokens[1]};
        }
        RegEntry rd = itr->second;

        itr = regTable.find(tokens[2]);
        if (itr == regTable.end()) {
            throw runtime_error{"unknown register: " + tokens[2]};
        }
        RegEntry rs = itr->second;


    }
    else if (entry.format == B) {

    }
}

/// \throw regLookup() opLookup()
std::vector<instr_t> Assembler::handleComp(std::vector<std::string> tokens) {
    if (tokens[0] == "mov") {
        auto rdEntry = regLookup(tokens[1]);
        auto rsEntry = regLookup(tokens[2]);
        bool rds = rdEntry.special;
        bool rss = rdEntry.special;

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
        else if (!rds && rss) {
            sbit = 1;
            op = "moved";
        }
        else if (rds && !rss) {
            sbit = 0;
            op = "moved";
        }

        auto opEntry = opLookup(op);
        instr_t instr = rFormat(opEntry.opCode, rdEntry.code, rsEntry.code, sbit);
        return {instr};
    }
    else if (tokens[0] == "set") {
        int num = std::stoi(tokens[2]);

        vector<vector<string>> compInstructions;

        // decompose into shifts and increments
        while (num != 0) {
            if (num % 2 == 1) {
                compInstructions.push_back({"inc", tokens[1]});
                num -= 1;
            }
            if (num == 0) break;
            int amt = 0;
            while (amt <= 3 && num % 2 != 1) {
                num /= 2;
                amt++;
            }
            compInstructions.push_back({"shl", std::to_string(amt)});
        }

        std::reverse(compInstructions.begin(), compInstructions.end());

        // convert to instr_t
        vector<instr_t> res;
        for (auto &ctokens : compInstructions) {
            instr_t instr = assmInstr(ctokens)[0]; // will always return something
            res.push_back(instr);
        }

        return res;
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
