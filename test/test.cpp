#include "example.h"

#include <gtest/gtest.h>

TEST(hello, world) {
    EXPECT_EQ(1, 1);
    EXPECT_EQ(2, add(1, 1));
}

int main(int argc, char** argv) {
    ::testing::InitGoogleTest(&argc, argv);
    return RUN_ALL_TESTS();
}
