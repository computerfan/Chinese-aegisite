汉字计时器使得把打好K值的时间轴快速赋予到一条未打K值的时间轴非常方便。它多用于日文歌曲的卡拉OK时间轴制作。(常用于快速对应日文和罗马音)

这里有个汉字计时器的实际操作演示视频: [下载演示视频](http://www.animereactor.dk/aegisub/demovids/kanji-timer.avi) (XviD MP3 AVI, 5 min 20 sec, 12 MB)


## 在你操作前 ##

汉字计时器会尝试把打好K值的行(由用户指定样式的行)中的音节和未打K值的行(另一个指定样式的行)中的音节配对。换句话说，打好K值的行应该具有统一的一个样式(例如"romaji")未打K值的行应该具有统一的另一个样式(例如"kanji")。 打K的行比未打K的行多是不行的，反过来也一样。下面会展示几种汉字计时器正常工作的情况，我们应该尽量保证行与行之间是这样:

    已打K的行 1
    未打K的行 1
    已打K的行 2
    未打K的行 2

或者这样:

    已打K的行 1
    已打K的行 2
    未打K的行 1
    未打K的行 2

这样则 **不行** (配对错误):

    已打K的行 1
    已打K的行 2
    未打K的行 2
    未打K的行 1

## 使用汉字计时器 ##

汉字计时器对话框看起来是这样:

[[img/Kanji_timer.png]]{: class="center"}

你应该做的第一件事就是分别选择用于输入(获取)时间和输出(设置)时间的两个样式。你可以在对话框的右上角调整；上方的下拉菜单用于选择源(从中获取时间)样式，下方的下拉菜单用于选择目标样式(应用时间于)。当你选择完这两项，点击开始按钮。

Now, you'll see the first syllable of the first source line highlighted in the source text field, and a suggestion for the destination syllable highlighted in the destination field. What you do now is "group" each source syllable with one or more kanji (or other syllables) in the destination. This is done using the following keyboard shortcuts:

Enter
: Accept the highlighted grouping (and go to next line if all syllables are grouped).

Right arrow
: Increase the destination highlight length.

Left arrow
: Decrease the destination highlight length.

Up arrow
: Increase the source highlight length.

Down arrow
: Decrease the source highlight length.

Backspace
: Un-groups (or unlinks) the last accepted syllable and lets you try to group it again (useful if you make a mistake).
{: .dl-horizontal}

## Things to note ##

* Don't use the mouse to change the highlights; it confuses the tool a lot. Use the keyboard shortcuts instead, they're much faster.
* The destination line can already be k-timed, but if it is, the kanji timer will overwrite those timings.
* Empty syllables will be copied alone, or will be combined with the surrounding syllables if those are to be combined.
* Any ASS override tags appearing before each \k will be copied directly without modification, but tags after each \k is currently not copied at all.
* If you have more source than destination lines or vice versa, you can use the "Skip source line" or "Skip destination line" to make sure the pairing of source/destination lines is correctly done.

