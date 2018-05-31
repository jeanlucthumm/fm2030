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
#include "Writer.hpp"
#include "comm.hpp"

enum InstrFormat {
    R, B
};

struct OpEntry {
    int numOperands;
    unsigned char code;
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

    explicit Assembler(Scanner &scanner, Writer &writer);

    void assemble();

public:

    static instr_t rFormat(int opCode, int rd, int rs, int sbit);

    static instr_t bFormat(int opCode, int immediate);

    static std::vector<instr_t> handleComp(std::vector<std::string> tokens);

    static RegEntry regLookup(const std::string &reg);

    static OpEntry opLookup(const std::string &op);

private:
    Scanner &scanner;
    Writer &writer;
    int counter;


    std::vector<instr_t> assmInstr(std::vector<std::string> &tokens);

    std::unordered_map<std::string, int> labelTable;
};


#endif //FM2030_ASM_PARSER_HPP
