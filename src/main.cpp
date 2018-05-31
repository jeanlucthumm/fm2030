#include <iostream>
#include <fstream>
#include "Scanner.hpp"
#include "Assembler.hpp"
#include "Writer.hpp"

using namespace std;

int main() {
    ofstream out{"sdf"};
    Writer writer{out, Writer::HEX};

    instr_t instr = 0x0125;

    writer.write(instr);

    return EXIT_SUCCESS;
}
