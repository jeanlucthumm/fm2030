cmake_minimum_required(VERSION 3.11)
project(fm2030_asm)

set(CMAKE_CXX_STANDARD 17)

set(SRC_FILES src/main.cpp
        src/Scanner.cpp src/Scanner.hpp
        src/Assembler.cpp src/Assembler.hpp)

find_package(GTest REQUIRED)

add_executable(fm2030_asm ${SRC_FILES})
target_link_libraries(fm2030_asm GTest::GTest GTest::Main)

add_test(AllTests fm2030_asm)
