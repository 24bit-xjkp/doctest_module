#include <doctest_macros.hpp>
import doctest.utils;

namespace App
{
    struct Foo
    {
    };

    std::string toString(Foo*) { return "Foo"; }
}  // namespace App

TEST_CASE("toString std::string ret type")
{
    App::Foo foo;  // NOLINT(misc-const-correctness)
    CHECK(&foo != nullptr);
    CHECK_NE(&foo, nullptr);
    CHECK(&foo);
}
