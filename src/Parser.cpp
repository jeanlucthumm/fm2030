//
// Created by Jean-Luc Thumm on 5/28/18.
//

#include "Parser.hpp"

using namespace std;

const unordered_map<string, OpEntry> Parser::opTable = {
    {"add", {
                2
            }},
    {"cmp", {
                2
            }},
    {"clr", {
                1
            }},
    {"shl", {
                2
            }},
    {"lfsrs", {
                1
            }},
    {"lfsrn", {
                2
            }},
    {"lfsrp", {
                2
            }},
    {"ld", {
                2
            }},
    {"st", {
                2
            }},
    {"moved", {
                2
            }},
    {"mover", {
                2
            }},
    {"inc", {
                1
            }},
    {"xor", {
                2
            }},
    {"cmp", {
                2
            }},
    {"be", {
                2
            }},
    {"bne", {
                2
            }},
    {"jump", {
                2
            }},
};
