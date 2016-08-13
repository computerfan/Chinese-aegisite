本篇教程将介绍如何用Aegisub读取一首歌, 将歌词划分成音节并添加时间码。

这篇教程基本是为零起点的人准备的。


## 开始之前  ##


开始之前我们要准备好一些东西:


* 一首歌的音频文件。文件的格式可以是 MP3 或者 在视频文件中。Aegisub能从视频中读取音频，在不出意外的情况下，你无须从视频中提取音轨出来。

<div></div>


* 这首歌的歌词。如果是已经分好段的纯文本(.txt 文件)，后续工作会更简单。

<div></div>

这里使用一首英文歌作为例子。但是不得不提一下，Aegisub的大多数高级歌词功能都是为日语或者其它语言设计的，这些语言最终会被翻译成拉丁语系语言。具体用法见视频教程。


## 读取歌曲音频  ##


首先，我们创建一个新文件。如果你是刚刚启动Aegisub，那么直接在当前窗口编辑即可。

[[img/Karatiming-1.png]]

现在让我们打开歌曲音频。点击 **音频** 菜单中的 **打开音频文件** ...

[[img/Karatiming-2.png]]

...然后选择歌曲音频文件。

[[img/Karatiming-3.png]]

Aegisub会花费一点时间来载入音频。

[[img/Karatiming-4.png]]

当载入完成，你应当会在Aegisub窗口上半部分看到波形模式下的音频显示。如果你之前用过Aegisub，它看起来可能有点不同，建议跟着教程图的设置走，后面可以更轻松。

[[img/Karatiming-5.png]]

我们一会再看如何用音频打轴，先把歌词和载入的歌曲对应上。


### 提示  ###


**从视频中打开音频:** 你可以在音频文件选择窗口中选中含有音轨的视频文件，这样不会打开音频，而是打开视频文件的音轨。

**WAV文件秒读:** 如果你有未压缩的 WAV 格式音频文件，Aegisub可以秒读它到内存中。这会节省大量时间，但是相对的，也需要多占用一些硬盘空间，或者需要事先转换成WAV格式。(所以有现成的WAV就用WAV，没有就算啦，只对未压缩PCM有效，MP3之类的文件仍然要花时间预读取)


## 输入歌词  ##


现在，输入歌词，我们开始敲键盘...

[[img/Karatiming-6.png]]

**但是不要这样做!** 如果你之前已经拥有了分行纯文本格式的歌词，能避免很多麻烦，因为你可以直接复制粘贴到Aegisub。(你也可以从信赖的歌词网站直接复制歌词粘贴。)

我拥有分行的歌词文本文件，我打开它，选中文本并复制。

[[img/Karatiming-7.png]]

现在事情开始变得有点复杂了，但是不要慌，其实并不难 :-)

有两种方式可以把刚复制的文本粘贴进 Aegisub:在字幕栏，或者在字幕编辑框。当你粘贴到字幕栏的时候，你在文件中创建了新的字幕行。当你粘贴到字幕编辑框，只会作用当前选中这行。

我们要确认粘贴到了字幕栏，所以单击字幕栏然后在菜单中依次点击编辑、粘贴行(在字幕栏右键单击粘贴也可)。

[[img/Karatiming-8.png]]

现在我们把歌词粘贴进来

[[img/Karatiming-9.png]]

歌词会立刻以逐行的形式出现在字幕栏中。注意这时行的开始结束时间都是0。

[[img/Karatiming-10.png]]

现在存个盘也许是个好主意。

记住 Aegisub 每隔几分钟会自动保存文件，甚至你还没给文件命名，所以即使出了什么情况，你也很少有机会丢失工作文件。

[[img/Karatiming-11.png]]

现在我们已经准备好给每行歌词打时间轴了。


## 粗略计时，行为单位  ##


Before we start with timing, you should know that the way presented here is just one of many. There's several ways you can time to audio in Aegisub and this one might not be the best one for you. Try to also explore the program and see if you can find your own best way to do it. This is just the way I (jfs) usually do it.

First let's look at how to get around the audio display and play the audio. You might already have noticed that there's no less than 6 different "Play" buttons. Usually you'll just use one of them, though: The one with the blue outward-pointing brackets around. That one is Play Selection, and plays the part of the audio that's currently highlighted.

[[img/Karatiming-12.png]]

Try pressing the Play Selection button, you should hear the first 5 seconds of the song played. (Aegisub selects the first 5 seconds by default.)

Now try changing the selection: You can left-click and drag in the audio display to select the part you've dragged across. If you click and drag on the left or right edge of the selection you can change just the start or end. Finally, you can make a single left-click (without dragging!) anywhere to set the selection start right to that point, and you can make a single right-click to set the selection end.

Let's time the first line. Find the start and end of the first line of the song you're working on and make sure the audio selection matches it exactly. Notice that at first, the selection was gray but as soon as you started changing it, it became red and the word "Modified" appeared. This means that you have changed the selection but not saved (committed) the new timing.

To commit the timing and store it back to the subtitle line, just press the Commit button, the green check mark.

[[img/Karatiming-13.png]]

When you commit, you will also be sent to the next line automatically, so you can immediately continue timing that.

Just continue timing like that until you have covered all the lines of the song: Find start and end of line, set the selection and then commit.

When you're done, save the file.


### Tips  ###


Timing from audio isn't hard at all, but here's some tips to make it even easier and also a lot faster!

**Hotkeys:** There's a number of keyboard shortcuts that can make audio timing much faster to work with.

[[img/Karatiming-14.png]]

The most important ones are:


* **S** - Play Selection: Play back the currently selected audio.
* **A** and **F** - Scroll Left and Right: Change the potion of the audio visible.
* **G** - Commit: Copy the start and end times of the current audio selection into the line selected in the subtitles grid and move to the next line.

<div></div>

**Play near start/end:** There's four buttons (hotkeys Q, W, E and D) that play half a second just before or just after the start and end of the selection. You can use these to more accurately set the start and end to exactly where the singing starts/ends.

**Change selection while playing:** While audio is playing you can still change the selection. You won't see any difference if you change the selection start, but if you change the selection end, playback will now end when it hits the new selection end. This way you can quickly stop playback by setting the end close to the playback cursor (the white line that moves while Aegisub is playing) or extend the playback to go even further.

For example, when looking for the start of the first line, you can just start playback with the initial 5 second selection and continue extending it until you find the line. Then, while it's still playing, you can set the right start time and then the end time. When you have the line approximately down like that, you can do an extra check by playing the entire selection again, or by using the Q/W/E/D keys to play the parts right around the start and end times.

**Spectrum mode:** Usually the audio display is in waveform mode, this is what I've shown on all the screenshots so far. But actually Aegisub has a much cooler way of showing the audio: Spectrum mode.

[[img/Karatiming-15.png]]

The spectrum mode takes more CPU and RAM than waveform mode, but it gives a better picture of the audio and with a bit of training you can learn to tell singing from music and even how different sounds look. For example, S sounds are very easy to recognise.

**Zooming and scaling:** You can use the slider bars to the far right of the audio display to zoom in and out on the audio and to change the volume.


## Fine timing, words and then syllables  ##


{{todo|
Click Karaoke button.

Time words.

Click Split button. Place split markers. Click Accept Split button.

Time syllables.

Commit.

Repeat.}}


## Styling  ##


{::template name="todo"}a bit about styles, how basic karaoke looks, and the \kf and \ko effects{:/}


## Wrapping up  ##


{::template name="todo"}mention the video tutorial again and point to other relevant topics{:/}

