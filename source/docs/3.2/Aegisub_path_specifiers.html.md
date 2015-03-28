---
title: Aegisub路径变量
---

Aegisub使用一个简单的系统来表示文件的位置。大部分Aegisub表示的路径可以用一个特殊变量表示，每个变量都对应一个路径。注意，路径说明符号末尾应该有\，除非它是一个完整路径(例如 ?scripta 就是一个错误写法)。

* **?data**
:   存储应用数据的位置。在Windows下是指Aegisub安装目录(.exe的位置)。在Mac OS X下被包含在应用包里。在其他类POSIX系统下的目录为
    `$prefix/share/aegisub/`.

* **?user**
:   存储用户数据的位置，例如配置文件，自动备份文件和其他附加的东西。在Windows下，这个路径是
    `%APPDATA%\Aegisub\`；
    在Mac OS X下，这个路径是
    `$HOME/Library/ApplicationSupport/Aegisub/`；
    在其他类OSIX系统下，这个路径是
    `$HOME/.aegisub/`；
    在便携版Aegisub中这个目录是 ?data。

* **?temp**
:   系统临时文件目录。音频缓存和临时字幕文件都存储在这个位置。

* **?local**
:   本地用户设置路径。存储运行缓存文件的位置，例如FFMS2索引和字体配置缓存。Windows下为
    %LOCALAPPDATA%\Aegisub 
    其他系统是 ?user。

* **?script**
:   只有当你打开一个已经保存在本地的字幕文件时才有作用，为该字幕文件的保存的位置。

* **?video**
:   只有读取本地视频后才有作用，为当前读取视频文件的路径，注意读取空白视频时是无法使用该路径的。


* **?audio**
:   只有读取本地音频后才有作用，为当前读取音频文件的路径，注意读取空白音频时是无法使用该路径的。
