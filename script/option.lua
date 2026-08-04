option("check_kind", function ()
    set_values(false)
    set_showmenu(false)
    set_description([[Check the build kind. "static" and "shared" are supported.]])

    on_check(function (option)
        local kind = get_config("kind")
        assert(kind == "static" or kind == "shared", [[The kind "%s" is not supported.]], kind)
        option:enable(true)
    end)
end)

option("use_std_harden", function ()
    set_default(false)
    set_description("Enable c++ standard library harden.")
    local defines
    if is_mode("debug") then
        defines = { "_LIBCPP_HARDENING_MODE=_LIBCPP_HARDENING_MODE_DEBUG", "_GLIBCXX_DEBUG" }
    else
        defines = { "_LIBCPP_HARDENING_MODE=_LIBCPP_HARDENING_MODE_FAST", "_GLIBCXX_ASSERTIONS" }
    end
    add_defines(defines)
end)
