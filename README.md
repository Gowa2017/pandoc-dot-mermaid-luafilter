---
cover: true
docxtoc: true
title: 测试文档
subtitle: 副标题
---

# How to

First, use brew to install graphviz

```sh
brew install graphviz
```

Then, install mermaid cli locally.

```sh
yarn add @mermaid-js/mermaid-cli
```

or

```sh
npm install @mermaid-js/mermaid-cli
```

# Test

```sh
pandoc test.md --lua-filter=dot_mermaid.lua -o test.pdf
pandoc test.md --lua-filter=dot_mermaid.lua -o test.docx
```
