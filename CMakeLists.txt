cmake_minimum_required(VERSION 3.11)
project(fm2030_asm)

set(CMAKE_CXX_STANDARD 17)

set(SRC_FILES src/main.cpp
              src/Scanner.cpp src/Scanner.hpp src/Parser.cpp src/Parser.hpp)

add_executable(fm2030_asm ${SRC_FILES})
