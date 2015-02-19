{::options toc_levels="2,3" /}

附件管理器允许你把字体或者图片附在字幕脚本文件中(通过将它们编码为文本)。有时候用于多人共同工作的脚本上，这样生成的字幕文件和字体是一个整体，免去了小伙伴之间单独传输字体文件的麻烦。然而它的功能有限并且容易引起问题。

## 概览  ##
[[img/Attachment_list.png]]{: class="center"}

窗口的按钮功能不言自明。两个“附加 ...” 按钮用来添加附件，“提取”用来提取已有的附件到单独的文件，“删除”会从字幕文件中删除附件。

## 局限性和缺点  ##

### 支持的格式  ###
SSA 格式只支持把一些特定的文件格式转化为附件。字体方面，只有.ttf得到了支持。图片方面.bmp, .gif, .ico, .jpg and .wmf得到了支持(并不支持.png)。 None of the SSA commands which _use_ the
images are implemented in anything but SubStation Alpha, so it is very unlikely
that attaching pictures is actually a useful thing to do.

### Compatibility issues  ###
Many SSA/ASS editors ignore or strip attachments. The original SubStation Alpha
(v4.08) will work fine, but only for real SSA files. Sabbu will complain about
unrecognized fields, and strip the attachments if you save the file. Most other
editors either ignore the attachments or crash when encountering them.

A notable exception is mkvmerge, which will convert the attached files to
Matroska attachments on muxing. If you demux the script again, the attachments
will be stripped from the script, but they're still there as MKV attachments.

### Size  ###
Unfortunately, storing binary data as text (in this case, a variant of
UUEncoding) is not very efficient. The attached files will take considerably
more space as script attachments than they do as separate files.

### Speed ###
Aegisub's undo system makes a complete copy of the loaded file on every change.
Normally this is very fast, but attachments can significantly slow this down
due to the large size.

