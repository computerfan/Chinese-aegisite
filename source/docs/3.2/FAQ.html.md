---
title: FAQ
---

{::options toc_levels="2,3" /}

Aegisub常见疑问解答小整合 —— 多半是在其他页面里找不到的问题。

### 卡拉OK特效？ ###

请参阅 [[卡拉OK模版教程|Automation/Karaoke_Templater/Tutorial_1]]。

### 我能用Aegisub制作DVD字幕吗？ ###

不可以直接做，不过有一款不错的软件叫作 [MaestroSBT](http://sourceforge.net/projects/maestrosbt/)，可以把SSA字幕转为VOBSubs。诚然，它在特效标签和其他应用层面也有着诸多限制，所以建议您首先阅读它的说明。还需要特别指出的是，它不支持ASS——只支持SSA。您可以通过Aegisub的“文件 -> 导出…”对话框来将字幕文件保存为SSA格式。

### Aegisub可以保存SRT文件吗？ ###

可以，但是这样说的前提是不会造成信息的丢失。换句话讲，如果文件中含有\1c、\b或\i之外的标签，Aegisub将不允许您直接将其保存为SRT格式。然而，您仍可通过“文件 -> 导出…”(强制性地)将其保存为SRT文件，只需取消勾选所有的复选框(clean script info&lt;清除脚本信息&gt;，VFR transform&lt;转换帧速率&gt;等项目)即可(不过这样做就可能导致部分信息的丢失)。

### 我发现了个Bug！？ ###

请将它报告至 [bug追踪器](http://devel.aegisub.org/)，并且请在您的报告中尽可能多地描述细节！
请记住，如果Bug未被反馈在Bug追踪器上，对我们而言它就相当于 _不存在_ 。

### 为什么Aegisub没有&lt;X 功能&gt;？而&lt;Y 软件&gt; 却有！ ###

这很可能是因为我们不清楚您需要这个功能。
请在 [bug追踪器](http://devel.aegisub.org/) 上提出您的要求，然后看看会发生什么。

### 我在哪里可以得到更多的信息和帮助？ ###

对于Aegisub的相关内容，[论坛](http://forums.aegisub.org) 和 [IRC 频道](irc://irc.rizon.net/aegisub) 都是适合提问的好地方。另外，Aegisub的 [devel wiki](http://devel.aegisub.org) 也包含了一些出于各种原因而未能收录在此手册中(同时也比较晦涩难懂)的信息，论坛亦是如此。至于与视频相关的常见问题，[Doom9.org](http://www.doom9.org) 以及 [它的论坛](http://forum.doom9.org) 是您的首选去处。

### 是否有一些我应当了解的VSFliter的Bug？ ###

用一个字回答您：[是](http://asa.diac24.net/VSFilter#BUGS)。
