local version =
    [[
    <w:p>
  <w:pPr>
  <w:jc w:val="center"/></w:pPr>
  </w:pPr>
  <w:r>
  	<w:rPr>
      <w:sz w:val="28"/>
      <w:szCs w:val="28"/>
    </w:rPr>
    <w:t>版本号： v%s</w:t>
  </w:r>
</w:p>
  <w:p>
  <w:pPr>
    <w:jc w:val="center"/>
    <w:spacing  w:line="3200"/>
  </w:pPr>
  <w:r>
        <w:br/>
  </w:r>
</w:p>
]]
local toc =
    [[
    <w:sdt>
    <w:sdtPr>
      <w:docPartObj>
        <w:docPartGallery w:val="Table of Contents"/>
        <w:docPartUnique/>
      </w:docPartObj>
    </w:sdtPr>
    <w:sdtContent>
      <w:p>
        <w:pPr>
          <w:pStyle w:val="TOCHeading"/>
          <w:jc w:val="center"/>
        </w:pPr>
        <w:r>
        <w:rPr>
          <w:sz w:val="36"/>
          <w:szCs w:val="36"/>
          <w:b/>
          <w:bCs/>
        </w:rPr>
          <w:t xml:space="preserve">目录</w:t>
        </w:r>
      </w:p>
      <w:p>
        <w:r>
          <w:fldChar w:fldCharType="begin" w:dirty="true"/>
          <w:instrText xml:space="preserve">TOC \o "1-3" \h \z \u</w:instrText>
          <w:fldChar w:fldCharType="separate"/>
          <w:fldChar w:fldCharType="end"/>
                  <w:br w:type="page"/>
        </w:r>
      </w:p>
    </w:sdtContent>
  </w:sdt>

]]
local com =
    [[
    <w:p>
    <w:pPr>
      <w:widowControl/>
      <w:jc w:val="center"/>
    </w:pPr>
    <w:r>
      <w:rPr>
        <w:rFonts w:ascii="黑体" w:eastAsia="黑体" w:hAnsi="黑体" w:hint="eastAsia"/>
        <w:b/>
        <w:bCs/>
        <w:i/>
        <w:iCs/>
        <w:color w:val="0000FF"/>
        <w:sz w:val="36"/>
        <w:szCs w:val="36"/>
      </w:rPr>
      <w:t>智慧无尽●创意无限</w:t>
    </w:r>
  </w:p>
  <w:p>
    <w:pPr>
      <w:widowControl/>
      <w:jc w:val="center"/>
    </w:pPr>
    <w:r>
      <w:rPr>
        <w:rFonts/>
        <w:b/>
        <w:bCs/>
        <w:color w:val="000000"/>
        <w:sz w:val="36"/>
        <w:szCs w:val="36"/>
      </w:rPr>
      <w:t>%s</w:t>
    </w:r>
  </w:p>
  <w:p>
    <w:pPr>
      <w:jc w:val="center"/>
    </w:pPr>
    <w:r>
        <w:rPr>
        <w:sz w:val="36"/>
        <w:szCs w:val="36"/>
      </w:rPr>
      <w:t>%s</w:t>
          <w:br w:type="page"/>
    </w:r>
  </w:p>  
]]
function prt_tbl(t)
    for k, v in pairs(t) do
        if type(v) == "table" then
            prt_tbl(v)
        else
            print(k, v)
        end
    end
end
function Pandoc(doc)
    local blks = {}
    local v

    v = doc.meta['version']
    if v then
        blks.version = pandoc.RawBlock("openxml", string.format(version, v[1].text))
    end

    v = doc.meta['company']
    if v then
        blks.company = pandoc.RawBlock("openxml", string.format(com, v[1].text, os.date("%Y 年 %m 月 %d 日")))
    else
        blks.company = pandoc.RawBlock("openxml", string.format(com, '创意信息技术股份有限公司', os.date("%Y 年 %m 月 %d 日")))
    end

    v = doc.meta['logo']
    if v then
        blks.logo = pandoc.Para(pandoc.Image("", v[1].text))
    else
        blks.logo = pandoc.Para(pandoc.Image("", '/Users/gowa/Project/gxtelecom/logo.png'))
    end
    
    v = doc.meta['docxtoc']
    if v and not v then
    else
        blks.toc = pandoc.RawBlock("openxml", toc)
    end
    local i = 1
    local order = {"version", "logo", "company", "toc"}
    for _, v in pairs(order) do
        if blks[v] then
            table.insert(doc.blocks, i, blks[v])
            i = i + 1
        end
    end
    return pandoc.Pandoc(doc.blocks, doc.meta)
end
