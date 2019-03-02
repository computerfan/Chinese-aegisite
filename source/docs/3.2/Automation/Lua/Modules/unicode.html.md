 `unicode`模块包含一系列为Auto4设置的辅助函数，主要用来处理 UTF-8 编码的文本。

## 用法 ##
用 `unicode = require 'aegisub.unicode'`{:.language-lua}导入模块。

## unicode.charwidth  ##
摘要：`width = unicode.charwidth(instring, index=1)`{:.language-lua}

返回使用UTF-8编码时，在`instring`中位于`index`的代码点（code point）所占用的字节数。指向的字符会被假定是一种前缀字节（也就是代码点的首字节）。

`index`参数是可选的，不填时其默认值为1，意为返回`instring`的首字符宽度。

## unicode.chars  ##
摘要：`for char in unicode.chars(instring) do ... end`{:.language-lua}

返回一个迭代器函数用于循环所给的UTF-8编码字符串中的每一个代码点。
对于循环中的每次迭代，`char`会包含表示字符串中下一代码点的字符串。此字符串长度可能会大于一字节。

## unicode.len  ##
摘要：`length = unicode.len(instring)`{:.language-lua}

以代码点为单位判断所给UTF-8编码的字符串的长度。

注意此函数的时间复杂度不为常数阶，而是与`instring`所含代码点的数量成比例的线性阶（O(N)）。

## unicode.codepoint  ##
摘要：`val = unicode.codepoint(instring)`{:.language-lua}

读取`instring`中的首个Unicode代码点。

## unicode.to_upper_case
摘要：`upper = unicode.to_upper_case(instring)`{:.language-lua}

将一个字符串转换为大写。
此函数可处理读音符号、非拉丁文字等文本。

## unicode.to_lower_case
摘要：`lower = unicode.to_lower_case(instring)`{:.language-lua}

将一个字符串转换为小写。
此函数可处理读音符号、非拉丁文字等文本。

## unicode.to_fold_case
摘要：`folded = unicode.to_fold_case(instring)`{:.language-lua}

将一个字符串折叠大小写（fold case）。
这种模式类似于小写，但对语种不敏感，因此用在大小写不敏感的对比时会有更好的表现。


{::template name="automation_navbox" /}
