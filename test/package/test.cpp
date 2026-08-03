#include <doctest_macros.hpp>
import doctest;

TEST_SUITE("doctest_module package test")
{
    TEST_CASE("test")
    {
        SUBCASE("test1")
        {
            CHECK(1 == 1);
            CHECK_EQ(1, 1);
        }

        SUBCASE("test2")
        {
            CHECK(1 != 2);
            CHECK_NE(1, 2);
        }
    }
}
