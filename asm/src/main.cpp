#include <iostream>
#include <fstream>
#include <string>
#include "Scanner.hpp"
#include "Assembler.hpp"
#include "Writer.hpp"

#define ARGC 4

using namespace std;

static const char *usage =
    "Usage: fm2030_asm in out [PACK|PAD|HEX]\n"
    "\tin:\t\t assembly code\n"
    "\tout:\t assembled code destination\n"
    "\tmode:\t output mode\n"
    "\t\tPACK:\t pack instructions without space between them, disregarding byte "
    "boundaries. 0 padding will be added at the end to byte align file.\n"
    "\t\tPAD:\t pad instructions such that each ends on a byte boundary\n"
    "\t\tHEX:\t output instructions in ASCII HEX representation\n";


int main(int argc, char **argv) {
    if (argc != ARGC) {
        cout << usage;

        return EXIT_FAILURE;
    }

    string inPath{argv[1]};
    string outPath{argv[2]};
    string modeStr{argv[3]};

    ifstream in{inPath};
    ofstream out{outPath};

    if (!in.is_open()) {
        cout << "could not open file: " << inPath << endl;
        return EXIT_FAILURE;
    }
    if (!out.is_open()) {
        cout << "could not open file: " << outPath << endl;
        return EXIT_FAILURE;
    }

    Writer::Mode mode;
    if (modeStr == "PACK") {
        mode = Writer::PACK;
    }
    else if (modeStr == "PAD") {
        mode = Writer::PAD;
    }
    else if (modeStr == "HEX") {
        mode = Writer::HEX;
    }
    else {
        cout << "unknown mode: " << modeStr << endl;
        cout << endl;
        cout << usage;

        return EXIT_FAILURE;
    }

    cout << "assembling: " << inPath << ", to output file: " << outPath
         << ", in mode: " << modeStr << endl;

    Scanner scanner{in};
    Writer writer{out, mode};

    Assembler assembler{scanner, writer};
    bool success = assembler.assemble();

    in.close();
    out.close();

    if (success) {
        cout << endl << "assembly succeeded" << endl;
        return EXIT_SUCCESS;
    }
    else {
        cout << endl << "assembly failed" << endl;
        return EXIT_FAILURE;
    }
}
