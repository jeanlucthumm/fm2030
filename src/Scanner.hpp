//
// Created by Jean-Luc Thumm on 5/28/18.
//

#ifndef FM2030_ASM_SCANNER_HPP
#define FM2030_ASM_SCANNER_HPP

#include <unordered_map>
#include <fstream>
#include <vector>

// Scanner reads an input file and processe
class Scanner {
public:
    explicit Scanner(std::ifstream &input);

    std::vector<std::string> nextOp() const;

private:
    static std::unordered_map<std::string, int> opCountTable;

    std::ifstream &input;
};

#endif //FM2030_ASM_SCANNER_HPP
