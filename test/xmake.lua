target("unit_test")
    add_files("utils*.cpp")
    add_deps("doctest_main")
    set_kind("binary")
    set_default("false")

    for _, file in pairs(os.files("*.cpp|utils*.cpp")) do
        local base_name = path.basename(file)
        add_tests(base_name, {files = file, should_fail = true})
    end
target_end()
