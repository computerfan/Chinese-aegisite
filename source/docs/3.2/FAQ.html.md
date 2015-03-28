---
title: FAQ
---

{::options toc_levels="2,3" /}

Aegisub常见问题解答 —— 不一定适合其他地方。

### 卡拉OK特效？ ###

参阅[[卡拉OK模版教程|Automation/Karaoke_Templater/Tutorial_1]]。

### 我能用Aegisub制作DVD字幕吗？ ###

不能直接做，不过有个不错的程序
[MaestroSBT](http://sourceforge.net/projects/maestrosbt/)，可以把SSA字幕转为VOBSubs。
它确实有很多关于标签和其他方面的限制，所以建议先阅读它的说明。还要注意的是它不支持ASS——只支持SSA。您可以使用
Aegisub的文件 -> 导出…对话框来保存成SSA文件。

### Aegisub可以保存SRT文件吗？ ###

可以的，但只意味着没有信息丢失。换句话说，如果有\1c, \b, 或 \i 之外的标签，
Aegisub不允许直接保存到SRT。但是，您仍可导出成SRT文件通过文件 -> 导出…对话框。只需取消所有复选框（clean script info, VFR transform 等等。）。

### 我发现了个Bug！？ ###

把它报告到[bug跟踪系统](http://devel.aegisub.org/)。请在您的报告中描述尽可能多的细节。
请记住，如果Bug不在Bug跟踪系统上，就我们而言它 _并不存在_ 。

### 为什么Aegisub没有 &lt;X 功能&gt;？ &lt;Y 软件&gt; 却有！ ###

很可能是我们不清楚您需要这个功能。
请到[bug跟踪系统](http://devel.aegisub.org/)提出请求，并看看会发生什么。

### 我在哪里可以得到更多的信息和帮助？ ###

对于Aegisub相关的东西，[论坛](http://forums.aegisub.org) 和
 [IRC 频道](irc://irc.rizon.net/aegisub) 是很好的提问的地方。
Aegisub [devel wiki](http://devel.aegisub.org) 也包含了一些因各种原因没有收录在手册中的比较模糊的信息，
论坛也是如此。对于一般的视频相关的问题，一般可以去[Doom9.org](http://www.doom9.org) 和 [它的论坛](http://forum.doom9.org)。

### 是否有一些我该知道的VSFliter的Bug？ ###

一个字：[是](http://asa.diac24.net/VSFilter#BUGS)。
