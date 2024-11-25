local versionFmt =
    [[
  <w:p>
  <w:pPr>
    <w:jc w:val="center"/>
    <w:spacing  w:line="2000"/>
  </w:pPr>
  </w:p>
  <w:p>
    <w:pPr>
    <w:jc w:val="center"/>
      <w:spacing  w:line="2000"/>
    </w:pPr>
    <w:r>
        <w:rPr>
          <w:rFonts w:ascii="楷体" w:eastAsia="楷体" w:hAnsi="楷体" w:hint="eastAsia"/>
          <w:b/> <w:bCs/>
          <w:color w:val="000000"/>
          <w:sz w:val="28"/> <w:szCs w:val="28"/>
        </w:rPr>
      <w:t>版本号： v%s</w:t>
    </w:r>
  </w:p>
]]
local tocFmt =
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
        <w:r>
          <w:fldChar w:fldCharType="begin"/>
          <w:instrText xml:space="preserve">TOC \o "1-3" \h \z \u</w:instrText>
          <w:fldChar w:fldCharType="separate"/>
          <w:fldChar w:fldCharType="end"/>
        </w:r>
      </w:p>
    </w:sdtContent>
  </w:sdt>
  <w:br w:type="page"/>
]]
local comFmt =
    [[
<w:p>
    <w:pPr>
      <w:widowControl/>
      <w:jc w:val="center"/>
    </w:pPr>
    <w:r>
      <w:rPr>
        <w:rFonts w:ascii="黑体" w:eastAsia="黑体" w:hAnsi="黑体" w:hint="eastAsia"/>
        <w:b/> <w:bCs/>
        <w:i/> <w:iCs/>
        <w:color w:val="0000FF"/>
        <w:sz w:val="28"/> <w:szCs w:val="28"/>
      </w:rPr>
      <w:t>%s</w:t>
    </w:r>
</w:p>
<w:p>
    <w:pPr>
      <w:widowControl/>
      <w:jc w:val="center"/>
    </w:pPr>
    <w:r>
      <w:rPr>
        <w:rFonts w:ascii="黑体" w:eastAsia="黑体" w:hAnsi="黑体" w:hint="eastAsia"/>
        <w:b/> <w:bCs/>
        <w:u w:val="single"/> <w:uCs w:val="single"/>
        <w:color w:val="0000ff"/>
        <w:sz w:val="36"/> <w:szCs w:val="36"/>
      </w:rPr>
      <w:t>%s</w:t>
    </w:r>
</w:p>
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
      <w:sectPr w:rsidR="0006207D" w:rsidRPr="00635692">
        <w:pgSz w:w="11900" w:h="16840"/>
        <w:pgMar w:top="1440" w:right="1588" w:bottom="1440" w:left="1588" w:header="720" w:footer="720" w:gutter="0"/>
        <w:pgNumType w:start="1" w:chapStyle="1" w:chapSep="emDash"/>
        <w:cols w:space="720"/>
        <w:docGrid w:linePitch="326"/>
      </w:sectPr>
    </w:pPr>
    <w:r>
        <w:rPr>
        <w:sz w:val="36"/>
        <w:szCs w:val="36"/>
      </w:rPr>
      <w:t>%s</w:t>
    </w:r>
</w:p>  
]]
local logo = "/Users/gowa/Nutstore Files/我的坚果云/logo.png"

return {
    version = versionFmt,
    toc = tocFmt,
    com = comFmt,
    logo = logo,
    defaultComName = "",
    defaultDomainName = "",
    defaultDescription = ""
}
