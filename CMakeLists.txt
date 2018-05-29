cmake_minimum_required(VERSION 3.11)
project(fm2030_asm)

set(CMAKE_CXX_STANDARD 17)

set(SRC_FILES
        src/Scanner.cpp src/Scanner.hpp
        src/Assembler.cpp src/Assembler.hpp)

set(TEST_SRC_FILES
        test/AssemblerTest.hpp)

find_package(GTest REQUIRED)

add_executable(fm2030_asm src/main.cpp ${SRC_FILES})

add_executable(testing test/main.cpp ${SRC_FILES} ${TEST_SRC_FILES})

target_link_libraries(testing GTest::GTest GTest::Main)

add_test(AllTests testing)
