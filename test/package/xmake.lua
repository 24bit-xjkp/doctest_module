set_project("doctest_module_package_test")
set_languages("c++latest")
set_warnings("allextra")
add_rules("mode.debug", "mode.release", "mode.releasedbg")
set_allowedmodes("debug", "release", "releasedbg")
set_defaultmode("release")
set_policy("build.c++.modules", true)
set_policy("package.install_locally", true)
includes("../../script/package.lua", "../../script/option.lua")
add_options("use_std_harden")

option("use_local_package")
    set_default(true)
    set_description("Use local source of doctest_module instead of remote one.")
option_end()

package("my_doctest_module")
    set_base("doctest_module")
    if get_config("use_local_package") then
        set_sourcedir(path.join(os.scriptdir(), "..", ".."))
    end
    set_policy("package.install_always", true)
package_end()

local config = {
    debug = is_mode("debug"),
    configs = { shared = is_kind("shared"), std_harden = get_config("use_std_harden") }
}
add_requires("my_doctest_module", config)

target("test")
    set_kind("binary")
    add_packages("my_doctest_module", { components = "main" })
    add_files("test.cpp")
    add_tests("test")
target_end()

target("test_with_main")
    set_kind("binary")
    add_packages("my_doctest_module", { components = "core" })
    add_files("test.cpp", "main.cpp")
    add_tests("test")
target_end()
