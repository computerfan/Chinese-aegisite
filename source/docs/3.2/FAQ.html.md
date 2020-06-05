---
title: FAQ
---

{::options toc_levels="2,3" /}

Aegisub 的常见疑问小整合——大多是其他页面没有涉及的问题。

### 制作卡拉OK特效？ ###

请阅读 [[卡拉OK模版教程|Automation/Karaoke_Templater/Tutorial_1]]。

### 我能用 Aegisub 制作 DVD 字幕吗？ ###

不能直接做，不过有一款实用的软件叫作 [MaestroSBT](https://sourceforge.net/projects/maestrosbt/)，它可以将 SSA 转换为 VOBsub。由于这款软件在特效标签以及其他方面有着诸多限制，所以建议您先阅读一下它的说明。还需特别注意，它不支持 ASS——只支持 SSA。您可以在 Aegisub 的“*文件 -> 导出字幕…*”对话框中将字幕另存为 SSA 格式。

### Aegisub 可以将字幕保存为 SRT 文件吗？ ###

可以，但前提是不会造成信息的丢失。换言之，如果字幕中含有除了 `\1c`、`\b` 或 `\i` 以外的标签，Aegisub 就无法将其直接保存为 SRT。然而，您仍然可以通过“*文件 -> 导出字幕…*”（强制地）将其保存为 SRT 文件，只需取消勾选所有的复选框（整理特效标签、帧率转换等）即可。

### 我发现了一个 bug！？ ###

请将它报告至 [Bug 跟踪系统](http://devel.aegisub.org/)，并请您在报告中描述尽可能多的细节！记住，未被反馈在 Bug 跟踪系统上的 bug 对我们而言就相当于*不存在*。

### 为什么 Aegisub 没有&lt;X 功能&gt;？&lt;Y 软件&gt;却有！ ###

这很可能是因为我们不了解您的需求。请在 [Bug 跟踪系统](http://devel.aegisub.org/) 上提出您的需求，然后静观其变。

### 哪里可以获取更多的信息与帮助？ ###

对于 Aegisub 相关的问题，[论坛](http://forums.aegisub.org) 和 [IRC 频道](irc://irc.rizon.net/aegisub) 都是适合提问的地方。此外，Aegisub 的 [开发 wiki](http://devel.aegisub.org) 与论坛中还会有一些未收录在手册中的、比较生僻冷门的内容。至于与视频相关的一般问题，可以到 [Doom9.org](http://www.doom9.org) 以及 [它的论坛](http://forum.doom9.org) 上看看。

### 是否有我应当了解的 VSFliter 的 bug？ ###

一个字：[是](http://asa.diac24.net/VSFilter#BUGS)。
