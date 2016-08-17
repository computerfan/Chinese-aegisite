Automation 4 Lua脚本引擎基于5.1版本的[Lua脚本语言](http://www.lua.org)。

此手册不会涉及Lua语言本身与Lua附带的标准库，而只会介绍Aegisub Automation 4附加的功能和数据结构。请参阅[Lua 5.1 手册](http://www.lua.org/manual/5.1/)来了解语言本身和它的标准库。



## Automation 4 Lua 机制的总体概述  ##
最简单合法的Automation 4 Lua脚本是一个空文件，但显然它并不能做什么有趣的事。

一个脚本可以设置一些全局变量来提供关于脚本的信息，这些信息会在[[自动化脚本管理器|Automation/Manager]]窗口中展示，包括：`脚本名称`、`脚本描述`、`脚本作者`以及`脚本版本`。

Automation 4 Lua可同时实现当前Automation 4所具有的两种“功能”：宏和导出滤镜，一个脚本（一个文件）可有零个、一个或多个功能。例如卡拉OK模版执行器脚本定义了一个宏和一个导出滤镜的功能。

当加载Automation 4 Lua脚本后，会执行一次脚本的顶级代码。你可以在顶级放入初始化变量等代码，不过你常常需要定义一些全局的脚本信息、导入一些模块、写一些让脚本工作的函数 并需要调用注册功能的函数。这些内容在**[[注册Lua|Automation/Lua/Registration]]**页面会有说明。载入脚本时`aegisub`对象唯一接触的域是`lua_automation_version`和注册用函数。大多数其它的部分不会做什么并返回`nil`。

当用户在Aegisub界面启用一个功能（例如在自动化菜单中选择一个宏）时，脚本注册函数会被执行。被传递给函数的参数之一 是一个脚本操作字幕数据的主要接口 _字幕对象(subtitles object)_。字幕对象一定程度上是一个整数为索引的数组，但它也展示出一些特殊接口可以来增加、移除或修改字幕行。字幕对象允许你访问字幕文件的每一行，包括文件头部、样式定义、对话行以及注释行。这些内容会在**[[字幕接口|Automation/Lua/Subtitle_file_interface]]**页面提供详细说明。

Automation 4 Lua还在核心API中提供一些辅助函数来获取信息，例如视频帧的时间戳，一行文本以给定的样式呈现时的大小。

大多数的需求都可以用简洁的Lua代码实现，由于很多功能已经在核心API之外以[[Lua 模块|Modules]]的形式实现，因而不必再直接依赖Aegisub的内部数据结构。虽然这使你不依靠提供的标准include文件来写Automation 4 Lua脚本成为可能，但你会发现任何脚本即便是十分简单的也会多少用到includes提供的函数。

## Automation 4 Lua 核心 API  ##
Automation 4 Lua 提供的多种API可分为以下这些类别。

[[脚本及功能注册|Automation/Lua/Registration]]
: 用来处理标注脚本提供的功能和一些其他的脚本元数据。

[[字幕文件接口|Automation/Lua/Subtitle_file_interface]]
: 用来处理使用 _字幕_ 对象，访问和修改字幕数据的主要方式。

[[进度报告和debug输出|Automation/Lua/Progress_reporting]]
: 在脚本运行时向用户提供反馈，向用户输出提示和警告，并打印debug信息。

[[显示对话框和获取用户输入|Automation/Lua/Dialogs]]
: 通过在宏执行过程中弹出对话框请求用户输入，以及为导出滤镜提供选项界面。

[[其他的APIs|Automation/Lua/Miscellaneous_APIs]]
: 例如获取渲染后的文本大小，和获取视频帧率信息。

{::template name="automation_navbox" /}
