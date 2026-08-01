export module doctest.utils;
export import std;
export import std.compat;
export import doctest;

export {
    template <typename T>
    int throw_if(bool in, const T& ex)
    {
        if(in) { throw ex; }
        return 42;
    }

    struct SomeFixture
    {
        int data;

        SomeFixture() noexcept : data(42)
        {
            // setup here
        }

        ~SomeFixture()
        {
            // teardown here
        }
    };
}
