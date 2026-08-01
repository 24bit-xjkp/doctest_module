task("test_package", function ()
    on_run(function ()
        import("core.base.option")
        import("core.project.config")
        config.load()

        local support_type = { "local", "remote" }
        local package_type = option.get("type") or support_type
        local prefix = "${color.build.progress}[test_package]${clear} "
        for _, type in ipairs(package_type) do
            assert(table.contains(support_type, type), [[The package type "%s" is unsupported.]], type)
        end

        for _, type in ipairs(package_type) do
            local work_dir = path.join(os.scriptdir(), "..", "test", type .. "_package")
            cprint(prefix .. "Enter test directory: %s", work_dir)
            local old_dir = os.cd(work_dir)
            local args = { "config", "-P", ".", "-y", "-c" }
            for _, opt_name in ipairs({ "toolchain", "runtimes", "kind", "mode" }) do
                ---@type string | nil
                local opt = config.get(opt_name)
                if opt then
                    table.insert(args, format("--%s=%s", opt_name, opt))
                end
            end
            cprint(prefix .. "xmake " .. table.concat(args, " "))
            os.execv("xmake", args)
            cprint(prefix .. "xmake test -P .")
            os.exec("xmake test -P .")
            os.cd(old_dir)
        end
    end)

    set_menu {
        usage = "xmake test_package [options]",
        description = "Test the description of package in the doctest_module project.",
        options = { { nil, "type", "vs", nil, "The package type (local, remote)." } }
    }
end)
