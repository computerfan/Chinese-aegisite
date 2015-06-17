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

需要注意的是，具有相同模板名称的两个模板行在应用时会被拼接到一起，这个名称可以自定义，但不能与现有的修饰语相同。

无名称模板不能含有行前内容。(can not have pre-line template text)

Code行不能被命名。

已命名模板行的顺序合并是在卡拉OK模板执行器解析模板时发生的，而不是在模板执行时。

{{Examplebox|
    Comment: 0,0:00:00.00,0:00:05.00,Default,,0000,0000,0000,<u>code line</u>,fxgroup.funky = line.actor == "funky"

这个 code 行对每个输入行运行一次。它开启/关闭一个特效群，依靠输入行的说话人信息进行判断。
}}
{{Examplebox|
    Comment: 0,0:00:00.00,0:00:05.00,Default,,0000,0000,0000,<u>template line</u>,{\r\t($start,$end,\bord0)}

这个模板行声明了一个无名称的行类模板。效果是在音节的持续时间内边框粗度由默认值变成0。
}}
{{Examplebox|
    Comment: 0,0:00:00.00,0:00:05.00,Default,,0000,0000,0000,<u>template line jumper</u>,{\r\t($start,$mid,\frz-0.1)\t($mid,$end,\frz0}

这个模板行声明了一个名称为"jumper"的行类模板，配合下面给出的行前(pre-line)模板，能产生 "跳跃" 的特效。
}}


### pre-line _[name]_  ###


这个类型的修饰语只对行类模板有效。

 `pre-line` 修饰语后可以添加模板名称，具有相同模板名称的模板会一起被应用。这个模板名称不能与现有的任何修饰语相同。

无名称模板如果只有 pre-line 修饰语，那么模板执行后输入行会被保留，同时生成的新行前加入了模板行的内容。

有名称的 pre-line 模板行会按顺序把模板内容叠加。最后合成的一个模板再进行应用，所以这些模板内容是在解析模板时进行的，而不是执行时。

{{Examplebox|
    Comment: 0,0:00:00.00,0:00:05.00,Default,,0000,0000,0000,<u>template pre-line</u>,{\be1}

这个模板行声明了一个无名称的行类模板，这个模板会给每个匹配到的行添加 <tt>{\be1}</tt> 标签。
}}
{{Examplebox|
    Comment: 0,0:00:00.00,0:00:05.00,Default,,0000,0000,0000,<u>template pre-line jumper</u>,{\org(-10000,$y)}

这个模板行会和名称为 "jumper" 的模板进行合成，如果不存在这样的模板行，它会自己创建。和上面的模板一起使用，会使每个音节产生 "跳跃" 效果。
}}


### syl  ###


这个修饰语对 code行和 template行都可用。

Syl(音节)类的模板不能被命名。

{{Examplebox|
    Comment: 0,0:00:00.00,0:00:05.00,Default,,0000,0000,0000,<u>template syl</u>,{\pos($x,$y)}

这个模板行声明了一个 syl 类模板，它的作用是拆分音节后保持音节字符原来的位置。
}}


### furi  ###


这个类型的修饰语对 code行 和 template行都有效。

Furi(假名标注)类模板不能被命名。

{{Examplebox|
    Comment: 0,0:00:00.00,0:00:05.00,Default,,0000,0000,0000,<u>template furi</u>,{\pos($x,$y)}

这个模板行声明了一个furi 类模板，它用来简单地修改音节字符的位置。你需要做的只是在输入行中写出标准的假名标注格式。
}}


### syl furi  ###


同时使用 `syl` 和 `furi` 类修饰语是可行的。它会生成两个不同的行，这两个行分别由 syl 类模板和 furi 类模板生成。

这是同时使用多类修饰语的唯一可能性，换句话说是独有的用法。


## 其它修饰语  ##



### all  ###


把模板应用到所有的样式上，而不只是和模板行样式相同的行。

对 code行和 template行都可用。

{{Examplebox|
    Comment: 0,0:00:00.00,0:00:05.00,Default,,0000,0000,0000,<u>template syl all</u>,{\pos($x,$y)}

这个模板会被应用于字幕文件中多有单独的音节，无视样式。
}}


### char  ###


使模板的工作对象变为每个字符，而不是每个音节。它会以值得注意的方式改变应用顺序，查看 [[模板执行和执行顺序|Automation/Karaoke_Templater/Template_execution_rules_and_order]] 来获取相信信息。

它用于 code行时，一般没什么意义，在上面的链接中可以了解到。

{{Examplebox|
    Comment: 0,0:00:00.00,0:00:05.00,Default,,0000,0000,0000,<u>template syl char</u>,{\pos($x,$y)}
    Comment: 1,0:00:00.00,0:00:05.00,Default,,0000,0000,0000,<u>template syl char</u>,{\pos($x,$y)\bord0}

行中每个单独字符都会被分别定位。对于每个音节 For each syllable, each template will apply for all characters in one go, and not be applied interleaved.

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

