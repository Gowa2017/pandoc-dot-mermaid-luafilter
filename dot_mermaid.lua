local os         = require "os"
local pipe       = pandoc.pipe
local stringify  = (require "pandoc.utils").stringify
-- graphviz engines
local engines    = { "dot", "fdp", "circo", "neato", "osage", "twopi" }
local mermaidnum = 0
local mermaiddir = "/Users/gowa/temp/mermaid/"
local dotnum     = 0
local dotdir     = "/Users/gowa/temp/dot/"

-- is a item in array?
local function isInArray(it, arr)
  for _, v in pairs(arr) do if it == v then return true end end
  return false
end

-- is a mermaid block?
local function ismermaid(el)
  for _, v in ipairs(el.classes) do if v == "mermaid" then return true end end
  return false
end

-- which engine will be use
local function get_dot_engine(el)
  for _, v in ipairs(el.classes) do if isInArray(v, engines) then return v end end
  return false
end

-- use command `dot, fdp ...` to render a svg
local function render_dot_code(code, e)
  if FORMAT == "latex" then
    -- body
    local img = pipe("base64", {}, pipe(e, { "-T" .. "svg" }, code))
    return
      pandoc.Para({ pandoc.Image("", "data:image/svg+xml;base64," .. img) })
  elseif FORMAT == "docx" then
    local outfilename = dotdir .. "dot" .. tostring(dotnum) .. ".png"
    local img         = pipe(e, { "-Tpng", "-o" .. outfilename }, code)
    dotnum = dotnum + 1
    return pandoc.Para({ pandoc.Image({}, outfilename) })
  end
end

-- user mermaid cli command mmdc to render memraid code
local function render_memrmaid_code(code)
  local outfilename = mermaiddir .. "mermaid" .. tostring(mermaidnum)
  --   if FORMAT == "latex" then
  --     pipe(os.getenv("HOME") .. "/Repo/luafilter/node_modules/.bin/mmdc",
  --          { "-o", outfilename .. ".svg" }, code)
  --     local f   = io.open(outfilename .. ".svg")
  --     local img = pipe("base64", {}, (f:read("a")))
  --     f:close()
  --     os.remove(outfilename)
  --     mermaidnum = mermaidnum + 1
  --     return
  --       pandoc.Para({ pandoc.Image("", "data:image/svg+xml;base64," .. img) })
  --   elseif FORMAT == "docx" then
  pipe(os.getenv("HOME") .. "/Repo/luafilter/node_modules/.bin/mmdc",
       { "-o", outfilename .. ".png" }, code)
  mermaidnum = mermaidnum + 1
  return pandoc.Para({ pandoc.Image({}, outfilename .. ".png") })
  --   end
end
-- for pdf and docx , change <BR> to soft line break
local function convert_inline_newline(inline)
  if FORMAT == "latex" then
    inline.format = "latex"
    inline.text = "\\\\"
  elseif FORMAT == "docx" then
    inline.format = "openxml"
    inline.text = "<w:r><w:br/></w:r>"
  end
end

-- filter to block element
function block(v)
  if v.t == "CodeBlock" then
    e = get_dot_engine(v)
    if e then
      return render_dot_code(v.text, e)
    elseif ismermaid(v) then
      return render_memrmaid_code(v.text)
    else
      return
    end
  elseif v.t == "Table" then
    -- deal table header
    for _, row in pairs(v.head[2]) do
      for _, cell in pairs(row[2]) do
        for _, block in pairs(cell.contents) do
          for _, inline in pairs(block.content) do
            if inline.t == "RawInline" then
              if string.match(inline.text, "<[BbRr]*.*>") then
                convert_inline_newline(inline)
              end
            end
          end
        end
      end
    end
    -- deal table body
    for k, tbody in pairs(v.bodies) do
      for _, row in pairs(tbody.body) do
        for _, cell in pairs(row[2]) do
          for _, block in pairs(cell.contents) do
            for _, inline in pairs(block.content) do
              if inline.t == "RawInline" then
                if string.match(inline.text, "<[BbRr]*.*>") then
                  convert_inline_newline(inline)
                end
              end
            end
          end
        end
      end
    end
    return v:clone()
  else
    return
  end
end

return { { Block = block } }
