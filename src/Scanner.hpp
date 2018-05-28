//
// Created by Jean-Luc Thumm on 5/28/18.
//

#ifndef FM2030_ASM_SCANNER_HPP
#define FM2030_ASM_SCANNER_HPP

#include <unordered_map>
#include <fstream>
#include <vector>
#include <string>

// Scanner reads an input file and processe
class Scanner {
public:
    explicit Scanner(const std::string &path);

    std::vector<std::string> nextOp();

private:
    int getOpCount(std::string_view op) const;

    std::string nextToken();

    std::vector<std::string> tokens;
    std::vector<std::string>::iterator itr;
};

#endif //FM2030_ASM_SCANNER_HPP
