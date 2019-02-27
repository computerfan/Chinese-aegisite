---
title: 剪贴板
---
`clipboard`模块提供读取和写入剪贴板的函数。

## 使用 ##
使用`clipboard = require 'aegisub.clipboard'`{:.language-lua}导入此模块。

### clipboard.get() ###
示例：`text = clipboard.get()`{:.language-lua}

以字符串形式获取剪贴板的当前内容。
如果剪贴板当前不包含文本或发生错误，则返回`nil`。

### clipboard.set() ###
示例：`clipboard.set(new_text)`{:.language-lua}

将剪贴板内容设为指定字符串。
设定成功将返回true，出错则返回false。

{::template name="automation_navbox" /}
