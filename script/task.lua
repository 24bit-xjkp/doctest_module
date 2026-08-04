task("test_package", function ()
    on_run(function ()
        import("core.base.option")
        import("core.project.config")
        config.load()

        local verbose = option.get("verbose")
        local use_remote_package = option.get("remote")
        local prefix = "${color.build.progress}[test_package]${clear} "

        ---@param args string[]
        ---@return string[]
        local function generate_args(args)
            if verbose then
                table.insert(args, "-v")
            end
            return args
        end

        ---@param args string[]
        ---@return void
        local function run_command(args)
            cprint(prefix .. "xmake " .. table.concat(args, " "))
            os.execv("xmake", args)
        end

        local work_dir = path.join(os.scriptdir(), "..", "test", "package")
        cprint(prefix .. "Enter test directory: %s", work_dir)
        local old_dir = os.cd(work_dir)
        local args = generate_args {
            "config", "-P", ".", "-y", "-c", "--use_local_package=" .. (use_remote_package and "no" or "yes")
        }
        for _, opt_name in ipairs({ "toolchain", "runtimes", "kind", "mode", "use_std_harden" }) do
            ---@type string | nil
            local opt = config.get(opt_name)
            if opt then
                table.insert(args, format("--%s=%s", opt_name, opt))
            end
        end
        run_command(args)

        args = generate_args { "test", "-P", "." }
        run_command(args)
        os.cd(old_dir)
    end)

    set_menu {
        usage = "xmake test_package [options]",
        description = "Test the description of package in the doctest_module project.",
        options = {
            { "r", "remote", "k", nil, "Use remote source of doctest_module" }
        }
    }
end)
