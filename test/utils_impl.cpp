module;
#include <doctest_macros.hpp>
module doctest.utils;

TEST_SUITE("some TS") {
    TEST_CASE("in TS") {
        FAIL("");
    }
}

REGISTER_EXCEPTION_TRANSLATOR(int &in) {
    return doctest::toString(in);
}

// Removes class on MSVC
TYPE_TO_STRING(doctest::String);

TEST_CASE_TEMPLATE("template 1", T, char) {
    FAIL("");
}

TEST_CASE_TEMPLATE_DEFINE("template 2", T, header_test) {
    FAIL("");
}

TEST_CASE_TEMPLATE_INVOKE(header_test, doctest::String);

TEST_CASE_FIXTURE(SomeFixture, "fixtured test") {
    data /= 2;
    CHECK(data == 21);
}
