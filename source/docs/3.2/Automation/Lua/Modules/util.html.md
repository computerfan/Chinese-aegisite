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
无法是别的的颜色字符串会返回`nil`。

{::template name="examplebox"}
~~~ lua
r, g, b, a = extract_color("&H7F&")
~~~

`r`, `g`,  `b` 都是 0; `a` 是 127.
{:/}

### alpha_from_style  ###
Synopsis: `alphastring = util.alpha_from_style(coloralphastring)`{:.language-lua}

Returns the alpha part of a colour string, as an alpha override string, i.e. `&HAA&` format.
This function is a composition of `extract_color` and `ass_alpha`.

### color_from_style  ###
Synopsis: `colorstring = util.color_from_style(coloralphastring)`{:.language-lua}

Returns the colour part of a colour string, as a colour override string, i.e. `&HBBGGRR&` format.
This function is a composition of `extract_color` and `ass_color`.

### HSV_to_RGB  ###
Synopsis: `r, g, b = util.HSV_to_RGB(h, s, v)`{:.language-lua}

Transforms a colour given in Hue, Saturation, Value space into Red, Green, Blue space.

`h` is given in degrees.
The nominal range is 0..359; values outside this range will be translated into it.
Input range of `s` and `v` are 0..1.
These are not range checked.
Output range of `r`, `g` and `b` are 0..255.

## String functions  ##
Because the Lua standard `string` library is fairly limited, a few additional helper functions are provided.
See also [[unicode]].

### string.trim  ###
Synopsis: `outstring = util.trim(instring)`{:.language-lua}

Removes all space characters at the start and end of the input string, and returns the transformed string.

Warning: This function is not UTF-8 safe.
It uses the Lua regex `%s` class to match spaces, which in some legacy encodings will result in it also matching some prefix bytes in UTF-8 encoded text.

### string.headtail  ###
Synopsis: `head, tail = util.headtail(instring)`{:.language-lua}

Splits a string by first space-sequence into a "head" and a "tail", similar to the handling of linked lists in several functional languages.

If `instring` does not contain any space characters it returns `instring, ""`.

### string.words  ###
Synopsis: `for word in util.words(instring) do ... end`{:.language-lua}

Returns an iterator function for use in a `for` loop, to loop over all the words in the string using `string.headtail` semantics.

## Numeric functions  ##
Functions to handle various operations on numbers.

### clamp  ###
Synopsis: `outval = util.clamp(inval, min, max)`{:.language-lua}

Clamps `inval` to be in range `min`..`max`.

### interpolate  ###
Synopsis: `outval = util.interpolate(t, a, b)`{:.language-lua}

Interpolates between `a` and `b`.
`t` is the time variable in range 0..1.
Values outside this range are clamped.

### interpolate_color  ###

Synopsis: `outcolor = util.interpolate_color(t, color1, color2)`{:.language-lua}

Interpolate between `color1` and `color2` with `t` as time variable in range 0..1.
`color1`, `color2` and `outcolor` are colour strings, and `outcolour` will be in colour override format.

### interpolate_alpha  ###
Synopsis: `outalpha = util.interpolate_alpha(t, alpha1, alpha2)`{:.language-lua}

Similar to `interpolate_color`, but interpolates alpha values instead.
Also works on colour strings, and will return an alpha override string.

{::template name="automation_navbox" /}
