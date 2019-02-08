---
title: util
---

Automation 4 Lua include的文件 `utils.lua` 包括了多种不同的辅助函数来帮助你写Lua脚本。
这个文件并没有统一的主题。

## 用法 ##
使用 `util = require 'aegisub.util'`{:.language-lua} 来导入这个模块。

## Table functions  ##
以多种方式复制一个table是经常要做的工作之一。
`util` 提供了一些函数来解决这些问题。

### copy  ###
摘要: `newtable = util.copy(oldtable)`{:.language-lua}

制作参数table的浅拷贝。
浅拷贝意味着它不会访问和复制table中的table。
举个例子, 如果 `oldtable.st` 指某table, `newtable.st` 指某相同table, 对 `newtable.st`的更改也会反映到 `oldtable.st` 中，反之亦然。

### deep_copy  ###
摘要: `newtable = util.deep_copy(oldtable)`{:.language-lua}

制作参数table的深拷贝。
虽然这个函数试图处理循环引用而不是对它们进行无限递归，但它可能不适用于所有情况。
你基本用不到这个函数。
如果你认为需要进行深拷贝，请考虑任务额外时间。

## 颜色函数  ##
这类函数对于不同类型的颜色数据转换来说是十分有用的。
有以下这些函数

### ass_color  ###
摘要: `colorstring = util.ass_color(r, g, b)`{:.language-lua}

给定 `r`, `g` , `b` 数值，返回ASS的 `&HBBGGRR` 颜色格式字符串。

警告:本函数并不含有颜色输入范围检查功能。
如果你用了0~255之外的数值，返回的是什么鬼就不一定了。

### ass_alpha  ###
摘要: `alphastring = util.ass_alpha(a)`{:.language-lua}

给定 `a` 数值，返回ASS的 `&HAA&` 透明度格式字符串。

不具有输入范围检查(0~255)

### ass_style_color  ###
摘要: `colorstring = util.ass_style_color(r, g, b, a)`{:.language-lua}

生成ASS样式使用的颜色格式字符串，也就是`&HAABBGGRR`。

不具有输入范围检查。

### extract_color  ###
摘要: `r, g, b, a = util.extract_color(colorstring)`{:.language-lua}

从一个颜色字符串中导出色值。支持识别以下几种:

* 样式定义: `&HAABBGGRR`
* 行内颜色标签: `&HBBGGRR&`
* 行内透明度标签: `&HAA&`
* 带透明度的HTML: `#RRGGBBAA`

注意，当输入一个有效的颜色字符串，本函数一般会返回四个数值。
无用的部分会被置0。
无法识别的的颜色字符串会返回`nil`。

{::template name="examplebox"}
~~~ lua
r, g, b, a = extract_color("&H7F&")
~~~

`r`, `g`,  `b` 都是 0; `a` 是 127.
{:/}

### alpha_from_style  ###
摘要: `alphastring = util.alpha_from_style(coloralphastring)`{:.language-lua}

返回一个颜色字符串的透明度部分，作为一个透明度标签，`&HAA&` 格式。
这个函数是 `extract_color` 和 `ass_alpha` 的组成部分。

### color_from_style  ###
摘要: `colorstring = util.color_from_style(coloralphastring)`{:.language-lua}

返回一个颜色字符串的颜色部分，作为一个颜色标签， `&HBBGGRR&` 格式。
这个函数是 `extract_color` 和 `ass_color` 的组成部分。

### HSV_to_RGB  ###
摘要: `r, g, b = util.HSV_to_RGB(h, s, v)`{:.language-lua}

将输入的色相，饱和度和明度转化为RGB值。
`h` 是角度定义，范围 0..359，不在范围内的值会被转换回360以内
 `s` 和 `v` 范围在 0..1 之间。
无输入范围检查
输出的 `r`, `g` , `b` 范围是 0..255。

## 字符串函数  ##
因为lua标准的 `string` 库功能十分有限, 这里提供了一些额外的辅助函数。
可以参见 [[unicode]] 。

### string.trim  ###
摘要: `outstring = util.trim(instring)`{:.language-lua}

移除输入字符串中首尾的空格。

警告: 这个函数和 UTF-8 的兼容性并未完全确认。
它使用 Lua 的正则 `%s` 类来匹配空格，当遇到一些传统的编码时可能会出现问题。

### string.headtail  ###
摘要: `head, tail = util.headtail(instring)`{:.language-lua}

利用字符串中首个空格将其分割成 "头" 和 "尾" 两部分。

如果 `instring` 中不含有空格，则会返回 `instring, ""`.

### string.words  ###
摘要: `for word in util.words(instring) do ... end`{:.language-lua}

返回一个迭代器函数，可以用于 for 循环中，本质是使用 `string.headtail` 多次。

## 数学函数  ##
一些用来对数字进行操作的函数。


### clamp  ###
摘要: `outval = util.clamp(inval, min, max)`{:.language-lua}

返回的outval介于min、max之间，若inval小于min，返回min，若大于max，返回max。


### interpolate  ###
摘要: `outval = util.interpolate(t, a, b)`{:.language-lua}

在 `a` 和 `b`之间插值
`t` 代指倾向a还是b，取值范围0-1。
如果取值到了[a,b]范围外，则会被clamp。

### interpolate_color  ###

摘要: `outcolor = util.interpolate_color(t, color1, color2)`{:.language-lua}

在 `color1` 和 `color2` 之间插值 `t` 含义与上文相同。
`color1`, `color2` 和 `outcolor` 是颜色字符串， `outcolour` 是ASS格式颜色字符串。

### interpolate_alpha  ###
摘要: `outalpha = util.interpolate_alpha(t, alpha1, alpha2)`{:.language-lua}

和 `interpolate_color` 相似，但是对象是透明度字符串。

{::template name="automation_navbox" /}
