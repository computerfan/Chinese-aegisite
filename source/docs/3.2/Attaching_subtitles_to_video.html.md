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

在典型情况下，为了需要保持相同的视频质量，内嵌字幕会引起视频码率的升高。这就意味着文件体积的增加，如果保持相同体积则会有损画质。一般情况下内嵌字幕带来的文件体积变化范围在 3% 到 10%之间。

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

因为软字幕是和视频文件封装在一起，它们更容易被提取和使(盗)用。这就使得盗用者更容易完成工作。注意目前从硬字幕视频文件中抓取硬字幕也是很容易的，所以硬字幕十分防盗的说法也是站不住脚的。


播放设备负责渲染字幕到屏幕上。作为结果，它们看起来和字幕作者制作的看起来可能不太一样。某些情况下，播放设备可能不支持字幕格式，或者是支持的同时存在BUG。

AVI格式的文件对于软字幕的支持很弱，如果你想使用软字幕，最佳情况是在电脑上使用MKV格式进行封装。

拥有特效的字幕文件(多为卡拉OK特效)会占用很多的处理时间，如果播放设备不够给力还会出现播放问题。解决方式之一就是内嵌这一部分的字幕(OP/ED)，常规对话采用软字幕。

## 我应该选择哪种方式 ##
按照你的观众来选择字幕的类型。他们是否拥有足够性能的播放设备？他们是否愿意安装软字幕需要的字体或其他环境？你的目的是制作成什么格式，DVD还是MKV？或者说你想刻成影带？

情况多种多样，你可以参考下面的建议。这些是基于制作数字格式视频的目的，播放设备为电脑。


如果你想让这个文件在大范围的播放设备上都能播放，不论是电脑系统还是便携游戏机/手机一类，你应该使用硬字幕。

如果你的观众使用的播放平台和软字幕兼容比较好或者和你制作字幕环境一致，那么软字幕是一个好选择。

如果你想要单文件多国语字幕，或者观众想控制字幕的有无，这点只有软字幕能做到。

如果你想加速你的发布进程，使用软字幕。修复软字幕中的错误也是很简单快速的，字幕完成就意味着可以发片了，比起压制硬字幕省了很多时间。


## 用Avisynth内嵌字幕 ##
许多人用Avisynth向视频添加滤镜效果来清除或者修复一些片源的缺点，或者改变视频的尺寸。它是个很灵活的工具，它也可以用来把字幕直接加到视频流中，使用简单的脚本化方法，为视频内嵌字幕。

如果你对Avisynth不熟悉，建议先去熟悉一下下，因为它具有很多极佳的特性，和大量的视频滤镜，支持所有格式视频的简单处理。下面的说明会建立在你具有基础的Avisynth知识基础上。

在视频流中加入字幕，你有两个选项：使用VSFilter (Aegisub自带,在 "csri" 目录下)，或者使用 [AssRender] (http://srsfckn.biz/assrender/)，它调用的是libass。 下面的介绍假定你使用VSFilter

如果仅仅想加字幕，你写的AVS文件只要包含简单的几行。使用记事本(其它你喜欢的文本编辑器都行)建立一个纯文本文件，以 .avs 后缀保存(注意Windows有时候会隐藏拓展名，所以你有可能建立了一个 .avs.txt 文件)。下面是个例子:

    LoadPlugin("c:\program files\aegisub\csri\vsfilter.dll")
    AVISource("c:\projects\project1\video\mycoolvideo.avi")
    TextSub("c:\projects\project1\subs\mainsubtitles.ass")
    TextSub("c:\projects\project1\subs\endkaraoke.ass")

上面的脚本以 AVI 文件为例 (mycoolvideo.avi)，挂载两个字幕到视频。你可以在任何一个支持AVS的程序中对视频进行编码，例如 [VirtualDub](http://www.virtualdub.org) 或者 x264。在相应的程序中打开 .avs 文件，正常进行编码即可。


切记，由于VSFilter的BUG， 挂载字幕时一定要写绝对路径。

## 用 VirtualDub 内嵌字幕 ##
如果你已经对 VirtualDub 滤镜很熟悉，并且不打算对视频做其他处理，你应该注意到无法把VSFilter作为一个VirtualDub滤镜使用。重命名VSFilter.dll 为 VSFilter.vdf 然后把它复制到VirtualDub的plugins目录下。就可以使用"TextSub"了。

**警告**: VirtualDub其实自带了一个TextSub，名为"TextSub 2.23"。这个版本太老旧了，甚至无法正确处理UTF-8编码 (Aegisub文件的默认编码)文件。结果就是它把非ASCII字符全部渲染成乱码。永远也不要使用这个滤镜！

## 软字幕 ##
软字幕处理有多种方法。在Win平台使用DirectShow播放器，例如MPC, ZoomPlayer甚至是Windows Media Player，你需要安装VSFilter来观看字幕。如果你使用MPlayer，你需要libass和FontConfig才能看到完整的字幕样式。 


### 变形 1:软字幕封装在容器中 ###
Matroska Video (MKV) 目前是最好的容器(MP4, OGM
甚至AVI技术上支持内封字幕，但是都不支持字体调用，并且都有其它的缺陷). 使用混流器Using a muxer that
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
