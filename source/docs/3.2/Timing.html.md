{::options toc_levels="2,3" /}

## 主音频视图 ##

当你加载了音频文件，Aegisub将会出现如下图的界面：
[[img/audio_display.png]]

你可以按住并拖动该视图底部来改变音频波形/频谱显示的高度。

右边那几个能按下去的是切换按钮。按下去表示启用。按钮和控制按键的功能如下（许多默认都有[[快捷键|Keyboard_shortcuts]]）：

1. 移到上一行，放弃未提交的更改（在[[卡拉OK模式|Audio#karaokemode]]时为上一音节）
1. 移到下一行，放弃未提交的更改（在[[卡拉OK模式|Audio#karaokemode]]时为下一音节）
1. 播放所选波形的音频
1. 播放当前行
1. 停止播放
1. 播放所选部分前500ms
1. 播放所选部分后500ms
1. 播放所选部分头500ms
1. 播放所选部分末500ms
1. 播放所选部分至音频结束（或直到按下停止键）
1. 开始时间提前（提前多少取决于[[提前开始时间选项|Options#section-2]]）
1. 结束时间延后（和上一个意思差不多，取决于[[延后结束时间选项|Options#section-2]]）
1. 提交（保存）更改
1. 将视图移至所选行的位置
1. 打开或关闭自动提交功能（如果打开，所有对时间轴的更改会立即提交而不再需要手动点提交）
1. 打开或关闭提交后自动转至下一行功能（如果打开，Aegisub将会在你手动提交后自动选择下一行。自动提交显然是不会触发这个机能的）
1. 打开或关闭自动卷动功能（如果打开，波形会自动移至当前所选行）
1. 打开或关闭频谱分析模式（看下面的内容）
1. 切换Medusa热键模式
1. 切换卡拉OK模式
1. 波形水平缩放
1. 波形垂直缩放
1. 音频音量
1. 开启或关闭同时调节垂直缩放与音量

## 基本音频打轴 ##
当你在字幕栏中选中一行时，Aegisub将会在音频视图里高亮那行，如果你打开了自动卷动功能，音频视图会将所选行移至视图中间（一般打轴时不建议开启自动卷动）。你会注意到音频视图里会有各种竖线；粉色表示加载的视频（参阅[[使用视频|Video]]部分）的关键帧，白色分割线表示当前视频帧的位置,粗的红线和蓝线分别表示行的开始和结束，你可以左击或右击来设置开始或结束时间，或者拖动那些竖线。按 _播放_ 按钮（默认快捷键为 _s_ ）来听所选部分，或用其他不同的播放按钮来播放周围不同的音频。当你对这行时间轴满意后，按提交按钮来保存并移至下一行，然后每行都这样操作一遍，就是这么简单。

按住shift键可使行边线紧贴其他行边线和关键帧线（或者在设置里可以关闭紧贴功能）。
按住ctrl可以一次移动两行重叠的线。
例如，当两行时间轴挨在了一起，不过你想让两行变换的时间靠后一些，那么你就按住ctrl再移动两行间的那条线，这样就能同时改变第一行的结束时间和第二行的开始时间。

Holding alt will make you drag all selected lines (both start and end times).
按住alt可以平移所有选择的行（同时移动开始和结束时间）。

### Timing protips ###
If you want to finish timing your movie or episode within any reasonable
amount of time, there's some things you should note:

* Use keyboard shortcuts! They speed up your work by several orders of
  magnitude.
* You don't need to have video displayed while timing. If you think you do,
  there's a good change you're doing something wrong. Scene-timing, i.e.
  syncing line start/ends to scene changes, can be done later. Either
  manually, or with the [[timing postprocessor|Timing_Post-Processor]].
* Use "go to next line on commit".
* Experiment with different timing styles when you're new and stick to one
  that suits you. Then practice. Lots.
* Aegisub heavily relies on the concept of "focus", and doing things in a
  way that require you to switch back and forth between video/audio/subtitle
  edit box a lot will cost you a lot of time. Do it in several "passes"
  instead.
* The spectrum analyzer mode looks weird at first, but usually makes it lot
  easier to "see" where lines start and end, especially when there is
  background noise.
* With practice, it's often faster and easier to time something from scratch
  than fix bad timing, due to that fixing bad timing requires spending a small
  amount of time thinking about each line.
* If you want to delete all timing data and start over, a simple way is to use
  the [[shift times dialog|Shift_Times]] to shift all lines backwards by
  9:59:59.99.

One common timing style (preferred by the author of this page) goes something
like the following: Turn on "go to next line on commit" but disable
auto-committing, auto-scrolling and Medusa timing shortcuts. Keep the four main
fingers of your left hand on s/d/f/g. You won't be using the thumb so do
whatever you want with it. Keep your right hand on the mouse. Now select (by
left- and right-clicking) an area in the waveform that seems likely to contain
a line of speech matching the current subtitle line, and hit _s_ to play it
back.  While it's playing, adjust the start time if necessary. When the
playback marker has passed the end time mark, adjust the end time as well. If
greater accuracy is needed, play the last 500ms of the selection by pressing
_d_, 500ms before the selection start by pressing _q_, 500ms after the
selection end by pressing _w_, or the first 500ms of the selection by pressing
_e_. As you grow more experienced, you won't be using anything else than _s_
very much, except maybe _d_ and _q_. When you're satisfied with the timing, hit
_g_ to commit changes and go on to the next line. Scroll the audio display
forward by pressing _f_. If you need to scroll it backwards, use _a_. To go to
next or previous line without committing changes, use _z_ and _x_.

This style has the advantage that you never need to move your hands at all.
With some training, it can also be very fast; audio timing 350-400 lines of
dialog to a 25-minute episode can easily be done in less than 40 minutes,
and less verbose scripts can sometimes be done faster than real time.

Of course, this style may not feel comfortable for all people; you should
experiment with other timing styles before deciding which one is best for
you.

### The spectrum analyzer mode ###
[[img/spectrum.png]]

When you press the spectrum analyzer button, the waveform does no longer
show amplitude (signal strength) on the vertical axis - instead it shows
frequency. The higher up, the higher the frequency. The colors instead
indicate amplitude, with black/dark blue being silence and white being the
strongest sound. This may seem confusing, but since the frequency window is
set to fit human voices rather well, it can make it easy to tell where a
line (or a word in karaoke mode) starts and ends when there's a lot of
background noise (or music) that makes it hard to tell from the normal
waveform. It can be especially useful when timing karaoke. Play around with
it for a little while, and you'll understand how it works.

Note that in spectrum analyzer mode, the "vertical zoom" slider is redefined
to control color intensity instead, since the colors indicate signal
strength.

Because calculating the spectrum data is very CPU intensive, it in initially
set to be in a medium quality. You can increase the quality of the spectrum
in the [[audio options|Audio#options]]. This is mostly important when you built
Aegisub yourself and did not use FFTW3; FFTW3 is fast enough that the default
quality is bumped up a bit.

## Karaoke timing ##
{::template name="todo"}here be dragons{:/}
