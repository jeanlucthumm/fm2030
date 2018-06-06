//
// Created by Jean-Luc Thumm on 5/30/18.
//

#ifndef FM2030_ASM_WRITER_HPP
#define FM2030_ASM_WRITER_HPP

#include <fstream>
#include "comm.hpp"

class Writer {
public:
    enum Mode {
        PACK, PAD, HEX
    };

    Writer(std::ofstream &out, Mode mode);

    void write(instr_t instr);

private:
    void writeHex(instr_t instr);

    std::ofstream &out;
    Mode mode;
};

#endif //FM2030_ASM_WRITER_HPP
