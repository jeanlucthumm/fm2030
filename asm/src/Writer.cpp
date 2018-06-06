//
// Created by Jean-Luc Thumm on 5/30/18.
//

#include "Writer.hpp"

#include <iostream>
#include <iomanip>

using namespace std;

Writer::Writer(std::ofstream &out, Writer::Mode mode)
    : out{out}, mode{mode} {}

void Writer::write(instr_t instr) {
    switch (mode) {
        case PACK:
            break;
        case PAD:
            break;
        case HEX:
            writeHex(instr);
            break;
    }
}

void Writer::writeHex(instr_t instr) {
    out << "0x" << std::uppercase << std::hex <<
         std::setw(4) << std::setfill('0') << instr << endl;
}