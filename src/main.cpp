#include <iostream>
#include <fstream>
#include "Scanner.hpp"

using namespace std;

int main() {
//    ifstream in{"assembly/program1.s"};
//    Scanner scanner{in};
//    scanner.nextOp();
    ifstream in{"assembly/test.txt"};

    string token;
    in >> token;
    cout << token << endl;
    in >> token;
    cout << token << endl;
    if (token == "//") {
        getline(in, token);
    }
    while (in) {
        in >> token;
        cout << token << endl;
    }

    return EXIT_SUCCESS;
}
