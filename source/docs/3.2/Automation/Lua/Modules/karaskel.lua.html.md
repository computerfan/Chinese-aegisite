{::options toc_levels="1..6" /}

Automation 4的核心文件 `karaskel.lua` 内置了许多函数，用来协助Automation 4 Lua方面的卡拉OK特效制作
它定义了几种新的数据结构，也拓展了Automation 4 本身定义的一些。

`karaskel.lua` 包含
[[`utils.lua`|Automation/Lua/Modules/util]] 和
[[`unicode.lua`|Automation/Lua/Modules/unicode]] 。所以你在使用`karaskel.lua`时不必再单独include这两项。

 `karaskel.lua` 的用武之地主要是卡拉OK特效，它也可以被用来进行一些简单的文字样式调整。

## 函数 ##

### karaskel.collect_head  ###

摘要: `meta, styles = karaskel.collect_head(subtitles, generate_furigana)`{:.language-lua}

读取字幕文件来获取所有的头部信息和样式定义,也可以为假名生成新的样式。

* `subtitles` 指的是Automation 4 Lua定义的字幕文件对象。
* `generate_furigana` 是在这种逻辑下进行的操作: 它会为没有对应 [[假名布局|Furigana_karaoke]] 的样式单独生成样式。生成的假名样式永远也不会覆盖存在的样式。

使用 `collect_head` 一般情况下是你在处理函数中做的第一步。

返回的 `meta` 表包含着以下全部， `Name: Value` 对应到 `[Script Info]` 部分。它也包含 `meta.res_x` 和 `meta.res_y` ,它们对应到 `PlayResX` and `PlayResY` 。


返回的 `styles` 表包含着全部已定义的样式, 也包含着自动生成的假名样式, 样式结构在style表中占有单独的位置,如`style.margin_v` (又称 `style.margin_t`), 为了方便, `styles` 可以通过样式名称
(区分大小写,不可缺内容) 和数字来指定。 `styles.n` 是样式存储的编号, `styles[1]` 就是第一个被定义的样式。

### karaskel.preproc_line(预处理行)  ###
摘要: `karaskel.preproc_line(subtitles, meta, styles, line)`{:.language-lua}

为单行字幕计算尺寸、位置和其它信息。这个函数按顺序调用 `karaskel.preproc_line_text`,
`karaskel.preproc_line_size` 和 `karaskel.preproc_line_pos` 。

这个函数不会返回值，但是在修饰 `line` 表的时候例外。详见下。

### karaskel.preproc_line_text(预处理行文本)  ###
摘要: `karaskel.preproc_line_text(meta, styles, line)`{:.language-lua}

预处理单行的文本。 `meta` 和 `styles` 是由 `[[karaskel.collect_head|karaskel.lua#karaskel.collect_head]]` 返回的表。

这个函数不会返回值，但是在修饰 `line` 表的时候例外:

* `line.text_stripped` - 返回除去特效标签和绘图代码的原文本
* `line.duration` - 返回行的持续时间(毫秒单位)
* `line.kara` 和 `line.furi` - 扩展版的 [[卡拉OK和假名标注表|karaskel.lua#karaoke-and-furigana-syllable-tables]], 不含尺寸位置信息。

这个函数不计算任何尺寸和位置信息。 (事实上它根本不使用 `meta` 或者 `styles` 之前获取到的尺寸位置信息)

### karaskel.preproc_line_size(预处理行尺寸)  ###
摘要: `karaskel.preproc_line_size(meta, styles, line)`{:.language-lua}

为整行、所有的音节和假名标注计算尺寸，参照行样式信息。

这个函数不会返回值，但是在修饰 `line` 表的时候例外:

* `line.styleref` - 参照样式表，返回当前被应用模板的行的样式表。
* `line.furistyle` - 参照样式表，返回当前被应用模板的行对应假名标注的样式表。如果没有匹配的样式名称这个区域就为 `false` (假)
* `line.width`, `line.height`, `line.descent` 和 `line.extlead` - 原文本的尺寸信息，由 [[`aegisub.text_extents`|Automation/Lua/Miscellaneous_APIs#aegisub.text_extents]]
返回。
这个函数也修饰 `line.kara` 和 `line.furi` 表, 增加尺寸信息。

这一部分不涉及位置信息的计算。

如果 `line` 看起来没被 `karaskel.preproc_line_text` 处理过，那么这个步骤会自动完成。

### karaskel.preproc_line_pos(预处理行位置)  ###
摘要: `karaskel.preproc_line_pos(meta, styles, line)`{:.language-lua}

计算行、卡拉OK和假名标注的位置信息。

当没有可用的假名标注样式时，这个函数借助 `karaskel.do_basic_layout`, 当有可用的假名标注样式时借助 `karaskel.do_furigana_layout` 。假名布局算法可能改变行的计算宽度。

这个函数不会返回值，但是在修饰 `line` 表的时候例外:

* `line.margin_v` -  `line.margin_t` 的别名。
* `line.eff_margin_l`, `line.eff_margin_r`, `line.eff_margin_t`, `line.eff_margin_b` 和 `line.eff_margin_v` - 该行的有效边距值。如果某一行对应的值非零，则使用这些值，否则会使用样式管理器中定义的值。
* `line.halign` - 三种水平对齐方式 `"left"`, `"center"` 或 `"right"`中的一种，是由 `line.styleref.align`派生出来的。
* `line.valign` - 三种竖直对齐方式 `"top"`, `"middle"` 或 `"bottom"中的一种, 是由 `line.styleref.align`派生出来的。
* `line.left` - 行左边缘的X坐标，假设定义了对齐，有效边距，并且未检测到重叠。
* `line.center` - 行水平中点的X坐标，假设定义了对齐，有效边距，并且未检测到重叠。
* `line.right` - 行右边缘的X坐标，假设定义了对齐，有效边距，并且未检测到重叠。
* `line.top` - 行上边缘的Y坐标，假设定义了对齐，有效边距，并且未检测到重叠。
* `line.middle` - 行竖直中点的Y坐标，假设定义了对齐，有效边距，并且未检测到重叠。别名`line.vcenter`。
  `line.bottom` - 行下边缘的Y坐标，假设定义了对齐，有效边距，并且未检测到重叠。
* `line.x` 和 `line.y` - 行的X 和 Y 坐标，适合与 `\pos` 配合使用，保持行的原位置。

此外, `line.kara` 和 `line.furi` 表是被布局函数调用，然后加上位置信息。

详见这部分 [[data structures|karaskel.lua#datastructures]] 。

如果没有找到任何行的尺寸信息, `karaskel.preproc_line_size` 会被调用, 它可能会转而调用 `karaskel.preproc_line_text`。

### karaskel.do_basic_layout(基本布局)  ###
这个函数不是被直接调用的，它更像是一个 `karaskel.preproc_line_pos` 的辅助函数。

它为 `line.kara` 表运行一个简单的布局算法，简单地计算一行中各个音节的位置。位置信息被添加到各个音节。

 `line.furi` 表在这个函数中不被处理。

### karaskel.do_furigana_layout(假名标注布局)  ###
这个函数也不是被直接调用的，它更像是一个 `karaskel.preproc_line_pos` 的辅助函数。

它为运行一个高级的布局算法，来把卡拉OK音节和假名标注整齐地排布，还能防止重叠。对这部分使用的算法感兴趣的人可以读读源码。


这个函数为 `line.kara` 和 `line.furi` 表添加位置信息。它也有可能改变 `line.width` ，因为行宽度可能受假名标注影响而变化。

## Karaoke skeletons(卡拉OK框架) ##
卡拉OK框架是指帮助你构筑卡拉OK特效的一套框架。你可以在一些自定义函数中使用它，来解决特定的特效问题，框架中的内容会多次被调用。你具体需要写什么样的函数也取决于卡拉OK框架。

### Effect Library(特效库)  ###
主函数: `karaskel.use_fx_library_furi(use_furigana, add_macro)`

调用 `karaskel.use_fx_library_furi` 函数为当前脚本安装 特效库 框架。`script_name` 和
`script_description` 全局变量用来命名导出滤镜。 
如果 `use_furigana` 为真, 则会生成专门的标注假名样式。
如果 `add_macro` 为真, 则会在导出滤镜处添加宏。

使用特效库功能的前提是在每一打好K值行的特效栏填写了你希望应用的特效类型（名称）。
如果你想在一个文件里应用多种卡拉OK效果，这是一个很好的选择。

当特效库函数被调用,它会首先为每个对话行调用 _"fx_特效"_ 。举个例子, 如果某个对话行的特效栏填写的是 _"jump"_, 则名为 `fx_jump` 的函数将会被调用。对于特效栏为空的对话行, 函数 `fx_none` 将会被调用。

如果指明的 `fx` 函数并不存在，那么原始的行将会被保留。否则，原始行是否存在取决于 `fx` 函数在返回部分的写法。返回真值则意味着保留原始行，否则将会把原始行设置为注释行。

`fx` 函数用法: `keep = fx_effect(subtitles, meta, styles, line, fxdata)`

`fxdata` is the contents of the Effect field after the initial word
defining the effect to be used. All output of an `fx` function should be
appended to the subtitle file represented by `subtitles`.

Simplified main function: `karaskel.use_fx_library(add_macro)`

Identical to the `_furi` variant above, except that the `use_furigana`
parameter is removed; it is assumed to be false.

### Classic Advanced  ###
Main function: `karaskel.use_classic_adv(use_furigana, add_macro)`

Call the `karaskel.use_classic_adv` function to install the Classic
Advanced skeleton for this script file. The `script_name` and
`script_description` globals are used to name the export filter produced.
If `use_furigana` is true, furigana styles are created and added as needed,
and furigana processing is enabled. If `add_macro` is true, a macro is
registered in addition to the export filter.

This skeleton is created in the image of the Automation 3 `karaskel-adv`
skeleton, but it is _not_ compatible with it. (You cannot use a
`karaskel-adv` script with Classic Advanced without rewriting parts of your
script.) The basic premise is that the `do_syllable` function is called
once for each syllable. Optionally, you can have a function called for each
line, using the `do_line` function.

Classic Advanced uses a slightly different model than the usual Automation
4 Lua one. Here all subtitle lines are collected first before any further
processing is done. They also have `line.prev` and `line.next` fields
added, to allow linked list style access. To add lines to the output, you
must still add lines to the `subs` object though. Before processing starts,
all original lines are _deleted_ from the `subs` object.

Signature of syllable function: `do_syllable(subs, meta, styles, lines, line, syl)`

The syllable function _must_ be named `do_syllable`. If furigana processing
is enabled, you can also define a function called `do_furigana` with the
same signature, to process furigana syllables. Furigana still follows the
Automation 4 model here.

Signature of line function: `do_line(subs, meta, styles, lines, line, default_do_line)`

Defining a line function is optional, and is often not required. The line
function _must_ be named `do_line` if it exists. The `default_do_line`
parameter is the function that would be called if `do_line` didn't exist.
You can call it to run the default line processing along with your own
processing.

## Data structures  ##
`karaskel.lua` defines and extends several data structures. Some of the
changes are already listed above under the individual functions.

### Styles array  ###
The `styles` array is produced by the `karaskel.collect_head` function and
should be passed to most other `karaskel.lua` functions. It contains a list
of all styles in the subtitle file, and can be accessed in two ways.

`styles.n` is a number telling the number of styles in the array.
`styles[1]` is the first defined style and `styles[styles.n]` is the last
defined style.

The `styles` array can also be indexed by style names, such that
`styles[style.name] == style`. The names are not mangled and the indexing
is case sensitive.

Be aware that modifying the `styles` will never update the subtitles file,
and conversely updating the styles in the subtitle file will not
automatically be reflected in `styles` either.

### Style table  ###
This is a slight extension of the basic `style` class subtitle line structure.

One field is added:

* `style.margin_v` is a convenience alias for `style.margin_t`.

Full list of fields:

* `style.class == "style"`
* `style.raw` - The raw line text.
* `style.section == "[V4+ Styles]"`
* `style.name` - Name of the style.
* `style.fontname` - Name of the font face used by the style.
* `style.fontsize` - Font size for the style.
* `style.color1`, `style.color2`, `style.color3` and `style.color4` - The
  four colours used by the style, in regular order. Use
  `[[extract_color|Automation/Lua/Modules/#extractcolor]]` and family to
  manipulate these.
* `style.bold` - `true`/`false` to specify bold/non-bold font face. Can
  also be a number to specify font weight, but this is not well supported
  and should be avoided.
* `style.italic` - Boolean, whether an italic/oblique version of the font
  face is used or not.
* `style.underline` and `style.strikeout` - Boolean, whether to apply these
  two decorations to the text.
* `style.scale_x` and `style.scale_y` - Scaling in X and Y direction, 100
  is neutral.
* `style.spacing` - Additional spacing in pixels between individual
  characters in text.
* `style.angle` - Z axis rotation for the text.
* `style.borderstyle`  - 1 (one) for regular outlined text, 3 for opaque
  box behind subtitles.
* `style.outline` - Width of the extended outline around the text.
* `style.shadow` - Distance to the shadow behind the text.
* `style.align` - Numpad-style alignment for the text on screen.
* `style.margin_l`, `style.margin_r`, `style.margin_t` and `style.margin_b`
  - Margins for the style. `style.margin_v` is an alias for top margin.
* `style.encoding` - Windows font encoding ID for the style.
* `style.relative_to` - Currently unsupported.
* `style.vertical` - Unsupported, tentative AS5 feature.

### Dialogue line table  ###
A large number of new fields have been added to the dialogue line class.

Basic fields:

* `line.class == "dialogue"`, also for comment lines
* `line.raw` - The raw line text.
* `line.section` - Usually `"[Events]"`.
* `line.comment` - Boolean, true if the line is a Comment line rather than
  Dialogue.
* `line.layer` - Layer of the line.
* `line.start_time`, `line.end_time` - Start and end times of the line in
  milliseconds.
* `line.style` - Name of the style used for the line.
* `line.actor` - Actor field for the line.
* `line.margin_l`, `line.margin_r`, `line.margin_t` and `line.margin_b` -
  Margin overrides for the line, a zero value means use margin from style.
* `line.effect` - Effect field of the line.
* `line.userdata` - Unused.
* `line.text` - Dialogue text.

Basic added fields, by `karaskel.preproc_line_text`:

* `line.text_stripped` - Line text with all override tags and vector
  drawings removed.
* `line.duration` - Duration of the line in milliseconds
* `line.kara` and `line.furi` - Array tables of extended karaoke and
  furigana tables, respectively. They do not contain sizing and positioning
  data from the beginning.

Added fields for sizing, by `karaskel.preproc_line_size`:

* `line.styleref` - A reference to the Style table representing this line's
  selected style.
* `line.furistyle` - A reference to the Style table representing this
  line's furigana layout style. If there is no style with the right name,
  this field is `false` instead.
* `line.width`, `line.height`, `line.descent` and `line.extlead` - Sizing
  information for the stripped line text, as returned by
  `aegisub.text_extents`. `line.width` may also be modified by
  `karaskel.preproc_line_pos`.

Added fields for positioning, by `karaskel.preproc_line_pos`:

* `line.margin_v` - A convenience alias for `line.margin_t`.
* `line.eff_margin_l`, `line.eff_margin_r`, `line.eff_margin_t`,
  `line.eff_margin_b` and `line.eff_margin_v` - 有效 margin values for
  the line. If the corresponding margin override for the line is non-zero,
  that value is used, otherwise the value defined in the style is used.
* `line.halign` - One of `"left"`, `"center"` or `"right"`, the horizontal
  alignment of the line, derived from `line.styleref.align`.
* `line.valign` - One of `"top"`, `"middle"` or `"bottom"`, the vertical
  alignment of the line, derived from `line.styleref.align`.
* `line.left` - The left edge X coordinate for the line, assuming its given
  alignment, 有效 margins and no collision detection.
* `line.center` - The line centre X coordinate, assuming its given
  alignment, 有效 margins and no collision detection.
* `line.right` - The right edge X coordinate for the line, assuming its
  given alignment, 有效 margins and no collision detection.
* `line.top` - The top edge Y coordinate for the line, assuming its given
  alignment, 有效 margins and no collision detection.
* `line.middle` - The line vertical centre Y coordinate, assuming its given
  alignment, 有效 margins and no collision detection `line.vcenter` is
  an alias for this.
* `line.bottom` - The bottom edge Y coordinate for the line, assuming its
  given alignment, 有效 margins and no collision detection.
* `line.x` and `line.y` - X and Y coordinates for the line, suitable for
  using in a `\pos` override tag to get the line's original position.

Added fields for linked list access, only available when using the Classic
Advanced skeleton:

* `line.prev`, `line.next` - Access the dialogue line before and after this
  one. These might be `nil` on the first/last dialogue lines. Blank lines,
  style lines, header lines etc. are _not_ included in this linked list.

### Karaoke and furigana syllable tables  ###
Tables for regular karaoke syllables and furigana parts are identical in
(almost) every aspect, and can usually be processed by the same code
without problems. There are a few points to take note of which are marked.
Everywhere it says `syl` here, you can replace that with `furi` unless
otherwise noted.

Basic fields, defined by `aegisub.parse_karaoke_data`:

* `syl.duration` - syllable duration in milliseconds (divide by 10 to get a
  number suitable for `\k` tags.)
* `syl.start_time`, `syl.end_time` - Start and end time of the syllable in
  milliseconds, relative to the start time of the line.
* `syl.tag` - The name of the tag defining this syllable, without
  backslash. It will usually be one of `k`, `K`, `kf` or `ko`. Note that
  `kt` is not handled. Furigana parts have the same tag as the original
  syllable defining them.
* `syl.text` - Text including tags of the syllable. Same as stripped text
  for furigana.
* `syl.text_stripped` - Text of the syllable with all tags removed. For
  main syllables, this also has furigana and multi-highlight parts removed.
  This is the text you will usually want to use.

Additions by `karaskel.preproc_line_text`:

* `syl.kdur` - Syllable duration in centiseconds, suitable for use in `\k`
  tags.
* `syl.line` - Back reference to the line table containing this syllable.
* `syl.inline_fx` - Name of the [[_inline-fx_|Karaoke_inline-fx]] for this
  syllable.
* `syl.i` - Index number of this syllable.
* `syl.prespace`, `syl.postspace` - Space characaters at the start/end of
  the syllable. Always blank for furigana. These are spaces included in
  `syl.text_stripped`. You will usually never need this.
* `syl.text_spacestripped` - Syllable text stripped for tags and trimmed of
  spaces at the start and end. This, `syl.prespace` and `syl.postspace`
  together can produce the same as `syl.text_stripped`. You will usually
  never need this.
* `syl.isfuri` - `true` if the table is a furigana table, `false` if it is
  not. If you use a single function to process both regular and furigana
  syllables, you can use this to do differentiated processing still.
* `syl.highlights` - Array table of multi-highlight data for the syllable.
  For furigana, there is always exactly one highlight defined. See below
  for format of highlight tables.

Additions by `karaskel.preproc_line_size`:

* `syl.style` - Reference to the style used to calculate sizing for this
  syllable. This will be the main line style for regular syllables and the
  furigana style for furigana. You should always set the style of the
  generated lines to this one.
* `syl.width`, `syl.height` - Width and height of `syl.text_spacestripped`,
  as returned by `aegisub.text_extents`.
* `syl.prespacewidth`, `syl.postspacewidth` - Width of `syl.prespace` and
  `syl.postspace` respectively. You will usually not need these. Always
  zero for furigana.

Additions by `karaskel.preproc_line_pos`:

* `syl.left`, `syl.center`, `syl.right` - Respectively left, center and
  right aligned positions of the syllable/furigana, for use with different
  alignments. The positions are _relative to the left edge of the line_,
  meaning you will need to add a value for line positioning to use these
  values to position syllables on screen. There is no guarantee that
  `syl.right` for one syllable is equal to `syl.left` for the next
  syllable.

{::template name="examplebox"}
~~~ lua
line.left + syl.center
~~~

Calculates the default X position of a syllable, suitable for use with
`\an2`, `\an5` or `\an8` alignment.
{:/}

#### Highlight table  ####
A highlight table defines one highlight of a multi-highlight timed
syllable.

Highlight tables are entirely defined by `karaskel.preproc_line_text`, and
contain the following fields:

* `hl.start_time`, `hl.end_time` - Start and end time of the highlight, in
  milliseconds, relative to the start of the line.
* `hl.duration` - Duration of the highlight in milliseconds.

{::template name="automation_navbox" /}

