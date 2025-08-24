package.cpath = package.cpath .. ";" .. PANDOC_SCRIPT_FILE:match(".*/") .. "?.so"
--- convert plantuml code to image url
local zlib = require('zlib')
local crypt = require('crypt')

local URL = 'http://118.24.44.71:5000'

local function convert2image(gtype, text)
    local stream = zlib.deflate(9)
    local res, eof, ins, out = stream(text, 'finish')
    return string.format("%s/%s/%s/%s", URL, gtype, FORMAT == "latex" and "svg" or "svg", crypt.base64encode(res):gsub('[+/]', function (c)
        return c=="+" and "-" or "_"
    end))
end

local function dump(o, depth)
    depth = depth or 0
    local prefix = depth and string.rep(' ', depth * 2) or ''
    for k, v in pairs(o) do
        if type(v) == 'table' or type(v) == 'userdata' then
            print(prefix .. k .. '={')
            dump(v, depth + 1)
            print(prefix .. '}')
        else
            if type(k) == 'number' then
                print(prefix .. '[' .. k .. ']=' .. tostring(v))
            else
                print(prefix .. k .. '="' .. tostring(v) .. '"')
            end
        end
    end
end

local function block(v)
    if v.t ~= "CodeBlock" then
        return
    end
    local gtype  = nil
    for _, c in ipairs(v.attr.classes) do
        if c == 'plantuml' or c == 'puml' then
            gtype = 'plantuml'
            break
        elseif c == 'mermaid' then
            gtype = 'mermaid'
            break
        elseif c == 'dot' or c == 'graphviz' then
            gtype = 'graphviz'
            break
        end
    end
    if gtype == nil then return end
    local url = convert2image(gtype, v.text)
    print(url)
    return pandoc.Image('plantuml', url)
end

return { { Block = block } }
