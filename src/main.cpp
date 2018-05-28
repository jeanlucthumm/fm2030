#include <iostream>
#include <fstream>
#include "Scanner.hpp"

using namespace std;

int main() {
    Scanner scanner{"assembly/program1.s"};

    while (!scanner.eof()) {
        vector<string> instr = scanner.nextOp();
        cout << instr[0] << "(";
        if (instr.size() == 2) {
            cout << instr[1] << ")" << endl;
        }
        else if (instr.size() == 3) {
            cout << instr[1] << "," << instr[2] << ")" << endl;
        }
        else {
            cout << ")" << endl;
        }
    }

    return EXIT_SUCCESS;
}
