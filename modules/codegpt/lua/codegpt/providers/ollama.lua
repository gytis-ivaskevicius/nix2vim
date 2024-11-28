local curl = require("plenary.curl")
local Render = require("codegpt.template_render")
local Utils = require("codegpt.utils")
local Api = require("codegpt.api")

OllaMaProvider = {}


local function generate_messages(command, cmd_opts, command_args, text_selection)
    local system_message = Render.render(command, cmd_opts.system_message_template, command_args, text_selection,
        cmd_opts)
    local user_message = Render.render(command, cmd_opts.user_message_template, command_args, text_selection, cmd_opts)

    local messages = {}
    if system_message ~= nil and system_message ~= "" then
        table.insert(messages, { role = "system", content = system_message })
    end

    if user_message ~= nil and user_message ~= "" then
        table.insert(messages, { role = "user", content = user_message })
    end

    return messages
end

local function get_max_tokens(max_tokens, prompt)
    local ok, total_length = Utils.get_accurate_tokens(prompt)

    if total_length >= max_tokens then
        error("Total length of messages exceeds max_tokens: " .. total_length .. " > " .. max_tokens)
    end

    return max_tokens - total_length
end

function OllaMaProvider.make_request(command, cmd_opts, command_args, text_selection)
    -- NOTE Do not use the system message for now
    local messages = generate_messages(command, cmd_opts, command_args, text_selection)
    local max_tokens = get_max_tokens(cmd_opts.max_tokens, prompt)

    local request = {
        temperature = cmd_opts.temperature,
        max_tokens= max_tokens,
        model = cmd_opts.model,
        messages = messages,
        stream = false,
    }

    return request
end

function OllaMaProvider.make_headers()
    return { ["Content-Type"] = "application/json" }
end

function OllaMaProvider.handle_response(json, cb)
    if json == nil then
        print("Response empty")
    elseif json.done == nil or json.done == false then
        print("Response is incomplete " .. vim.fn.json_encode(json))
    elseif json.message.content == nil then
        print("Error: No response")
    else
        local response_text = json.message.content

        if response_text ~= nil then
            if type(response_text) ~= "string" or response_text == "" then
                print("Error: No response text " .. type(response_text))
            else
                local bufnr = vim.api.nvim_get_current_buf()
                if vim.g["codegpt_clear_visual_selection"] then
                    vim.api.nvim_buf_set_mark(bufnr, "<", 0, 0, {})
                    vim.api.nvim_buf_set_mark(bufnr, ">", 0, 0, {})
                end
                cb(Utils.parse_lines(response_text))
            end
        else
            print("Error: No text")
        end
    end
end

local function curl_callback(response, cb)
    local status = response.status
    local body = response.body
    if status ~= 200 then
        body = body:gsub("%s+", " ")
        print("Error: " .. status .. " " .. body)
        return
    end

    if body == nil or body == "" then
        print("Error: No body")
        return
    end

    vim.schedule_wrap(function(msg)
        local json = vim.fn.json_decode(msg)
        OllaMaProvider.handle_response(json, cb)
    end)(body)

    Api.run_finished_hook()
end

function OllaMaProvider.make_call(payload, cb)
    local payload_str = vim.fn.json_encode(payload)
    local default_url =  "http://localhost:11434/api/chat"
    local url = vim.g["codegpt_chat_completions_url"] or default_url
    local headers = OllaMaProvider.make_headers()
    Api.run_started_hook()
    curl.post(url, {
        body = payload_str,
        headers = headers,
        callback = function(response)
            curl_callback(response, cb)
        end,
        on_error = function(err)
            print('Curl error:', err.message)
            Api.run_finished_hook()
        end,
    })
end

return OllaMaProvider
