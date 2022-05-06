#include "example.h"

#include <gtest/gtest.h>

namespace microlife {
int func() {
    return 3;
}
} // namespace microlife

TEST(hello, world) {
    EXPECT_EQ(1, 1);
    EXPECT_EQ(2, add(1, 1));
    EXPECT_EQ(3, microlife::func());
}

int main(int argc, char** argv) {
    ::testing::InitGoogleTest(&argc, argv);
    return RUN_ALL_TESTS();
}
