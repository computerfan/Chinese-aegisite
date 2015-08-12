{::options toc_levels="1..6" /}

Automation 4的核心文件 `karaskel.lua` 内置了许多函数，用来协助Automation 4 Lua方面的卡拉OK特效制作
它定义了几种新的数据结构，也拓展了Automation 4 本身定义的一些。

`karaskel.lua` 包含
[[`utils.lua`|Automation/Lua/Modules/util]] 和
[[`unicode.lua`|Automation/Lua/Modules/unicode]] 所以你在使用`karaskel.lua`不必再单独include这两项。

 `karaskel.lua` 的用武之地主要是卡拉OK特效，它也可以被用来进行一些简单的文字样式调整。

## Functions ##

### karaskel.collect_head  ###

Synopsis: `meta, styles = karaskel.collect_head(subtitles, generate_furigana)`{:.language-lua}

Reads the subtitle file to collect all header information and style
definitions, and optionally also generates new styles for furigana layouts.

* `subtitles` is the Subtitle File object defined by Automation 4 Lua.
* `generate_furigana` is a boolean: if it is true a style for [[furigana
  layout|Furigana_karaoke]] is generated for each style that does not have
  one already. Generation of furigana styles will never overwrite existing
  styles, create double style definitions or create meaningless furigana
  styles for other furigana styles.

Calling `collect_head` is usually one of the first things you do in your
processing function.

The returned `meta` table contains a map of all `Name: Value` pairs in the
`[Script Info]` section. It also always contains `meta.res_x` and
`meta.res_y` calculated from the `PlayResX` and `PlayResY` fields,
following VSFilter conventions for default values when one or both of the
fields are missing.

The returned `styles` table contains a map of all defined styles, along
with any generated furigana layout styles. The style structures stored in
this table have one added field, `style.margin_v` which is an alias for
`style.margin_t`, for convenience. `styles` can be indexed by style names
(case sensitive, names not mangled) and by numbers. `styles.n` is the
number of styles stored, and `styles[1]` is the first style defined.

### karaskel.preproc_line  ###
Synopsis: `karaskel.preproc_line(subtitles, meta, styles, line)`{:.language-lua}

Calculate sizing, positioning and various other information for a single
subtitle line. This function calls `karaskel.preproc_line_text`,
`karaskel.preproc_line_size` and `karaskel.preproc_line_pos` in order.

This function does not return a value, but rather modifies the `line`
table. See below for more information.

### karaskel.preproc_line_text  ###
Synopsis: `karaskel.preproc_line_text(meta, styles, line)`{:.language-lua}

Preprocess the text of a single line. `meta` and `styles` are the tables
returned by `[[karaskel.collect_head|karaskel.lua#karaskel.collect_head]]`.

This function does not return a value, but rather modifies the `line`
table. The following fields are added:

* `line.text_stripped` - Line text with all override tags and vector
  drawings removed.
* `line.duration` - Duration of the line in milliseconds
* `line.kara` and `line.furi` - Extended [[karaoke and furigana
  tables|karaskel.lua#karaoke-and-furigana-syllable-tables]], without sizing and
  position data.

This function does not calculate any text sizing or positioning
information. (In fact it currently doesn't use the `meta` or `styles`
arguments at all.)

### karaskel.preproc_line_size  ###
Synopsis: `karaskel.preproc_line_size(meta, styles, line)`{:.language-lua}

Calculate sizing data for a line and all karaoke syllables and furigana
parts. Also adds a reference to the line style.

This function does not return a value, but rather modifies the `line`
table. The following fields are added:

* `line.styleref` - A reference to the Style table representing this line's
  selected style.
* `line.furistyle` - A reference to the Style table representing this
  line's furigana layout style. If there is no style with the right name,
  this field is `false` instead.
* `line.width`, `line.height`, `line.descent` and `line.extlead` - Sizing
* information for the stripped line text, as returned by
* [[`aegisub.text_extents`|Automation/Lua/Miscellaneous_APIs#aegisub.text_extents]].

Also, this function modifies the `line.kara` and `line.furi` tables, adding
sizing information.

No position information is calculated here.

If the `line` table does not seem to have been processed with
`karaskel.preproc_line_text` yet, this will be done automatically.

### karaskel.preproc_line_pos  ###
Synopsis: `karaskel.preproc_line_pos(meta, styles, line)`{:.language-lua}

Calculate line, karaoke and furigana position information.

This function invokes `karaskel.do_basic_layout` when no furigana style is
available, and `karaskel.do_furigana_layout` when a furigana style is
defined for the line. The furigana layout algorithm might change the
calculated width of the line.

This function does not return a value, but rather modifies the `line`
table. The following fields are added:

* `line.margin_v` - A convenience alias for `line.margin_t`.
* `line.eff_margin_l`, `line.eff_margin_r`, `line.eff_margin_t`,
  `line.eff_margin_b` and `line.eff_margin_v` - Effective margin values for
  the line. If the corresponding margin override for the line is non-zero,
  that value is used, otherwise the value defined in the style is used.
* `line.halign` - One of `"left"`, `"center"` or `"right"`, the horizontal
  alignment of the line, derived from `line.styleref.align`.
* `line.valign` - One of `"top"`, `"middle"` or `"bottom"`, the vertical
  alignment of the line, derived from `line.styleref.align`.
* `line.left` - The left edge X coordinate for the line, assuming its given
  alignment, effective margins and no collision detection.
* `line.center` - The line centre X coordinate, assuming its given
  alignment, effective margins and no collision detection.
* `line.right` - The right edge X coordinate for the line, assuming its
  given alignment, effective margins and no collision detection.
* `line.top` - The top edge Y coordinate for the line, assuming its given
  alignment, effective margins and no collision detection.
* `line.middle` - The line vertical centre Y coordinate, assuming its given
  alignment, effective margins and no collision detection. `line.vcenter` is
  an alias for this.
  `line.bottom` - The bottom edge Y coordinate for the line, assuming its
  given alignment, effective margins and no collision detection.
* `line.x` and `line.y` - X and Y coordinates for the line, suitable for
  using in a `\pos` override tag to get the line's original position.

Furthermore, the `line.kara` and `line.furi` tables are modified by the
layout function called, adding positioning information.

See the part on [[data structures|karaskel.lua#datastructures]] later on
this page for more details on the various fields that are added.

If no line sizing information is found, `karaskel.preproc_line_size` will
be invoked, which might in turn also invoke `karaskel.preproc_line_text`.

### karaskel.do_basic_layout  ###
This function is not intended to be called directly, but is rather called
as a helper function for `karaskel.preproc_line_pos`.

It runs a very simple layout algorithm for the `line.kara` table, which
simply calculates the positions of the syllables when placed in one
straight line with no additional spacing in between. Positioning
information is added to each karaoke syllable.

The `line.furi` table is not touched.

### karaskel.do_furigana_layout  ###
This function is not intended to be called directly, but is rather called
as a helper function for `karaskel.preproc_line_pos`.

It runs an advanced text layout algorithm to position karaoke syllables and
furigana neatly, avoiding unwanted overlapping. People interested in the
actual algorithm used should read the function source code. It should be
well enough commented.

This function adds positioning information to both the `line.kara` and
`line.furi` tables. It might also change the `line.width` field as the line
base text is expanded to make room for furigana.

## Karaoke skeletons  ##
A karaoke skeleton is a framework for building karaoke effects in. It
usually works by writing a couple of functions yourself for handling the
actual effect work, and these are then called at various times. The actual
details of what functions you need to write depends on the actual karaoke
skeleton.

### Effect Library  ###
Main function: `karaskel.use_fx_library_furi(use_furigana, add_macro)`

Call the `karaskel.use_fx_library_furi` function to install the Effect
Library skeleton for this script file. The `script_name` and
`script_description` globals are used to name the export filter produced.
If `use_furigana` is true, furigana styles are created and added as needed.
If `add_macro` is true, a macro is registered in addition to the export
filter.

The basic premise of the Effect Library skeleton is that each timed karaoke
line has a word in its Effect field that describes what effect to apply to
that line. This makes Effect Library a good choice if you want to use
several different effects in a single karaoke.

When Effect Library is invoked, it calls a function named `fx_`_effect_ for
each Dialogue line in the subtitle file. For example, if the Effect field
of a dialogue line is _"jump"_, the function named `fx_jump` is called. For
lines with empty Effect field, the function `fx_none` is called.

If an `fx` function does not exist, the original line is left in the subtitle
file. Otherwise, whether the original line is left depends on the return
value of the `fx` function, a true return value means the original line is
kept, a false value means it is made into a Comment line.

Signature of `fx` functions: `keep = fx_effect(subtitles, meta, styles, line, fxdata)`

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
  `line.eff_margin_b` and `line.eff_margin_v` - Effective margin values for
  the line. If the corresponding margin override for the line is non-zero,
  that value is used, otherwise the value defined in the style is used.
* `line.halign` - One of `"left"`, `"center"` or `"right"`, the horizontal
  alignment of the line, derived from `line.styleref.align`.
* `line.valign` - One of `"top"`, `"middle"` or `"bottom"`, the vertical
  alignment of the line, derived from `line.styleref.align`.
* `line.left` - The left edge X coordinate for the line, assuming its given
  alignment, effective margins and no collision detection.
* `line.center` - The line centre X coordinate, assuming its given
  alignment, effective margins and no collision detection.
* `line.right` - The right edge X coordinate for the line, assuming its
  given alignment, effective margins and no collision detection.
* `line.top` - The top edge Y coordinate for the line, assuming its given
  alignment, effective margins and no collision detection.
* `line.middle` - The line vertical centre Y coordinate, assuming its given
  alignment, effective margins and no collision detection `line.vcenter` is
  an alias for this.
* `line.bottom` - The bottom edge Y coordinate for the line, assuming its
  given alignment, effective margins and no collision detection.
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

