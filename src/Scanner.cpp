//
// Created by Jean-Luc Thumm on 5/28/18.
//

#include "Scanner.hpp"
#include "Parser.hpp"
#include <iostream>
#include <sstream>


using namespace std;

std::vector<std::string> Scanner::nextOp() {
    string op = nextToken();

    // check for labels // FIXME what if there are two colons?
    if (op.find(':') != string::npos) {
        return {op};
    }

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
    }
    else if (numops == 1) {
        ret.push_back(nextToken());
    }
    return ret;
}

Scanner::Scanner(const std::string &path) {
    ifstream in{path};

    string token;
    while (true) {
        in >> token;
        if (!in) break;

        // filter out comments
        if (token == "//") {
            getline(in, token); // move to next line
            continue;
        }
        if (token == "/*") { // block comments
            while (token != "*/") {
                if (!in) throw runtime_error{"unexpected EOF"};
                in >> token;
            }
            continue;
        }

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

bool Scanner::eof() const {
    return itr == tokens.end();
}
