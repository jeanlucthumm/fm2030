//
// Created by Jean-Luc Thumm on 5/28/18.
//

#ifndef FM2030_ASM_PARSER_HPP
#define FM2030_ASM_PARSER_HPP


#include <string>
#include <unordered_map>
#include <fstream>
#include "Scanner.hpp"

enum InstrFormat {
    R, B
};

struct OpEntry{
    int numOperands;
    unsigned char opCode;
    InstrFormat format;
    bool composite;
};

class Assembler {
public:
    const static std::unordered_map<std::string, OpEntry> opTable;

    explicit Assembler(Scanner &scanner);

    void assemble(const std::ofstream &out);

private:
    Scanner &scanner;
    int counter;
};


#endif //FM2030_ASM_PARSER_HPP
