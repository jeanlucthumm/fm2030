#pragma clang diagnostic push
#pragma ide diagnostic ignored "cppcoreguidelines"

#ifndef FM2030_ASM_ASSEMBLERTEST_HPP
#define FM2030_ASM_ASSEMBLERTEST_HPP

#include <gtest/gtest.h>
#include "../src/Assembler.hpp"

TEST(Assembler, regLookup) {
    EXPECT_NO_THROW({
        auto entry = Assembler::regLookup("r1");
        entry = Assembler::regLookup("s2");
    });

    EXPECT_THROW({
        auto entry = Assembler::regLookup("b3");
    }, std::runtime_error);
}

TEST(Assembler, opLookup) {
    EXPECT_NO_THROW({
        auto entry = Assembler::opLookup("lfsrn");
        entry = Assembler::opLookup("xor");
    });

    EXPECT_THROW({
        auto entry = Assembler::opLookup("b3");
    }, std::runtime_error);
}

TEST(Assembler, rFormat) {
    EXPECT_EQ(
        Assembler::rFormat(0x0C, 0x00, 0x02, 0x00), // xor r0, r2
        0x0184
    );

    EXPECT_EQ(
        Assembler::rFormat(0x09, 0x00, 0x02, 0x01), // moved r0, s2
        0x0125
    );
}

TEST(Assembler, bFormat) {
    EXPECT_EQ(
        Assembler::bFormat(0x0E, 0x09), // bne 9,
        0x01C9
    );
}

TEST(Assembler, handleCompMov) {
    auto s0 = Assembler::regLookup("s0").code;
    auto r1 = Assembler::regLookup("r1").code;
    auto mover = Assembler::opLookup("mover").code;
    auto moved = Assembler::opLookup("moved").code;

    instr_t mov_s0r1 = Assembler::rFormat(moved, s0, r1, 0);
    instr_t mov_r1s0 = Assembler::rFormat(moved, r1, s0, 1);
    instr_t mov_s0s0 = Assembler::rFormat(mover, s0, s0, 1);
    instr_t mov_r1r1 = Assembler::rFormat(mover, r1, r1, 0);

    EXPECT_EQ(Assembler::handleComp({"mov", "s0", "r1"})[0], mov_s0r1);
    EXPECT_EQ(Assembler::handleComp({"mov", "r1", "s0"})[0], mov_r1s0);
    EXPECT_EQ(Assembler::handleComp({"mov", "s0", "s0"})[0], mov_s0s0);
    EXPECT_EQ(Assembler::handleComp({"mov", "r1", "r1"})[0], mov_r1r1);
}

#endif //FM2030_ASM_ASSEMBLERTEST_HPP

#pragma clang diagnostic pop