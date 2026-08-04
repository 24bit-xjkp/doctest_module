# Modular doctest ([中文](README_zh.md))

As a header-only library, the doctest testing framework contains about 10,000 lines of code as well as a large number of C++ standard library headers.
Using it directly through `#include` causes this code to be processed repeatedly across different translation units, which slows down compilation.
C++20 introduced modules, and C++23 introduced the standard library modules `std` and `std.compat`, making it possible to accelerate the compilation of header-only libraries.

## Usage

First compile the `doctest` module, then include `doctest_macros.hpp` and import the `doctest` module in your source file.

```cpp
// Include the macro definitions provided by doctest
#include <doctest_macros.hpp>
// Include the declarations provided by doctest
import doctest;
// import std; // Import the standard library module as needed

// The doctest framework can now be used normally
TEST_CAST("test")
{
    CHECK(true);
}
```

## Integrating with xmake

The xmake package description is provided in [this file](script/package.lua), so it can be used directly in xmake.

```lua
-- Obtain the package description from this file
includes("package.lua")
-- Add the package dependency
add_requires("doctest_module")
set_policy("build.c++.modules", true)

target("test")
    -- doctest unit test source file without a main function definition
    add_files("test.cpp")
    -- Add the main component of the doctest_module package, which provides the default main function definition
    add_packages("doctest_module", { components = "main" })

target("test_with_custom_main")
    -- custom_main.cpp contains a custom main function
    add_files("test.cpp", "custom_main.cpp")
    -- Add the core component of the doctest_module package, which does not provide a main function definition
    add_packages("doctest_module", { components = "core" })
```

The `doctest_module` package contains the following components:

| Component | Description                                                                     |
| --------- | ------------------------------------------------------------------------------- |
| core      | Contains the doctest module declarations, definitions, and macro definitions    |
| main      | Depends on the core component and provides the default main function definition |

In addition to xmake's default options, the `doctest_module` package provides the following options:

| Option     | Description                                                     |
| ---------- | --------------------------------------------------------------- |
| main       | Enable support for the main component                           |
| std_harden | Enable C++ standard library hardening when building the package |

## Project structure

| File                   | Description                                                                                                                                 |
| ---------------------- | ------------------------------------------------------------------------------------------------------------------------------------------- |
| script/option.lua      | Provides the build option definitions required by the project                                                                               |
| script/package.lua     | Provides the xmake package description                                                                                                      |
| script/task.lua        | Provides the xmake plugin for testing the xmake package description                                                                         |
| src/doctest_fwd.hpp    | Internal header that provides the system headers required by doctest and uses macros to disable imports of all C++ standard library headers |
| src/doctest_impl.cpp   | Provides doctest function definitions and is compiled into a static or dynamic library                                                      |
| src/doctest_macros.hpp | Provides doctest macro definitions                                                                                                          |
| src/doctest.cppm       | Defines the doctest module and exports the function declarations required by the doctest framework                                          |
| src/main.cpp           | Provides the default main function definition and is compiled into a static library                                                         |
| test/*.cpp             | Example files from doctest, used to test compatibility with the doctest_module implementation                                               |
| test/package/*         | A subproject used to test the xmake package description                                                                                     |

## Dependencies

| Repository                                                                                                   | Description                                            |
| ------------------------------------------------------------------------------------------------------------ | ------------------------------------------------------ |
| [doctest](https://github.com/doctest/doctest)                                                                | The doctest testing framework                          |
| [convert-cpp-std-headers-to-std-module](https://github.com/YexuanXiao/convert-cpp-std-headers-to-std-module) | Provides a simple way to convert headers into a module |
