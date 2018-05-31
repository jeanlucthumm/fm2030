#include <iostream>
#include <fstream>
#include "Scanner.hpp"
#include "Assembler.hpp"
#include "Writer.hpp"

using namespace std;

int main() {
    ifstream in{"assembly/program1.s"};
    ofstream out{"bin/program1.out"};

    Scanner scanner{in};
    Writer writer{out, Writer::HEX};

    Assembler assembler{scanner, writer};
    bool success = assembler.assemble();

    in.close();
    out.close();

    if (success) {
        return EXIT_SUCCESS;
    }
    else {
        return EXIT_FAILURE;
    }
}
