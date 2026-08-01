target("unit_test_utils")
    add_files("utils.cpp", {public = true})
    add_files("utils_impl.cpp")
    add_deps("doctest_main")
    set_kind("static")
    set_default(false)
    set_group("unit_test")
target_end()

local should_pass_table = {
    "alternative_macros",
    "asserts_used_outside_of_tests",
    "double_stringification",
    "enums",
    "no_failures",
    "generators",
    "reporters_and_listeners",
}

for _, file in pairs(os.files("*.cpp|utils*.cpp")) do
    local base_name = path.basename(file)
    target("unit_test_"..base_name)
        set_kind("binary")
        add_deps("unit_test_utils")
        set_default(false)
        add_files(file)
        add_tests("test", {should_fail = not table.contains(should_pass_table, base_name)})
    target_end()
end
