---
title: 自动化
---

**自动化**这个名字包括了Aegisub全部的脚本功能。

## 关于自动化
自动化的目的单纯得就像名字一样——能够自动完成字幕创作和编辑的不同的功能。
原本主要用于创作[[卡拉OK特效|Glossary/Karaoke_effect]]，但随着时间推移，用法也变得多样，支持更多的通用[[宏|Glossary/Macro]]来向Aegisub添加新的功能。

自动化的目的：

* 通过宏操作实现复杂的字幕编辑任务
* 从简单的输入通过滤镜生成复杂的效果
  * 卡拉OK特效
  * 翻译注解框
* 也许还有一些未发现的用途

## 使用自动化
Aegisub内置了一些自动化脚本，可以直接使用。其中包括高级的卡拉OK模板执行器 **[[Karaoke_Templater]]** 脚本和 **[[几个宏操作(collection of macros)|Included_macros]]** 来简化一些编辑任务。

Aegisub通常是一次加载多个脚本。您能从**[[自动化脚本管理器|Automation/Manager]]** 中看到加载了哪些脚本，或者加载、移除更多的脚本。

所有的自动化脚本都有显现在Aegisub里的方式。一些[[以宏的形式出现在自动化菜单|Running_macros]]中，一些作为[[导出时的滤镜|Exporting]]，
一些脚本在这两处都出现。

## 适合于程序员的自动化  ##
自动化使用[LuaJIT 2.0](http://luajit.org/)来编译[5.2版的Lua](http://www.lua.org/manual/5.2/)。
[MoonScript](http://www.moonscript.org)是原生支持的（事实上Aegisub的部分库也是用它编的）。

Aegisub有一些内置的示例脚本，希望能对您写出自己的脚本有启发。
警告：除非您是经验丰富的程序员， _kara-templater.lua_ 脚本不是一个好的学习起点！

{::template name="automation_navbox" /}
