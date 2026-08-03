package("clean_std_heads", function ()
    set_homepage("https://github.com/YexuanXiao/convert-cpp-std-headers-to-std-module")
    set_description("A library for helping to convert #include standard library headers to import std;")
    set_urls("https://github.com/YexuanXiao/convert-cpp-std-headers-to-std-module.git")
    add_versions("1.0", "73b5212319bc9dab6a0bdc12afed5036b153bb7e")
    add_versions("1.1", "00ae6cc3184d9e55cae67fc9ff305a235b968e6e")
    set_kind("library", { headeronly = true })

    on_install(function (package)
        os.cp("clear_all_cpp_std_headers.h", package:installdir("include"))
    end)

    on_test(function (package)
        assert(package:has_cxxincludes("clear_all_cpp_std_headers.h"))
    end)
end)

package("doctest_module", function ()
    set_homepage("https://github.com/24bit-xjkp/doctest_module")
    set_description("Use doctest framework as C++20 module.")
    add_urls("https://github.com/24bit-xjkp/doctest_module.git")
    add_deps("clean_std_heads >=1.1", "doctest")
    add_configs("main", { description = "Enable main function support.", default = true, type = "boolean" })
    add_configs(
        "std_harden", { description = "Enable c++ standard library harden.", default = false, type = "boolean" }
    )

    on_component("core", function (_, component)
        component:add("links", "doctest")
    end)

    on_component("main", function (_, component)
        component:add("deps", "core")
        component:add("links", "doctest_main")
    end)

    on_load(function (package)
        package:add("components", "core")
        if package:config("main") then
            package:add("components", "main")
        end
    end)

    on_install(function (package)
        local config = { with_main = package:config("main"), use_std_harden = package:config("std_harden") }
        import("package.tools.xmake").install(package, config)
    end)

    on_test(function (package)
        assert(package:has_cxxincludes("doctest_macros.hpp"))
    end)
end)
