module;
#include "doctest_fwd.hpp"
#define DOCTEST_PARTS_PUBLIC_STD_TYPE_TRAITS
export module doctest;
import std;
import std.compat;

export namespace doctest::detail
{
    namespace types = ::std;  // NOLINT(misc-unused-alias-decls)
}

extern "C++"
{
#include <doctest.h>
}

export namespace doctest
{
    using ::doctest::Approx;
    using ::doctest::Contains;
    using ::doctest::Context;
    using ::doctest::description;
    using ::doctest::expected_failures;
    using ::doctest::getContextOptions;
    using ::doctest::is_running_in_test;
    using ::doctest::IsNaN;
    using ::doctest::may_fail;
    using ::doctest::no_breaks;
    using ::doctest::no_output;
    using ::doctest::registerExceptionTranslator;
    using ::doctest::should_fail;
    using ::doctest::skip;
    using ::doctest::String;
    using ::doctest::StringMaker;
    using ::doctest::test_suite;
    using ::doctest::timeout;
    using ::doctest::toString;
    using ::doctest::operator+;
    using ::doctest::operator!=;
    using ::doctest::operator==;
    using ::doctest::operator<;
    using ::doctest::operator<=;
    using ::doctest::operator>;
    using ::doctest::operator>;
    using ::doctest::AssertData;
    using ::doctest::assertString;
    using ::doctest::ContextOptions;
    using ::doctest::CurrentTestCaseStats;
    using ::doctest::failureString;
    using ::doctest::IContextScope;
    using ::doctest::IReporter;
    using ::doctest::MessageData;
    using ::doctest::QueryData;
    using ::doctest::registerReporter;
    using ::doctest::skipPathFromFilename;
    using ::doctest::SubcaseSignature;
    using ::doctest::TestCaseData;
    using ::doctest::TestCaseException;
    using ::doctest::TestRunStats;

    namespace assertType
    {
        using ::doctest::assertType::Enum;
    }

    namespace Color
    {
        using ::doctest::Color::Enum;
        using ::doctest::Color::operator<<;
    }  // namespace Color

    namespace detail
    {

        namespace binaryAssertComparison
        {
            using ::doctest::detail::binaryAssertComparison::Enum;
        }

        using ::doctest::detail::acquireGeneratorValue;
        using ::doctest::detail::binary_assert;
        using ::doctest::detail::ContextScope;
        using ::doctest::detail::ContextScopeBase;
        using ::doctest::detail::decomp_assert;
        using ::doctest::detail::ExpressionDecomposer;
        using ::doctest::detail::MakeContextScope;
        using ::doctest::detail::MessageBuilder;
        using ::doctest::detail::regTest;
        using ::doctest::detail::ResultBuilder;
        using ::doctest::detail::setTestSuite;
        using ::doctest::detail::Subcase;
        using ::doctest::detail::TestCase;
        using ::doctest::detail::TestSuite;
        using ::doctest::detail::unary_assert;
    }  // namespace detail
}  // namespace doctest

export namespace doctest_detail_test_suite_ns
{
    using ::doctest_detail_test_suite_ns::getCurrentTestSuite;
}
