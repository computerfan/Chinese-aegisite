template行和code行都可以带上几种修饰语

在修饰语和模板行类型中间请留一个半角空格，即在`template` 或 `code` 后面添加空格后再添加修饰语。

修饰语在一定程度上而不是所有情况下都是兼容的，它不是对所有的 code行和 template行都有效。

有一套修饰语用来声明 template行或 code行的类型。


## 声明类的修饰语  ##


模板行(template line)和代码行(code line)都可以在没有声明类的修饰语的情况下起作用。不过为了避免混淆还是推荐声明一下。

在没有声明类的修饰语的情况下，template行默认使用 `syl` 修饰语。

在没有声明类的修饰语的情况下， code行默认使用once修饰语。


### once  ###


这个声明类的修饰语只对 code行有效。

带有 `once` 修饰语的 code行在一次卡拉OK执行器的执行过程中只运行一次，一般都先于其它的code行或者模板行。它们是按声明的顺序执行的。

"code once" 行基本用来声明模板中使用的函数。

{{Examplebox|
    Comment: 0,0:00:00.00,0:00:05.00,Default,,0000,0000,0000,<u>code once</u>,function setlayer(newlayer) line.layer = newlayer; return ""; end

这个例子声明了一个新的函数，它用来控制输出行的 层次(Layer) 信息。
}}


### line _[name]_  ###


这个声明类的修饰语对 code行和 template行都有效。

When used on template lines it takes an optional parameter naming the line template the template line participates in. The template name must not match any template modifier names.

Anonymous line templates (with no template name given) can not have pre-line template text.

Code lines can not be named, they must be anonymous.

Named line template lines append to the template text in the order they appear. The appending of template text happens at template parse time, not at execution time.

{{Examplebox|
    Comment: 0,0:00:00.00,0:00:05.00,Default,,0000,0000,0000,<u>code line</u>,fxgroup.funky = line.actor == "funky"

This code line is run once per input line. It enables/disables an effect group named "funky" depending on the Actor field of the input line.
}}
{{Examplebox|
    Comment: 0,0:00:00.00,0:00:05.00,Default,,0000,0000,0000,<u>template line</u>,{\r\t($start,$end,\bord0)}

This template line declares an anonymous line template. The effect produced will transform the border of each syllable to zero during the syllable's duration.
}}
{{Examplebox|
    Comment: 0,0:00:00.00,0:00:05.00,Default,,0000,0000,0000,<u>template line jumper</u>,{\r\t($start,$mid,\frz-0.1)\t($mid,$end,\frz0}

This template line appends to a line template named "jumper"  or creates it if it doesn't exist. Together with the pre-line template example given below, this will produce a "jumping" effect for the syllables.
}}


### pre-line _[name]_  ###


This class modifier is only valid for template lines.

The `pre-line` modifier takes an optional parameter naming the line template the template line participates in. The template name must not match any template modifier names.

Anonymous line templates with only pre-line text leave the original input line text alone and just prepends the template text to the line.

Named pre-line template lines append to the pre-line template text in the order they appear. The appending of template text happens at template parse time, not at execution time.

{{Examplebox|
    Comment: 0,0:00:00.00,0:00:05.00,Default,,0000,0000,0000,<u>template pre-line</u>,{\be1}

This template line declares an anonymous line template, that will prepend <tt>{\be1}</tt> to all matching lines.
}}
{{Examplebox|
    Comment: 0,0:00:00.00,0:00:05.00,Default,,0000,0000,0000,<u>template pre-line jumper</u>,{\org(-10000,$y)}

This template line appends to the pre-line template text of a line template named "jumper", or creates it if it doesn't exist. Together with the line template example given above, this will produce a "jumping" effect for the syllables.
}}


### syl  ###


This class modifier is valid for both code lines and template lines.

Syl templates can not be named.

{{Examplebox|
    Comment: 0,0:00:00.00,0:00:05.00,Default,,0000,0000,0000,<u>template syl</u>,{\pos($x,$y)}

This template line declares a syl template that simply positions the syllable text.
}}


### furi  ###


This class modifier is valid for both code lines and template lines.

Furi templates can not be named.

{{Examplebox|
    Comment: 0,0:00:00.00,0:00:05.00,Default,,0000,0000,0000,<u>template furi</u>,{\pos($x,$y)}

This template line declares a furi template that simply positions the syllable text. It's not needed to do anything further to get correct furigana formatting.
}}


### syl furi  ###


It's possible to combine the `syl` and `furi` class modifiers. This results in two identical templates being generated from the template line, one syl template and one furi template.

This is the only possible combination of class modifiers, they are otherwise exclusive.


## Other modifiers  ##



### all  ###


Apply template to all styles, not just the one of the template line.

Applicable for both code lines and templates, and for all classes.

{{Examplebox|
    Comment: 0,0:00:00.00,0:00:05.00,Default,,0000,0000,0000,<u>template syl all</u>,{\pos($x,$y)}

This template will be applied to every single syllable in the entire subtitle file, regardless of the style of the line they are on.
}}


### char  ###


Make the template work per-character instead of per-syllable. This changes application order semantics in a significant way, see [[Template execution and order|Automation/Karaoke_Templater/Template_execution_rules_and_order]] for details.

While this will work on code lines, it is generally not useful, see the discussion on execution order.

{{Examplebox|
    Comment: 0,0:00:00.00,0:00:05.00,Default,,0000,0000,0000,<u>template syl char</u>,{\pos($x,$y)}
    Comment: 1,0:00:00.00,0:00:05.00,Default,,0000,0000,0000,<u>template syl char</u>,{\pos($x,$y)\bord0}

Every single character on the line will be positioned separately. For each syllable, each template will apply for all characters in one go, and not be applied interleaved.

For example, if there are two syllables, "ab" and "cd", and the above two templates are applied to them, the result will be 8 lines with the following text, in this order:

    {\pos($x,$y)}a
    {\pos($x,$y)}b
    {\pos($x,$y)\bord0}a
    {\pos($x,$y)\bord0}b
    {\pos($x,$y)}c
    {\pos($x,$y)}d
    {\pos($x,$y)\bord0}c
    {\pos($x,$y)\bord0}d
}}


### fx _name_  ###


Make template only apply to syllables that have the named [[inline-fx|Karaoke_inline-fx]]. Specifying an inline-fx name is required; the name may also overlap with template modifier names though this is not recommended.

{{Examplebox|
    Comment: 0,0:00:00.00,0:00:05.00,Default,,0000,0000,0000,<u>template syl fx drop</u>,{\move($x,$y,$x,!$y+30!,$start,$end)}

With this template, all syllables that have the inline-fx "drop" will get an additional line produced, where the syllables moves down 30 pixels during its duration.

All other template lines that don't have _fx_ specified will still be applied as usual to those syllables as well.
}}


### fxgroup _name_  ###


Declare template to be in the named effect group. Specifying an effect group name is required; the name may also overlap with template modifier names and Lua reserved words, though this is not recommended.

{{Examplebox|There is an example of _fxgroup_ on the [[Code execution environment|Automation/Karaoke_Templater/Code_execution_environment#conditionaltemplateswithfxgroup]] page.}}


### keeptags  ###


Specify that the original tags must be kept in the syllable after application.

This has no effect when combined with `char` or `multi`.

{{Examplebox|
    template line <u>keeptags</u>: {\r\t($start,!$start+1!,\frx40)\t(!$start+1!,$end,\frx0)}
    karaoke: {\k21}hi{\k10}gu{\k23}ra{\k22}shi {\k38}ga {\k37\1c&H0000FF&}na{\k37}ku

The syllables "tip" back over a bit during highlight. One of them ("na") is coloured differently by putting an override tag in the timed karaoke line, but the following syllables don't get it because of the customary `\r` at the start of the template.

The _notags_ modifier ensures that the special colour of the special syllable gets carried over to the output.
}}


### multi  ###


Make the template apply per-highlight in [[multi-highlight|Furigana_karaoke]] timed karaoke. This changes application order semantics in a significant way, see [[Template execution and order|Automation/Karaoke_Templater/Template_execution_rules_and_order]] for details.

While this will work on code lines, it is generally not useful, see the discussion on execution order.

{{Examplebox|
    template syl <u>multi</u>: {\an5\pos($scenter,$smiddle)\1a&HFF&\t($start,$end,\bord5\3a&HFF&)}
    karaoke: {\k33}風<u>{\k36}#</u>{\k89}の{\k46}花<u>{\k28}#</u>{\k57}よ

The timed karaoke line uses basic multi-highlight markup, the <tt>#</tt> syllables, to create multi-highlight syllables. Such, the 風 (ka-ze) and 花 (ha-na) kanji each get stored as a single syllable that gets two highlights each, and the <tt>#</tt> characters aren't displayed at all in the applied effect. (They will still display if you try to play the timed karaoke line without applying any templates.)

The template uses the _multi_ modifier to signal that it wants to use multi-highlights instead of just one highlight/application per displayed syllable. The effect is a kind of simple "exploding border", but it explodes twice on both the 風 and 花 kanji. If the _multi_ modifier wasn't there, it would only explode once on each.
}}


### noblank  ###


Specify that the template will not be applied to syllables considered "blank". A syllable is considered blank if its tag-stripped text consists only of a combination of ASCII whitespace characters and ideographic fullwidth space characters, or is completely empty. A syllable is also considered empty if its duration is zero.

> _See the _notext_ modifier below for an example._


### notext  ###


Specify that the original text will not be appended to the output line.

This is intended for use primarily with templates that output drawing tags and similar.

Not applicable for code lines.

{{Examplebox|
    code once: sword_shape = "m 0 0 l 5 -5 l 5 -30 l 10 -30 l 10 -32 l 2 -32 l 2 -40 l -2 -40 l -2 -32 l -10 -32 l -10 -30 l -5 -30 l -5 -5 "
    template syl notext noblank: {\an5\move($scenter,!$smiddle-30!,$scenter,$smiddle,!$start-20!,$start)\p2}!sword_shape!

The first code line defines a vector drawing shape for convenience, so it doesn't clutter up the actual template lines later on. The drawing is of a small simple sword pointing downwards. The effect itself is these small swords dropping down onto the syllables, by a move.

The template uses the _notext_ modifier to avoid getting the original syllable text shown, because it's being replaced with a vector drawing here. Also the _noblank_ modifier is used to avoid producing anything for "invisible" syllables, eg. we don't want a sword dropping down on a lone timed space, that just looks dumb.
}}


### repeat _n_, loop _n_  ###


Specify that the template will be applied the given number of times. Specifying the number of loops is required. The number of loops must be a constant integer number, it can not be a variable or otherwise calculated dynamically.

`repeat` and `loop` are synonymous.

Note that the execution order of looped line templates and looped syl/furi templates is different. See [[Template execution and order|Automation/Karaoke_Templater/Template_execution_rules_and_order]] for details.

{{Examplebox|
    template syl <u>loop 4</u>: {\move($x,$y,!$x+math.random(-30,30)!,!$y+math.random(-30,30)!,$start,$end)\alpha&Hc0&\t($start,$end,\alpha&HFF&)}

The _loop_ modifier is used to created 4 copies of the syllable for each time this template is run. Each of those move in a random direction, up to 30 pixels away in X and Y direction. They also fade out.

The starting alpha for each copy, `&Hc0` is chosen as 256 - (256 / 4), 4 being the number of loops made. This way, the opacity for each copy adds up to exactly 256. (Technically it should be 255, but that can't be achieved with an even number of loops.)
}}
> _Also see the examples on the [[Code execution environment|Automation/Karaoke_Templater/Code_execution_environment#loopingtemplates]] page for more advanced usage._

{::template name="automation_navbox" /}

