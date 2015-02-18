{::options toc_levels="2,3" /}

Aegisub是可高度定制的软件，因而它有大量的选项供用户选择。这些选项都在选项对话框中，您可以在“查看”菜单里找到。这个页面提供可用选项的说明。

Aegisub将所有配置都以纯文本的形式储存在 _config.json_ 文件中，它默认位于[[?user|Aegisub_path_specifiers]]目录。
如果您想恢复默认设置而不想重装Aegisub的话，您只需把config.json删掉并重启Aegisub即可。

## 通用 ##

[[img/preferences-general.png]]{: class="center"}
**自动检查更新**
: 如果启用，Aegisub会定期检查是否有新版本可用，如果有就会提醒您。
当然，这需要您的电脑能接入互联网。

**显示主工具栏**
: 如果禁用，Aegisub的主要工具栏会被隐藏。

**在字幕文件中保存用户界面状态**
: 默认情况下，Aegisub会在字幕文件中保存当前滚动到的位置和所选行的编号，以便您在下次打开字幕文件时可以自动恢复到保存时的状态。不过，如果您对您的字幕文件使用版本控制的话，您可能希望关闭这个功能来减少对更改的干扰。

**工具栏图标大小**
: Aegisub所有工具栏的图标的大小。目前有效值仅为16或24。

**自动载入链接的文件**
: 当您保存脚本时，Aegisub同时也在字幕文件里保存了您打开的音视频和时间码文件的信息。
这个选项决定了Aegisub在打开字幕文件时，如何处理这些与字幕文件所关联的文件。如果设为“询问”，Aegisub会在打开文件时让您选择是否加载链接的文件。如果设为“从不”，Aegisub不会加载链接的文件，同样的如果设为“总是”，Aegisub将尝试载入关联的文件（并会在找不到相关文件时弹出错误报告）。

**恢复操作的最大数量**
: 改变撤销的最大数量。这个值越大，Aegisub将占用的内存就越多。

**最近使用过的列表**
: Aegisub的各种最近使用列表记录的项目的最大值。它对内存几乎没有影响，但太长的列表看起来会不方便。

### 默认样式

[[img/preferences-default-styles.png]]{: class="center"}

## 音频 ##

[[img/preferences-audio.png]]{: class="center"}
**锁定光标卷动**
: 当启用时，当视频播放光标离音频波形视图左右边缘较近时，波形将自动随着光标滚动。

**默认紧贴标记**
: 当启用时，如果两个音频视图的标记（例如关键帧，其他行的开始结束时间点）离得足够近的话，Aegisub会在您点击或拖动音频标记时，把它们吸附到音频视图的其他标记上。
您可以按住shift再拖动来临时开启或关闭吸附功能。

**默认使用鼠标滚轮缩放**
: 当启用时，鼠标滚轮默认会用来水平缩放频谱视图，按住Ctrl键时滚动频谱视图。如果禁用则相反。

**随鼠标移动自动定位**
: 如果启用，当鼠标光标移动到音频频谱上将会自动激活它（而不需要再单击一下）。

**在视频步进时播放音频**
: 当启用时，视频按帧步进时会播放那帧的音频。

**默认计时长度**
: 新建行的默认持续时间，单位为毫秒。

**默认提前开始时间长度**
**默认延后结束时间长度**
: 使用“开始时间提前”和“结束时间延后”功能所增加的时间长度。同时也可在[[时间后续处理器|Timing_Post-Processor]]里使用和设置。

**标记拖动灵敏度**
: 能够视为拖动的鼠标移动的像素距离。较高的值可以降低误操作的可能，不过响应能力会降低。

**左键点击拖动动作结束标记**
: 当启用时，左键单击频谱的某一位置会设置一行的开始时间点，然后拖动到的地方会设为结束时间点，
使得打一行轴只需简单的单击——拖动就可完成。当禁用时，左键单击并拖动只会设置一行的开始时间，需要再右击来设置结束时间。

**边线宽度**
: 行的开始和结束标记的宽度，单位为像素。

**最大紧贴标记距离**
: 在这个距离内的标记会自动吸附，单位为像素。

**显示非活动行**
: 控制当前行附近的行将如何显示在音频波形视图上。“不显示”将只会显示当前行。“显示前一个”将用灰色显示除当前行的上一行（是字幕栏里的上一行， _不是_ 按时间顺序）。“显示前一个和下一个”将会用灰色显示当前行的前一行和后一行。“显示全部”将会用灰色显示除当前行之外的所有行。

**包括非活动注释行**
: 如果禁用，注释行将会被跳过，例如“显示前一个”会变成“显示前一个非注释行”。

### 显示/视觉选项 ###

**关键帧**
: 如果启用，视频关键帧将会在默认情况下以线条的形式标记在音频波形视图上。

**卡拉OK模式关键帧**
: 如果启用，视频关键帧将会在卡拉OK模式下以线条的形式标记在音频波形视图上。

**显示光标所在的时间**
: 如果启用，会在音频波形上方显示出光标所指位置的时间点。

**显示视频位置**
: 如果启用，视频当前帧的开始时间会以线条的形式标记在音频波形视图上。

**波形样式**
: 选择使用何种波形渲染样式

    最大 + 平均
    : 波形会是两个通道，其中一个表示一个像素的时间范围内最大的一个音频样本的值，用较亮的颜色表示，和所有音频样本的平均值。

    最大
    : 波形只显示最大值，和之前的Aegisub版本一样。

### 音频标签 ###
这些选项控制在音频栏显示的卡拉OK音节的外观。

**字体**
:   音频标签所用的字体。

**字体大小**
:   音频标签的字体大小。

## 视频 ##

[[img/preferences-video.png]]{: class="center"}
**在滑动条上显示关键帧**
: 当启用时，Aegisub会在视频进度条上显示关键帧。

**选择的行改变后，视频位置变为所选行的开始时间**
: 当启用时，每当所选的行改变后，Aegisub都会自动将视频播放位置移至所选行的第一帧。
注意双击行或者按Ctrl+1也可以实现这个功能。

**只有当鼠标处在视频上时才显示可视化编辑工具**
: 当启用时，可视化编辑工具只有在光标处在视频上时才会显示。

**打开视频时自动加载音频**
: 当启用时，当您打开的视频文件包含音轨，Aegisub将会自动加载音频。

**默认缩放**
: 默认视频缩放级别。当您的屏幕非常大或非常小时很有用。

**快速步进帧数**
: 决定当您使用快速步进功能（Alt+左方向键 和 Alt+有方向键）时一步“跳”多远。以帧为单位。

**截图保存路径**
: 决定Aegisub把截图保存到哪。默认位置是`?video`，就是存到视频文件所在的文件夹，但您可以改成您想要的路径。支持[[Aegisub路径表示符|Aegisub_path_specifiers]]；下拉菜单里另一个可选选项是`?script`，即保存到字幕文件的位置。

### 脚本分辨率 ###

**使用第一次打开的视频的分辨率**
: 当启用时，如果您打开了一个视频，且当前脚本没有设置分辨率，Aegisub将会自动把视频分辨率设为脚本分辨率。如果禁用，Aegisub会将脚本分辨率设为下面指定的默认分辨率。

**在打开时匹配视频分辨率**
: 设置Aegisub在您打开视频时如何处理脚本分辨率。
如果设为“从不”，Aegisub在视频和脚本分辨率不同时不会做任何事。如果设为“询问”，Aegisub在视频和脚本分辨率不同时会询问您是否改变脚本分辨率来适应视频。如果设为“使用视频分辨率”，则自动将脚本分辨率直接设为视频分辨率。如果设为“重设分辨率”则会重设脚本的分辨率来匹配视频。

## 界面 ##

[[img/preferences-interface.png]]{: class="center"}

**启用提示**
: 当启用时，Aegisub将自动识别您打的[[特效标签|ASS_Tags]]，并显示一个这个标签的语法提示框，直至您闭合这个标签。这个功能叫做“语法提示”，和一些编程集成开发环境(IDE)的体验相似。

**时间框内覆盖写入**
: 控制这个程序里所有时间编辑框的行为。默认情况下，Aegisub的所有时间编辑框就像您按下Insert键一样，所以您输入的每个数字都会覆盖已经存在的数字，并且无法删除已存在的数字，您只能覆盖它们。取消这个选项来禁用这个功能，并让所有时间编辑框像（大部分）常规文本编辑框一样。

**启用语法高亮**
: 启用或禁用主编辑框特效标签的语法高亮功能。

**字典文件路径**
: 决定Aegisub将在哪里寻找拼写检查和同义词词典文件。默认会在`?data/dictionaries`里找，但如果您在其他目录有自己的词典，您可以随意把它改为其他的目录。

**字体**
: 决定字幕编辑框和其他编辑框中文字的字体和字体大小。

**每行最大字符数**
: If the value of the character counter is higher than this number, the
background will turn red to alert you that you have exceeded the maximum line
length. The maximum length is not enforced in any other way.

**Characters Per Second Warning Threshold**
**Characters Per Second Error Threshold**
: The thresholds at which the background CPS column begins to be colored and when the error color is
reached.

**Ignore whitespace**
: If enabled, whitespace will not be included in the character count.

**Ignore punctuation**
: If enabled, punctuation will not be included in the character count.

**Focus grid on click**
: When enabled, the subtitles grid acts as its own area of the program and it
can have focus, just like the audio or the video can, and while it does you can
use the arrow keys/mouse wheel to scroll around it etc. On the other hand, if
you disable this option, the focus will stay where it was before whenever you
click in the grid. This means you can't use keyboard shortcuts in the grid
anymore, but on the other hand it means you can click in the grid to go to a
line without losing the audio focus and so on. Use at your own discretion.

**Highlight visible subtitles**
: When enabled, all subtitle lines that are currently visible in the video
frame (or at least _should_ be visible; Aegisub does not account for alpha and
such trickery in this case; it cares only about the timing of the line) will be
highlighted in the grid with a special background color (see the "Line in frame
background" option below).

**Hide overrides symbol**
: The character that will be shown instead of override blocks if tag hiding is
active. Note that despite the name, this can be more than one character if you
so desire.

**Font**
: Decides the font and font size of all text in the grid.

### Colors ###

[[img/preferences-colours.png]]{: class="center"}

#### Audio Display ####

**Play cursor**
: The color of the playback cursor.

**Line boundary start**
**Line boundary end**
**Line boundary inactive line**
: The respective colors of the various line boundary markers.

**Syllable boundary**
: The color of a syllable boundary line in karaoke mode.

### Color Schemes ###
Controls the color scheme used for the waveform/spectrum and some of the UI
elements. Aegisub currently does not have a UI for editing the color schemes or
creating new ones, but if you're feeling adventurous they can be found in
config.json.

#### Syntax Highlighting ####

**Normal**
: The color of normal text.

**Brackets**
: The color of brackets that start/end override blocks.

**Slashes and parentheses**
: The color of backslashes and parentheses within override blocks.

**Tags**
: The color of tag names within override blocks.

**Parameters**
: The color of parameters to override tags.

**Error**
: The error color for invalid syntax within an override block.

**Error background**
: Background color for errors.

**Line break**
: Color for \N, \n and \h outside of override blocks.

**Karaoke templates**
: Color for karaoke templater blocks on template lines.

#### Subtitle Grid ####

**Standard foreground**
**Standard background**
: The normal color of lines in the grid. "Foreground" is the text color, and
"Background" is obviously the background color.

**Selection foreground**
**Selection background**
: The color of selected lines in the grid.

**Comment background**
**Selected comment background**
: The background color of commented-out lines and selected commented-out lines,
respectively.

**Collision foreground**
: The text color of lines whose timings overlap with the currently active line.

**Line in frame background**
: The background color of lines currently visible in the video frame.

**Header**
**Left column**
**Active line border**
**Lines**
: The color of the grid lines and fixed columns/headers.

## Hotkeys ##

[[img/preferences-hotkeys.png]]{: class="center"}

This page lists all hotkeys currently set in Aegisub, and allows you to add,
remove or change them.

### Hotkey Contexts ###
Aegisub supports setting different hotkeys depending on what part of the
program has focus.

The "Default" group is for hotkeys which should work regardless of what in
Aegisub currently has keyboard focus. Hotkeys set in Default are overridden by
the more specific categories when applicable.

The "Always" group sets hotkeys which are enabled by Medusa mode, which apply
everywhere in the program and override all other keypresses, including ordinary
typing in edit boxes.

All other hotkey contexts should be self-explanatory.

### Setting hotkeys ###
To modify a hotkey, first click on the row to select it, then click on the
hotkey field in the row, then press the key(s) that should trigger the command.
Accept the new hotkey by clicking on another row.

To add a new hotkey, select the context you want to add the hotkey to, then
click the New button. Enter the [[command name|Commands]], then set the hotkey
as when editing them.

## Backup ##

[[img/preferences-backup.png]]{: class="center"}

### Automatic Save ###

**Enable**
: If enabled, Aegisub will periodically save a copy of the script you are
working on to the autosave path.

**Interval in seconds**
: How often should Aegisub autosave.

**Path**
: Decides where to save autosaved copies of scripts you are working on. By
default set to `autosave` in your Aegisub `?user` directory (see the
[[Aegisub_path_specifiers]] page for details).

**Autosave after every change**
: If enabled, Aegisub will save the file after every change made to it. Note
that this currently causes some problems with the undo system.

### Automatic Backup ###

**Enable**
: If enabled, Aegisub will save a backup copy of each script you open,
immediately on opening it. By default, it is saved to `?user/autoback/`, but
this can be changed (see below).

**Path**
: Decides where to save automatic backup copies of scripts. By default set to
`autoback` in your Aegisub `?user` directory.


## Automation ##

[[img/preferences-automation.png]]{: class="center"}

**Base path**
: A base directory where you put non-autoloaded automation scripts. Used only
for saving paths to script files in the subtitles.

**Include path**
: List of directories where include files and modules are searched for.
Directories are separated with a pipe character, `|`.

**Auto-load path**
: List of directories that are searched for scripts on startup, which are then
automatically loaded. Directories are separated with a pipe character, `|`.


**Trace level**
: When a script sends a message to the debug console it can also specify a
trace level. If the trace level of a message is lower than the value given
here, the message is not logged. The names given to the levels are only
suggestions and they don't have any effect on the execution of the script.
(i.e. a "Fatal" level message will not cause the script to terminate.)

**Thread priority**
: Priority given to the script execution thread. If you're on a
single-core/single-CPU system having this on lower than normal will make other
programs more responsive while long-running scripts are active.

**Autoreload on Export**
: Automatically reloads the specified sets of scripts when the [[Exporting]]
dialogue is opened. In that case you will have to enter the
[[Automation/Manager]] window and determine the cause of the error.

## 高级音频设置 ##

[[img/preferences-advanced-audio.png]]{: class="center"}

**音频来自**
: 选择使用何种后台处理方式来载入音频。目前这里只提供两种可选方式。

    _avisynth_ (仅限Windows)
    : 使用 [Avisynth](http://www.avisynth.org) 载入音频。
      所有类型的文件都将会在Avisynth中以DirectShowSource()方式被载入，但*.avs文件会以Import()方式被载入。
      译者注：如果你懂得写AVS脚本的话，甚至可以变相使用LwlibavAudioSource()等五花八门的方式载入音频文件。
      但如果你不懂如何写AVS，这个方式一般就不要考虑了。因为DirectShowSource()实在是和人品有关，
      推荐还是用下面的FFMS2载入音频。

    _FFmpegSource_
    : 使用 [FFMS2](http://code.google.com/p/ffmpegsource/) 载入音频。
      通常比使用DirectShowSource()方式载入更加可靠，但是载入的速度也会慢一些。缘于FFMS2需要先索引一遍媒体文件，通常这
      会花费一些时间，时间长短视文件大小以及电脑性能而异。

    值得注意的是，无论这里如何设置，对于WAV文件，PCM WAV Reader都将优先被使用。

**音频播放器**
: 使用何种方案来播放音频，选项因平台而异。

    _DirectSound_ (仅限Windows)
    : 使用“Microsoft DirectSound”来播放音频。这是目前广泛测试而又最稳定可靠的音频播放器。

    _DirectSound-old_ (仅限Windows)
    : 早期的Aegisub使用的“DirectSound”播放器。
      如果你在使用上面的播放器时出现了人品问题，也许可以试试这个（祝你好运）。

    _alsa_ (仅限Linux)
    : 使用[Advanced Linux Sound Architecture](http://www.alsa-project.org/)来播放音频。
      ALSA是Linux系统的原生音频架构并且它无法在其他任何系统上使用。

    _pulse_ (仅限Linux和其他“类UNIX”系统, eg: FreeBSD、OpenBSD)
    : 通过一个[PulseAudio](http://pulseaudio.org/)声音服务器来播放音频。
      这是最缺乏测试而又很可能无法正常工作的音频播放器，因此仅推荐那些讨厌non-pulse播放器的人使用。

    _portaudio_
    : 调用[PortAudio](http://www.portaudio.com/)的API来播放音频。
      PortAudio在不同平台上拥有不同的音频播放解决方案。在绝大多数的类UNIX系统上使用Open Sound System (OSS)
      来输出音频。它也是当今在Windows系统上唯一支持选择输出设备的音频播放器。

    _openal_
    : 调用[OpenAL](http://www.openal.com/)的API来播放音频。
      这是在OS X系统上的推荐方案。但OpenAL通常不会随Windows安装自带，因为它会让巨硬觉得不爽。

### 缓存 ###

**缓存类型**
: 推荐选择内存，如果你的计算机安装内存十分小，那么就选择硬盘吧。
值得注意的是，打开PCM WAV文件时不需要使用任何缓存！但如果你关闭缓存的话，音频播放可能会变得极不稳定！

**缓存路径**
**缓存文件名**
: 这些选项决定硬盘上的音频缓存的存储位置。仅缓存类型设置为“硬盘”的情况下生效。
在硬盘空间充足的情况下切勿更改这些设置。对于缓存文件名来说，它应该满足C语言的输出风格即"%i"形参，
形参会被一个数字所取代。"%02i"就是默认值。千万不要随意修改这些设定，除非您清楚的知道您在干什么。

### 频谱模式 ###

**质量**
: 设定显示频谱的质量。越高质量等级的设定会导致越高的CPU和内存占用。
每提高一个等级的设定，CPU占用会略微提高，内存占用则会达到上一等级的两倍。
对于采样率48KHz、时长1分钟的音频来说，不同质量等级的设定占用的内存如下表。

    <table class="table table-bordered table-condensed">
      <tr><th>0 "一般质量"</th><td>11 MB</td>
      <tr><th>1 "较好质量"</th><td>22 MB</td>
      <tr><th>2 "高质量"</th><td>44 MB</td>
      <tr><th>3 "极高质量"</th><td>88 MB</td>
    </table>

    值得注意的是，内存的占用量和音频的声道数以及位深无关。
    因为Aegisub一直工作在转换后的单声道模式下，并且频谱也是一直以32位浮点精度计算的。

{::template name="todo"}以上均属杜撰(=・ω・=){:/}

**缓存最大容量**
: 设定频谱缓存所能占用的最大内存数量。
已计算好的频谱会被缓存到内存中以保证滚动频谱时不发生卡顿。
并且能缓存的频谱数量在一定容量的缓存限制下是和频谱的质量设定有关的。
以48Khz采样率的音频为例，在频谱质量设定为“较好质量”的情况下，默认的128M缓存约能缓存六分钟的频谱。
但需要注意的是，如果你的缓存设置小于5MB，则Aegisub会自动套用默认的缓存大小（128M）。
建议最大缓存容量不要超过你电脑安装物理内存的四分之一。（内存壕请无视）

### Avisynth (仅限Windows) ###

**Avisynth down-mixer（声道混合/提取）**
: Aegisub仅能使用单声道音频。这个选项设定Avisynth如何将音频转换为单声道。
ConvertToMomo：将立体声或多声道重新混合成单声道。
GetLeftChannel：仅提取左声道。
GetRightChannel：仅提取右声道。

**强制采样率**
: 强制转换所有已打开音频的采样率为给定值。默认0则不做转换。
若使用硬件声卡完成这一转换，则可潜在提升音频表现力以及修复一些播放问题。
（麻麻说软件播放器转换不行。这玄学吗？）

### FFmpegSource ###

**音频索引错误处理模式**
: 若索引音频时出现错误，则有下面几种处理模式可选~

    _忽略_
    : 忽略错误并且继续解码文件。这个模式可以让你打开一些受损的媒体文件，但可能导致音画不同步。

    _清除_
    : 假设媒体文件中不存在这条有错误的音轨。

    _停止_ (默认值)
    : 停止索引文件并且返回错误前的所有音轨数据。这是Aegisub的默认值，因为在音轨末端遭遇到受损的音频数据是很常见的。
    （笔者表示貌似不常见 QAQ ）

    _取消_
    : 直接取消打开整个媒体文件。

**总是索引所有音轨**
: 一旦禁用，打开视频文件只会索引视频轨道，音轨文件则还需要手动再载入一次。

### Portaudio ###

**Portaudio 设备**
: 当使用PortAudio输出音频时可在这里选择输出音频的设备。

## 高级视频设置 ##

[[img/preferences-advanced-video.png]]{: class="center"}

**视频来自**
: 使用何种方式来载入视频。可用选项取决于你安装的Aegisub编译版本和运行Aegisub的系统平台。
视实际情况可能存在以下选项：

    _avisynth_ (Windows only)
    : 使用[Avisynth](http://www.avisynth.org)来载入视频。
        Avisynth支持载入绝大多数常见格式的媒体以及*.d2v文件（注：d2v文件是DVD VOB媒体文件的索引文件，
        但对*.d2v文件的支持需要正确安装相关Avisynth源滤镜）。
        需要注意的是Aegisub可以使用其自己独立的Avisynth.dll，而不使用你安装的Avisynth。
        若使用Avisynth载入视讯，则只推荐载入*.avi *.d2v *.avs文件以获(fang)得(zhi)最(ren)佳(pin)体(wen)验(ti)。

    _FFmpegSource_
    : 使用[FFMS2](http://code.google.com/p/ffmpegsource/)来载入视频。
        如果你看不懂上面在说些什么，那么FFMS2就是你最好的选择。支持绝大多数常见格式并且相对较为可靠。
        但对于较大的媒体文件可能会花费几分钟的索引时间。

**Subtitles provider**
: Decides what backend Aegisub uses to render subtitles on the video.
    If you install additional CSRI renderers such as VSFilterMod or
    xy-VSFilter (by placing the dlls in the CSRI directory within Aegisub's
    directory), they will be listed here along with the default ones.

    *CSRI/vsfilter_textsub* (Windows only)
    : Use VSFilter 2.40 to render subtitles. This is the standard subtitle
        renderer which defines the ASS format used by Aegisub.

    _libass_
    : Use [libass](http://code.google.com/p/libass/) to render subtitles.
        libass is far faster than VSFilter and (somewhat) cross-platform, but
        unfortunately still has some rendering differences from VSFilter and
        font-related issues on Windows. If you are doing complex typesetting
        that will be [[softsubbed|Attaching_subtitles_to_video#softsubbing]] it
        is a good idea to check your work with both VSFilter and libass, as an
        increasing number of users are using libass.

**Force BT.601**
: Pretend all YUV videos are BT.601, for VSFilter compatibility.

    When VSFilter is used as a DirectShow filter, it always uses the BT.601
    color matrix for converting the subtitles from RGB to YUV. This means that
    if the video uses BT.709 (as most HD video and the occasional DVD does),
    colors which match the video in Aegisub will not match the video in the
    player. This option makes Aegisub always convert videos to RGB using
    BT.601, making the colors shown in Aegisub incorrect, but making it so that
    if the colors match in Aegisub, they will match in the player.

    To make things more exciting, VSFilter will use the *correct* color space
    when used as the internal subtitle renderer in MPC-HC, so enabling this
    option will result in *mismatched* colors in that case. As the ISR is
    currently broken in many ways (e.g. it is impossible to accurately position
    subtitles with it), we recommend not worrying about it for now.

    This comparison may make this clearer:

    [[img/bt601.png]]

    Aegisub now writes what colorspace should be used for RGB -> YUV
    conversions to the subtitle file, so hopefully this mess will be resolved
    by renderer improvements sometime in the future.

### Avisynth ###

**Allow pre-2.56a Avisynth**
: Support using ancient versions of Avisynth that a few people refuse to
upgrade past for various bad reasons.

**Avisynth memory limit**
: Frame cache memory limit for Avisynth. Raising this generally does not
improve performance and should be done only if you're opening overcomplicated
Avisynth scripts directly.

### FFmpegSource ###

**Debug log verbosity**
: Set ffmpeg/libav's verbosity level. Only has an effect when you have a
debugger attached to Aegisub.

**Decoding threads**
: Maximum number of threads to use to decode video, or -1 to choose
automatically. Setting this to 1 can fix some decoding issues at the cost of
performance. There is rarely any reason to set it to a value other than 1 or
-1.

**Enable unsafe seeking**
: Disable some of FFMS2's sanity checks when seeking in video. Makes it
possible to open some files which FFMS2 cannot seek frame-accurately in.
