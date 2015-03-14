{::options toc_levels="2,3" /}

在数字化编码中，有两种方式可以把字幕融入到视频文件中:
软字幕和硬字幕。两种方法都有其独特的优缺点，有关两种方式优劣的讨论也未曾停止过。

## 硬字幕 ##
硬字幕是一种把字幕 "烧录" 在视频部分中的方法。数字硬字幕更像是VHS录像带；字幕是不能被关闭的。

### 硬字幕的优势 ###
硬字幕对播放设备的要求比较低。因为字幕已经成为视频的一部分，在相同视频参数条件下，播放有字幕视频和无字幕视频消耗的资源是差不多的。你也可以制作应用软字幕难以保存和渲染的特效，对拥有复杂特效的字幕文件进行实时渲染需要消耗大量的CPU运算资源。甚至有些网络字幕组发布的内挂字幕的动漫视频文件中，OP/ED部分由于带有复杂特效而使用了硬字幕 。

一些人喜欢硬字幕，因为这样脚本无法被人盗走，因为压制时视频的图像和字幕同时被编码到一起，字幕无法像软字幕一样单独提取出来。然而，由于存在着高大上的被设计用来提取内嵌硬字幕的软件，硬字幕的防盗功能显得不是那么强势了。

许多播放设备和电脑平台无法显示软字幕文件使用的某些特殊字体和样式，但是使用硬字幕就没有这些问题，样式都被完美地保留。并且，在任何设备上播放都能保证是相同效果，不像软字幕那样，受播放设备环境不同的影响。

### 硬字幕的缺点 ###
尽管硬字幕有着许多优点，但是同时也存在着许多缺点，在抉择使用硬/软字幕前应该纳入考虑范围。
把字幕变为硬字幕需要把字幕文件和视频一同进行重编码，把字幕图像融入到视频图像中。由于有损视频编码的本质，此举会造成一定视频质量的损失。


字幕在编码时会鲜明地凸显出来，这是由字幕的性质决定的。这会导致字幕边缘的图像质量有损失，同时字幕也会比软字幕模糊，在低码率时尤为明显。

在典型情况下，为了需要保持相同的视频质量，内嵌字幕会引起视频码率的升高。这就意味着文件体积的增加，如果保持相同体积则会有损画质。一般情况下内嵌字幕带来的文件体积变化范围在 3 到 10%之间。

内嵌字幕需要对原视频进行重编码，这使得视频的发布过程中又增加了额外的时间消耗。

## 软字幕 ##
软字幕能保持视频和字幕文件是分开的，在播放视频时播放设备会把两者联系起来。这种方法可以在大多DVD上见到。字幕的有无可以控制，一个视频对应多语言字幕也可以得到支持。和DVD字幕不同的是，数字软字幕文件本质上是文本文件，而DVD字幕本质上是图片（或者说图层），前者在复杂度较高时有着更好的特性。

### 软字幕的优点 ###
软字幕在播放时显示的更为清晰。因为播放时它并非作为视频图像的一部分，所以视频的压缩不会影响字幕质量，配合着好的字幕渲染器，软字幕看起来锐利清晰——这是判断可读性最重要的指标。

软字幕体积可以更小。因为它就是一个文本文件，它占用的空间更小，因为它不必占用视频的码率。这一点允许编码时生成更小的相同画质的视频文件，或者同体积画质更高的视频文件。

有着视觉问题的人们可以调节字幕在屏幕上看起来是什么样子。

由于对视频体积没有显著影响，在一个视频文件中多封装多国语字幕是可行的。

如果你在字幕中发现了错误，你直接修正字幕文件就可以，而不用像内嵌字幕一样重编码视频，这会节省大量的时间

### 软字幕的缺点 ###
软字幕增加了播放视频时处理的复杂度。播放设备不得不在播放对应视频前渲染出对应字幕图形，结果就是，低性能的设备无法同步播放甚至无法播放视频。

因为软字幕是独立的文件或者和视频文件封装在一起，它们更容易被提取和使(盗)用。这就使得盗用者更容易完成工作。注意目前从硬字幕视频文件中抓取硬字幕也是很容易的，所以硬字幕十分防盗的说法也是站不住脚的。


播放设备负责渲染字幕到屏幕上。作为结果，它们看起来和字幕作者制作的看起来可能不太一样。某些情况下，播放设备可能不支持字幕格式，或者是支持的同时存在BUG。

AVI格式的文件对于软字幕的支持很弱，如果你想使用软字幕，最佳情况是在电脑上使用MKV格式进行封装。

拥有特效的字幕文件(多为卡拉OK特效)会占用很多的处理时间，如果播放设备不够给力还会出现播放问题。解决方式之一就是内嵌这一部分的字幕(OP/ED)，常规对话采用软字幕。

## What method do I choose? ##
The method you should choose depends greatly on your audience. Will they have
relatively new and powerful playback devices? Will they possibly be able to
install something to play back softsubs if they don't have it? Is your
destination a digital format (Matroska, DVD, etc.) or will you be printing to
tape?

While every situation will be different, you can use some of the following
suggestions to guide you. These are based on making a digital format for
playback on a computer system.

If you want your file playable on the largest range of computers, operating
systems, and small plastic toys,you will want to hardsub.

If your audience will be running on a platform where your subtitle format is
well-supported, softsubs are a good idea.

If you want to have multiple subtitle languages or if some of your viewers may
not want to have subtitles enabled at all, softsubs are your only option.

If you want to speed up your release process, use softsubs. They are faster to
fix if an error is found, and allow you to release as soon as the subtitles are
done, rather than waiting a few hours for the video to be encoded.

## Hardsubbing with Avisynth ##
Many people use the Avisynth package to add filters to their video to clean up
defects, or otherwise manipulate the video image before encoding it. It is a
very flexible tool, and can be also used to add subtitles directly to the video
stream, allowing an easy and scriptable method to hardsub a video.

If you are unfamiliar with Avisynth, it is recommended that you look into it,
as it has lots of nice features and a large community contributing video
filters, allowing easy video fixes for any source. This tutorial assumes you
have some basic knowledge of Avisynth.

To allow adding subtitles to the video stream, you have two options: you can
use VSFilter (included with Aegisub, in the "csri" folder), or you can use
[AssRender](http://srsfckn.biz/assrender/), which uses libass. The following
instructions assume that you are using VSFilter.

To just add subtitles, you will want to make a simple AVS file containing the
script lines you need. Simply create a plain-text file in notepad (or your
favourite text editor) and save it with the .avs extension (beware that Windows
might be hiding your extension, and you might actually be making a .avs.txt
file). Here is an example:

    LoadPlugin("c:\program files\aegisub\csri\vsfilter.dll")
    AVISource("c:\projects\project1\video\mycoolvideo.avi")
    TextSub("c:\projects\project1\subs\mainsubtitles.ass")
    TextSub("c:\projects\project1\subs\endkaraoke.ass")

The above script will take an AVI file (mycoolvideo.avi), and then draw the
contents of two subtitle files on the video. You can then encode this video in
any program that supports AVS, such as [VirtualDub](http://www.virtualdub.org)
or x264. To do so, just open the .avs file in the program, and follow the
normal encoding procedure for it.

Keep in mind that, due to a bug in VSFilter, the path to the subtitle files
MUST be absolute.

## Hardsubbing with VirtualDub ##
If you're already familiar with VirtualDub filters, and don't intend to do any
other video processing, you should note that it's possible to use VSFilter as a
VirtualDub filter as well. Just rename the .dll to .vdf and copy it to the
VirtualDub plugins folder. The filter will then be available as "TextSub".

**Warning**: VirtualDub comes with a TextSub of its own, that is called
"TextSub 2.23". This is a very old version that, amongst many other issues,
cannot parse UTF-8 (the default Aegisub encoding) files properly. This will
result in any non-ASCII characters being rendered as gibberish. NEVER USE THIS
FILTER.

## Softsubbing ##
Softsubbing a video can be done in several ways. On Windows using a DirectShow
player, such as Media Player Classic, ZoomPlayer or even Windows Media Player,
you need VSFilter installed to view the subtitles. If you use MPlayer, you need
libass and FontConfig compiled to correctly view all the formatting.

### Variant 1: softsubs inside the video container ###
Matroska Video (MKV) is currently the best container for this method (MP4, OGM
and even AVI can technically contain softsubs, but none supports font
attachments, and all of them has various other issues). Using a muxer that
supports attachments (i.e. [mkvmerge
GUI](http://www.bunkus.org/videotools/mkvtoolnix/)), you simply add your
subtitle files to the Matroska file as separate tracks (just like you add audio
and video tracks), and any fonts as attachments (make sure they have the MIME
type application/x-truetype-font). The fonts will then be installed temporarily
by Haali Media Splitter (on Windows) or MPlayer (on *nix and MacOS X) during
playback.

### Variant 2: distributing script files ###
This method works best when you want to encode the video in an AVI wrapper. You
simply send the raw subtitle files along with the video. The viewer then needs
to load them in a player that supports external subtitles. When using this
method, you either need to make sure you use fonts that everyone can be
expected to have installed, or distribute a separate ZIP archive with the
fonts. For obvious reasons, this method isn't recommended.
