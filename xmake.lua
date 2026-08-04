set_project("doctest_module")
set_languages("c++latest")
set_warnings("allextra")
includes("script/*.lua")
add_rules("mode.debug", "mode.release", "mode.releasedbg")
set_allowedmodes("debug", "release", "releasedbg")
add_requires("clean_std_heads", "doctest")
add_packages("clean_std_heads", "doctest")

option("with_main")
    set_default(true)
    set_description("Enable main function support.")
option_end()

add_options("use_std_harden")

includes("*/xmake.lua")
