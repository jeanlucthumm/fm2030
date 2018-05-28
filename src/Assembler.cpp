//
// Created by Jean-Luc Thumm on 5/28/18.
//

#include "Assembler.hpp"

using namespace std;

const unordered_map<string, OpEntry> Assembler::opTable = { // NOLINT(cert-err58-cpp)
    {"add",   {
                  2,
                  0x00,
                  R,
                  false,
              }},
    {"cmp",   {
                  2,
                  0x01,
                  R,
                  false,
              }},
    {"clr",   {
                  1,
                  0x02,
                  R,
                  false,
              }},
    {"shl",   {
                  2,
                  0x03,
                  R,
                  false,
              }},
    {"lfsrs", {
                  1,
                  0x04,
                  R,
                  false,
              }},
    {"lfsrn", {
                  2,
                  0x05,
                  R,
                  false,
              }},
    {"lfsrp", {
                  2,
                  0x06,
                  R,
                  false,
              }},
    {"ld",    {
                  2,
                  0x07,
                  R,
                  false,
              }},
    {"st",    {
                  2,
                  0x08,
                  R,
                  false,
              }},
    {"moved", {
                  2,
                  0x09,
                  R,
                  false,
              }},
    {"mover", {
                  2,
                  0x0A,
                  R,
                  false,
              }},
    {"inc",   {
                  1,
                  0x0B,
                  R,
                  false,
              }},
    {"xor",   {
                  2,
                  0x0C,
                  R,
                  false,
              }},
    {"be",    {
                  1,
                  0x0D,
                  B,
                  false,
              }},
    {"bne",   {
                  1,
                  0x0E,
                  B,
                  false,
              }},
    {"jump",  {
                  1,
                  0x0F,
                  B,
                  false,
              }},
    {"set",   {
                  2,
                  0x00,
                  R,
                  true,
              }},
    {"mov",   {
                  2,
                  0x00,
                  R,
                  true,
              }},
};

Assembler::Assembler(Scanner &scanner) : scanner{scanner}, counter{0} {}

/// \throw Any error from Scanner::nextOp()
void Assembler::assemble(const std::ofstream &out) {
    scanner.reset();
    while (!scanner.eof()) {
        vector<string> instr = scanner.nextOp();
    }
}
