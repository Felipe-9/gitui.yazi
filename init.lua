return {
    entry = function()
        local output = Command("git"):arg("status"):stderr(Command.PIPED):output()
        if output.stderr ~= "" then
            ya.notify({
                title = "gitui",
                content = "Not in a git directory",
                level = "warn",
                timeout = 5,
            })
        else
            permit = ya.hide()
            local output, err_code = Command("gitui"):stderr(Command.PIPED):output()
            if err_code ~= nil then
                ya.notify({
                    title = "Failed to run gitui command",
                    content = "Status: " .. err_code,
                    level = "error",
                    timeout = 5,
                })
            elseif not output.status.success then
                ya.notify({
                    title = "gitui in" .. cwd .. "failed, exit code " .. output.status.code,
                    content = output.stderr,
                    level = "error",
                    timeout = 5,
                })
            end
        end
    end,
}
