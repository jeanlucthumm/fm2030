#include <iostream>
#include <fstream>
#include "Scanner.hpp"

using namespace std;

int main() {
    ifstream in{"assembly/program1.s"};
    Scanner scanner{in};
    scanner.nextOp();

    return EXIT_SUCCESS;
}
