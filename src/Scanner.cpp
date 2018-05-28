//
// Created by Jean-Luc Thumm on 5/28/18.
//

#include "Scanner.hpp"
#include <iostream>

using namespace std;

Scanner::Scanner(std::ifstream &input) : input{input} {}

std::vector<std::string> Scanner::nextOp() const {
    string token;
    while(input) {
        input >> token;
        cout << token << endl;
    }

    return vector<string>{};
}
