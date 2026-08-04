import doctest;
import std;

int main(int argc, const char* argv[])
{
    try
    {
        return ::doctest::Context{argc, argv}.run();
    }
    catch(...)
    {
        ::std::terminate();
    }
}
