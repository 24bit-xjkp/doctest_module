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
    add_defines(
        "_LIBCPP_HARDENING_MODE=_LIBCPP_HARDENING_MODE_" .. (is_mode("debug") and "DEBUG" or "FAST"),
        "_GLIBCXX_ASSERTIONS"
    )
end)

option("with_main", function ()
    set_default(true)
    set_description("Enable main function support.")
end)
