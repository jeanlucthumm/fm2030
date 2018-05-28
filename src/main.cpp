#include <iostream>
#include <fstream>
#include "Scanner.hpp"
#include "Assembler.hpp"

using namespace std;

int main() {
    ifstream in{"assembly/program1.s"};
    Scanner scanner{in};

    instr_t instr = Assembler::rFormat(0x0C, 0x00, 0x02, 0x00);

    cout << hex << uppercase << instr << endl;

    return EXIT_SUCCESS;
}
