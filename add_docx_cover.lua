local usage =
[[
  cover: 表示是否要封面，默认是，不需要的话设置为 false
  version: 版本号
  company: 企业名
  logo: logo 地址
  docxtoc: 是否需要目录，默认是，不需要的话设置为 false
]]
package.path = package.path .. ";" .. PANDOC_SCRIPT_FILE:match(".*/") .. "?.lua"
local fmt = require("fmt")
function prt_tbl(t)
	for k, v in pairs(t) do
		if type(v) == "table" then
			prt_tbl(v)
		else
			print(k, v)
		end
	end
end

local function today()
	return os.date("%Y 年 %m 月 %d 日")
end
function Pandoc(doc)
	local isCover = doc.meta["cover"]
	print(isCover)
	if not isCover and isCover ~= nil then
		return
	end
	local blks = {}
	local v

	v = doc.meta["version"]
	if v then
		blks.version = pandoc.RawBlock("openxml", string.format(fmt.version, v[1].text))
	else
		blks.version = pandoc.RawBlock("openxml", string.format(fmt.version, "0.1"))
	end

	v = doc.meta["company"]
	if v then
		blks.company = pandoc.RawBlock("openxml", string.format(fmt.com, "", "", v[1].text, today()))
	else
		blks.company =
			pandoc.RawBlock(
				"openxml",
				string.format(fmt.com, fmt.defaultDescription, fmt.defaultDomainName, fmt.defaultComName, today())
			)
	end

	v = doc.meta["logo"]
	if v then
		blks.logo = pandoc.Para(pandoc.Image("", v[1].text))
	-- else
	-- 	blks.logo = pandoc.Para(pandoc.Image("logo", fmt.logo, "创意LOGO"))
	end

	v = doc.meta["docxtoc"]
	if v then
		blks.toc = pandoc.RawBlock("openxml", fmt.toc)
	end
	local i = 1
	local order = { "version", "logo", "company", "toc" }
	for _, v in pairs(order) do
		if blks[v] then
			table.insert(doc.blocks, i, blks[v])
			i = i + 1
		end
	end
	return pandoc.Pandoc(doc.blocks, doc.meta)
end
