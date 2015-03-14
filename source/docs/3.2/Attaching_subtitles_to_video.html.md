{::options toc_levels="2,3" /}

在数字化编码中，有两种方式可以把字幕融入到视频文件中:
软字幕和硬字幕。两种方法都有其独特的优缺点，有关两种方式优劣的讨论也未曾停止过。

## 硬字幕 ##
硬字幕是一种把字幕 "烧录" 在视频部分中的方法。数字硬字幕更像是VHS录像带；字幕是不能被关闭的。

### 硬字幕的优势 ###
硬字幕对播放设备的要求比较低。因为字幕已经成为视频的一部分，在相同视频参数条件下，播放有字幕视频和无字幕视频消耗的资源是差不多的。你也可以制作应用软字幕难以保存和渲染的特效，对拥有复杂特效的字幕文件进行实时渲染需要消耗大量的CPU运算资源。甚至有些网络字幕组发布的内挂字幕的动漫视频文件中，OP/ED部分由于带有复杂特效而使用了硬字幕 。

一些人喜欢硬字幕，因为这样脚本几乎无法被人盗走，因为压制时视频的图像和字幕同时被编码到一起，字幕无法像软字幕一样单独提取出来However, the presence of very good subtitle extractors designed for
the purpose of extracting this embedded text removes much of the argument that
hardsubs prevent script stealing.

Many playback devices and computer platforms cannot display the special fonts
and formattings that softsubs contain, but this problem is removed with
hardsubs, where the style is preserved. Also, these stylings will show back
exactly the same on any device, unlike softsubs which depend on the playback
device to properly intrepret and display the stylings.

### Disadvantages of Hardsubbing ###
Despite what some may call numerous advantages for hardsubbing, there are
several distinct disadvantages that should be evaluated before making a
decision.

The method of hardsubbing requires that the source video is re-encoded so the
subtitles can be written on the image. This, by the nature of lossy video
encoding, causes a reduction in video quality.

Subtitles add a sharp contrast in a video image due to their nature. This will
cause compression artifacts along the edges of the encoded subtitle, and
blurring of the subtitle. This effect is especially evident at lower bitrates.

Under typical circumstances, the inclusion of the subtitles will cause an
increase in the bitrate needed for the video to keep the same quality. This, of
course, means an increased filesize, or lower quality at the same size. The
increase in bitrate necessary is typically around 3 to 10%.

Changing the subtitles requires a re-encode of the video source, which can add
a lot of time and extra work to the release process.

## Softsubbing ##
Softsubbing is a method that keeps subtitles seperate from the video and relies
on the playback device to combine the two when the video is being played. This
method can be best compared to subtitles on most DVDs. The subtitling can be
turned on or off as needed, and multiple languages can be supported with just
one combined media file. Unlike with a DVD though, digital softsubs are
actually text (DVD subtitles are pictures) which adds many nice features at the
cost of complexity.

### Advantages of Softsubbing ###
Softsubs are much clearer on display. Since they are not part of the video
image, video compression does not affect them, and with a good subtitle
renderer, they are sharp and crisp - a huge benefit to readability.

Softsubs can be smaller. Since the subtitle is just a text file, it can take up
less room because it isn't hogging video bitrate. This allows for an encoder to
either make a smaller file with the same video quality, or a same-sized file
with higher video quality.

People with vision problems have an opportunity to adjust how the subtitles look on-screen.

Without a huge impact on size, multiple languages can be supported in one video file.

If you find a subtitling mistake in a file, you can fix it without having to
re-encode the video - saving a lot of time.

### Disadvantages of Softsubbing ###
Softsubs add processing complexity to the video. The playback device has to
render and overlay the text before displaying the video, as a result, this
means that low-powered devices will not be able to play the video.

Since the subtitles are bundled as straight text they are very easy to extract
and use. This makes things easier on bootleggers or other script stealers. Note
that grabbing subtitles from a hardsub is very easy currently, so this argument
doesn't hold much weight.

The playback device is responsible for rendering the subtitles on screen. As a
result, they might not look the same as the subtitler intended. In some cases,
the playback device might not support the subtitle format, or might have bugs
with it.

The AVI file format is not reliable for supporting softsubs, if you plan to use
it. Please note that Matroska (MKV) is very well supported by computers, so
this isn't a major negative.

Subtitles with effects added (usually for karaoke) take up a lot of processing
time, and may cause playback issues if the device cannot handle the processing
requirements. A solution for this is to hardsub the complex parts such as
opening and ending karaoke, and softsub the normal dialog.

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
