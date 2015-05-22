{::options toc_levels="2,3" /}

Aegisub内置了许多lua模块。
一些模块例如 [[karaskel.lua]] 用来实现字幕特效功能，而其他的模块例如 [[re]] 则补充了Lua标准库缺少的部分内容。

## 使用模块 ##
在脚本顶部添加`modulename = require 'aegisub.modulename'` 格式的代码即可。
例如，想要包含 [[re]] 模块，就添加一句:`re = require 'aegisub.re'`.

注意，当你查看一些旧的脚本时，你可能会看见几种不同的包含方法，例如 `include`。
这些是旧版本lua中的写法，已经弃用，建议使用本写法，即Lua 5.2写法。

想使用 [[Karaoke Templater|Automation/Karaoke_Templater]]中的模块，你需要在 [[code once|Automation/Karaoke_Templater/Code_lines_and_blocks#classesofcodelines]] 行中作声明。
注意`karaskel.lua`, `utils.lua` 和 `unicode.lua` 不必在 [[Karaoke Templater|Automation/Karaoke_Templater]] 中声明'需要'，它们已经自动被导入了。

## 模块目录 ##

[[util]]
: 一套常用功能的集合，不符合其他任何明确的分类，在处理颜色方面较为有用。

[[karaskel.lua]]
: 卡拉OK纲要 是为了对打好K值的文本进行高级卡拉OK特效处理而准备的函数集合，它也含有许多帮助函数。

[[unicode]]
: Aegisub传入传出的所有数据通过Automation 4 Lua 接口时都是UTF-8编码，但是Lua 本身不支持这个编码，所以有了这个模块。它也含有些帮助函数。

[[cleantags.lua]]
: 一个用来清除行内特效标签的函数。

[[clipboard]]
: 用于复制粘贴文本的函数。

[[re]]
: 绑定了 ICU(Unicode国际化组件) 正则表达式 [boost.regex](http://www.boost.org/doc/libs/1_53_0/libs/regex/doc/html/index.html), 对Unicode有完整支持，并且有更多Lua内建正则表达式没有的特性。

[lpeg](http://www.inf.puc-rio.br/~roberto/lpeg/)
: PEG 库，用来写解析。

[luabins](https://github.com/agladysh/luabins)
: 一个用来保存表到额外数据或者配置文件的序列化库。

[lfs](http://keplerproject.github.io/luafilesystem/)
: 一些Lua标准库不支持的的文件系统功能。

{::template name="automation_navbox" /}
