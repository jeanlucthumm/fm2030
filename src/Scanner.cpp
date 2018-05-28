//
// Created by Jean-Luc Thumm on 5/28/18.
//

#include "Scanner.hpp"
#include "Parser.hpp"
#include <iostream>

using namespace std;

std::vector<std::string> Scanner::nextOp() const {
    string token;


    return vector<string>{};
}

Scanner::Scanner(const std::string &path) {
    ifstream in{path};

    string token;
    while (in) {
        in >> token;
        tokens.push_back(token);
    }
    itr = tokens.begin();
}

int Scanner::getOpCount(std::string_view op) {
    auto itr = Parser::opTable.find(string{op});
    if (itr == Parser::opTable.end()) {
        return -1;
    }
    return itr->second.numOperands;
}
