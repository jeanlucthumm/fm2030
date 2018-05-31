//
// Created by Jean-Luc Thumm on 5/30/18.
//

#include "Writer.hpp"

Writer::Writer(std::ofstream &out, Writer::Mode mode)
    : out{out}, mode{mode} {}
