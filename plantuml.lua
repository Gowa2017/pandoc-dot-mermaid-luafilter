--- convert plantuml code to image url
local zlib = require('zlib')
local crypt = require('crypt')

local URL = 'http://42.192.43.15:9999/plantuml/svg/'

local function convert2image(text)
    local stream = zlib.deflate()
    local res, eof, ins, out = stream(text, 'finish')
    return URL .. crypt.base64encode(res)
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
    local ok = false
    for _, c in ipairs(v.attr.classes) do
        if c == 'plantuml' or c == 'puml' then
            ok = true
            break
        end
    end
    if not ok then return end
    local url = convert2image(v.text)
    return pandoc.Image('plantuml', url)
end

return { { Block = block } }
