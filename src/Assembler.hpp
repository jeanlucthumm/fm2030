//
// Created by Jean-Luc Thumm on 5/28/18.
//

#ifndef FM2030_ASM_PARSER_HPP
#define FM2030_ASM_PARSER_HPP


#include <string>
#include <unordered_map>
#include <fstream>
#include <vector>
#include "Scanner.hpp"

typedef unsigned short instr_t;

enum InstrFormat {
    R, B
};

struct OpEntry {
    int numOperands;
    unsigned char opCode;
    InstrFormat format;
    bool composite;
};

struct RegEntry {
    unsigned char code;
    bool special;
};

class Assembler {
public:
    const static std::unordered_map<std::string, OpEntry> opTable;

    const static std::unordered_map<std::string, RegEntry> regTable;

    explicit Assembler(Scanner &scanner);

    void assemble(const std::ofstream &out);

public:
    static std::vector<instr_t> assmInstr(std::vector<std::string> &tokens);

    static instr_t rFormat(int opCode, int opA, int opB, int sbit);

    static instr_t bFormat(int opCode, int immediate);

    static std::vector<instr_t> handleComp(std::vector<std::string> tokens);

    static RegEntry regLookup(const std::string &reg);

    static OpEntry opLookup(const std::string &op);

private:
    Scanner &scanner;
    int counter;
};


#endif //FM2030_ASM_PARSER_HPP
