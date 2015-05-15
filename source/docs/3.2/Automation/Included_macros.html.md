---
title: 附带的宏
---

{::options toc_levels="2..6" /}

这里列出了Aegisub自带了几个宏。

## 应用卡拉OK模版 ##
这个是卡拉OK脚本执行器的宏，用法请参见[[卡拉OK脚本执行器|Karaoke_Templater]]。

这个宏只有在字幕文件中至少有一行模版行时才可用。

## 转换为全角字符  ##
将所有ASCII半角字符转为日文的全角字符。

当你想把竖向排版一些翻译的字母“叠”起来时，可能会有用。

这个宏会修改在字幕栏中当前选择的所有行。

{::template name="examplebox"}
这有一个有排版的文本：

    {\fn@DFPGothic-EB\fs26\shad0\fe128\bord3\3c&H25485A&\c&HDEEBF1&\pos(456,184)\frz-90}Sign text

注意这里使用了“@字体”，这是所有CJK字体都有的一种字形，它可以使所有全角字符从基线旋转90度。全角字符不只包括拉丁字母的全角变化版本，日语的假名和日文的汉字、中文的汉字、韩语的汉字以及各种标点符号。

现在运行了这个宏后：

    {\fn@DFPGothic-EB\fs26\shad0\fe128\bord3\3c&H25485A&\c&HDEEBF1&\pos(456,184)\frz-90}Ｓｉｇｎ ｔｅｘｔ

这是运行宏前后对比：

[[img/StackedSign1.png]] [[img/StackedSign2.png]]
{:/}

## Automatic karaoke lead-in  ##
Automatically join several karaoke-timed lines up timing-wise and add
appropriate `\k` tags in front of them.

This macro is designed to help creating karaoke effects, most importantly
creating transitions and lead-ins for lines. It's well suited for using when
the karaoke is timed but before applying effects, such as karaoke templates.

This macro requires at least two lines to be selected and it only works
sensibly if the start-time of each selected line is larger than the
start-time of the selected line that comes before it. It changes the timing
of the selected lines and adds `\k` tags at the start of them except the
first.

{::template name="examplebox"}
Here's two lines of "tightly" timed karaoke:

    Dialogue: 0,0:00:44.46,0:00:46.28,Default,,0000,0000,0000,,{\k15}Ne{\k14}ver {\k14}gon{\k13}na {\k37}give {\k40}you {\k49}up
    Dialogue: 0,0:00:46.57,0:00:48.56,Default,,0000,0000,0000,,{\k13}Ne{\k13}ver {\k13}gon{\k13}na {\k36}let {\k46}you {\k65}down

Both lines start exactly when the first word starts being sung, and they end
exactly when the last word ends.

Now if the _Automatic karaoke lead-in_ macro is run on these two lines, they
are changed into this:
<pre><code>Dialogue: 0,0:00:44.46,<u>0:00:46.28</u>,Default,,0000,0000,0000,,{\k15}Ne{\k14}ver {\k14}gon{\k13}na {\k37}give {\k40}you {\k49}up
Dialogue: 0,<u>0:00:46.28</u>,0:00:48.56,Default,,0000,0000,0000,,<u>{\k29}</u>{\k13}Ne{\k13}ver {\k13}gon{\k13}na {\k36}let {\k46}you {\k65}down
</code></pre>

The start-time of the second line is changed so it matches the end-time of
the first line, and a `\k` tag  is added to the start of the line, to make
up for the shift otherwise created by this. This effectively creates an
empty syllable that can be used as a "spacer" to create fade-in and fade-out
effects.

The macro also shows this message:

    Smallest inter-line duration: 290 milliseconds

This simply says that the smallest duration between two lines it found, was
290 milliseconds, or 0.29 seconds, so that's as much time you have to make
fade-in, fade-out and other transition effects, if you want every
syllable-highlight to be fully visible.
{:/}

## 整理特效标签  ##
这个宏会用不同方式整理所选行的特效标签。

* 合并相邻的特效标签区（即 { … }），如果相邻的两个标签区都有\k标签，则不会合并
* 将\k标签移动到特效标签区的前面（例如将{\frz90\k40}
  转为 {\k40\frz90}）。同时会保持一个区中多个\k标签的顺序
* 移动行标签（即会影响整个行的特效标签—— \a
  \an \org \pos \move \fade \fad）至行首
* 移除第一个以外的行标签（注意：\pos和\move是同一类标签——一行中只有第一个是有效的，因此这个脚本会找出所有的\move或\pos并留下靠前的一个并会删除其他的。同样的也适用于\fad和\fade标签）。
* 移除参数中用来分隔逗号的空格（例如 \pos(200 , 200) 改为  \pos(200,200)）

这个宏也可用作导出滤镜。

The main intended function of this macro is to make
[[karaskel.lua|Automation/Lua/Modules/karaskel.lua]] split karaoke lines more
sensibly into syllable structures, see the example.
这个宏主要功能是为了让[[karaskel.lua|Automation/Lua/Modules/karaskel.lua]]能够更聪明地将卡拉OK行分割为音节结构，请看如下的例子。

这个宏会修改所有字幕栏中所选行，重写这些行里的所有标签区。

{::template name="examplebox"}
原字幕行

    {\r\frz90\k80}Test {\r\fry180\k60}me

Karaskel会创建这些音节结构：


* 0 = {\r\frz90}
* 1 = Test {\r\fry180}
* 2 = me

该行执行 _整理特效标签_ 后：

    {\k80\r\frz90}Test {\k60\r\fry180}me

现在Karaskel会创建这些音节结构：


* 0 = 
* 1 = {\r\frz90}Test
* 2 = {\r\fry180}me

它会把特效标签放到处理过的音节上，所以整理后的版本通常是你想要的。
{:/}

## 添加边角模糊 ##
向所选行插入`[[\be1|ASS_Tags#bluredges]]`标签。轻微模糊所有字幕行的边缘可以显著提高[[内嵌字幕|Attaching_subtitles_to_video]]的压缩率（尤其是使用像XviD这些旧的编码时），但由于字幕格式的限制，边缘模糊无法通过样式来调整。

## 删除特效标签 ##
移除所选行中所有ASS特效标签区和它里面的标签。

## 选择重叠行（Select Overlaps） ##
选择所有在时间上和其他行的时间轴有重叠的行。这个脚本在查找时间轴错误，或者想为这些重叠的行设置一个新样式来提高可读性时会有些帮助。

{::template name="automation_navbox" /}
