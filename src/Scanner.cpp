//
// Created by Jean-Luc Thumm on 5/28/18.
//

#include "Scanner.hpp"
#include "Parser.hpp"
#include <iostream>

using namespace std;

std::vector<std::string> Scanner::nextOp() {
    string op = nextToken();

    int numops = getOpCount(op);
    if (numops == -1) {
        throw runtime_error{"unknown instruction: " + op};
    }

    // get operands
    vector<string> ret;
    ret.push_back(op);
    if (numops == 2) {
        ret.push_back(nextToken());
        ret.push_back(nextToken());
    } else if (numops == 1) {
        ret.push_back(nextToken());
    }
    return ret;
}

Scanner::Scanner(const std::string &path) {
    ifstream in{path};

    string token;
    while (in) {
        in >> token;

        // filter out comments
        if (token == "//")

        tokens.push_back(token);
    }
    itr = tokens.begin();
}

int Scanner::getOpCount(std::string_view op) const {
    auto itr = Parser::opTable.find(string{op});
    if (itr == Parser::opTable.end()) {
        return -1;
    }
    return itr->second.numOperands;
}

std::string Scanner::nextToken() {
    if (itr == tokens.end()) {
        throw runtime_error{"unexpected end of file"};
    }
    return *itr++;
}
