//
// Created by Jean-Luc Thumm on 5/28/18.
//

#ifndef FM2030_ASM_PARSER_HPP
#define FM2030_ASM_PARSER_HPP


#include <string>
#include <unordered_map>

struct OpEntry{
    int numOperands;
};

class Parser {
public:
    const static std::unordered_map<std::string, OpEntry> opTable;
};


#endif //FM2030_ASM_PARSER_HPP
