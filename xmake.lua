set_project("doctest_module")
set_languages("c++latest")
set_warnings("allextra")
includes("script/*.lua")
add_rules("mode.debug", "mode.release", "mode.releasedbg")
set_allowedmodes("debug", "release", "releasedbg")
add_requires("clean_std_heads", "doctest")
add_packages("clean_std_heads", "doctest")

option("check_kind")
    set_values(false)
    set_showmenu(false)
    set_description([[Check the build kind. "static" and "shared" are supported.]])

    on_check(function (option)
        local kind = get_config("kind")
        assert(kind == "static" or kind == "shared", [[The kind "%s" is not supported.]], kind)
        option:enable(true)
    end)
option_end()

option("with_main")
    set_default(true)
    set_description("Enable main function support.")
option_end()

option("use_std_harden")
    set_default(false)
    set_description("Enable c++ standard library harden.")
    local defines
    if is_mode("debug") then
        defines = {"_LIBCPP_HARDENING_MODE=_LIBCPP_HARDENING_MODE_DEBUG", "_GLIBCXX_DEBUG"}
    else
        defines = {"_LIBCPP_HARDENING_MODE=_LIBCPP_HARDENING_MODE_FAST", "_GLIBCXX_ASSERTIONS"}
    end
    add_defines(defines)
option_end()
add_options("use_std_harden")

includes("*/xmake.lua")
