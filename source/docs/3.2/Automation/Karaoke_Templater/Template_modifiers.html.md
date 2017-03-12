---
title: 模版修饰语
---
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

{::template name="examplebox"} 
    Comment: 0,0:00:00.00,0:00:05.00,Default,,0000,0000,0000,<u>code once</u>,function setlayer(newlayer) line.layer = newlayer; return ""; end

这个例子声明了一个新的函数，它用来控制输出行的 层次(Layer) 信息。

{:/}

### line _[name]_  ###


这个声明类的修饰语对 code行和 template行都有效。

需要注意的是，具有相同模板名称的两个模板行在应用时会被拼接到一起，这个名称可以自定义，但不能与现有的修饰语相同。

无名称模板不能含有行前内容。(can not have pre-line template text)

Code行不能被命名。

已命名模板行的顺序合并是在卡拉OK模板执行器解析模板时发生的，而不是在模板执行时。

{::template name="examplebox"} 
    Comment: 0,0:00:00.00,0:00:05.00,Default,,0000,0000,0000,<u>code line</u>,fxgroup.funky = line.actor == "funky"

这个 code 行对每个输入行运行一次。它开启/关闭一个特效群，依靠输入行的说话人信息进行判断。
{:/}
{::template name="examplebox"} 

    Comment: 0,0:00:00.00,0:00:05.00,Default,,0000,0000,0000,<u>template line</u>,{\r\t($start,$end,\bord0)}

这个模板行声明了一个无名称的行类模板。效果是在音节的持续时间内边框粗度由默认值变成0。
{:/}
{::template name="examplebox"} 
    Comment: 0,0:00:00.00,0:00:05.00,Default,,0000,0000,0000,<u>template line jumper</u>,{\r\t($start,$mid,\frz-0.1)\t($mid,$end,\frz0}

这个模板行声明了一个名称为"jumper"的行类模板，配合下面给出的行前(pre-line)模板，能产生 "跳跃" 的特效。
{:/}


### pre-line _[name]_  ###


这个类型的修饰语只对行类模板有效。

 `pre-line` 修饰语后可以添加模板名称，具有相同模板名称的模板会一起被应用。这个模板名称不能与现有的任何修饰语相同。

无名称模板如果只有 pre-line 修饰语，那么模板执行后输入行会被保留，同时生成的新行前加入了模板行的内容。

有名称的 pre-line 模板行会按顺序把模板内容叠加。最后合成的一个模板再进行应用，所以这些模板内容是在解析模板时进行的，而不是执行时。

{::template name="examplebox"} 
    Comment: 0,0:00:00.00,0:00:05.00,Default,,0000,0000,0000,<u>template pre-line</u>,{\be1}

这个模板行声明了一个无名称的行类模板，这个模板会给每个匹配到的行添加 <tt>{\be1}</tt> 标签。
{:/}
{::template name="examplebox"} 
    Comment: 0,0:00:00.00,0:00:05.00,Default,,0000,0000,0000,<u>template pre-line jumper</u>,{\org(-10000,$y)}

这个模板行会和名称为 "jumper" 的模板进行合成，如果不存在这样的模板行，它会自己创建。和上面的模板一起使用，会使每个音节产生 "跳跃" 效果。
{:/}


### syl  ###


这个修饰语对 code行和 template行都可用。

Syl(音节)类的模板不能被命名。

{::template name="examplebox"} 
    Comment: 0,0:00:00.00,0:00:05.00,Default,,0000,0000,0000,<u>template syl</u>,{\pos($x,$y)}

这个模板行声明了一个 syl 类模板，它的作用是拆分音节后保持音节字符原来的位置。
{:/}


### furi  ###


这个类型的修饰语对 code行 和 template行都有效。

Furi(假名标注)类模板不能被命名。

{::template name="examplebox"} 
    Comment: 0,0:00:00.00,0:00:05.00,Default,,0000,0000,0000,<u>template furi</u>,{\pos($x,$y)}

这个模板行声明了一个furi 类模板，它用来简单地修改音节字符的位置。你需要做的只是在输入行中写出标准的假名标注格式。
{:/}


### syl furi  ###


同时使用 `syl` 和 `furi` 类修饰语是可行的。它会生成两个不同的行，这两个行分别由 syl 类模板和 furi 类模板生成。

这是同时使用多类修饰语的唯一可能性，换句话说是独有的用法。


## 其它修饰语  ##



### all  ###


把模板应用到所有的样式上，而不只是和模板行样式相同的行。

对 code行和 template行都可用。

{::template name="examplebox"} 
    Comment: 0,0:00:00.00,0:00:05.00,Default,,0000,0000,0000,<u>template syl all</u>,{\pos($x,$y)}

这个模板会被应用于字幕文件中多有单独的音节，无视样式。
{:/}


### char  ###


使模板的工作对象变为每个字符，而不是每个音节。它会以值得注意的方式改变应用顺序，查看 [[模板执行和执行顺序|Automation/Karaoke_Templater/Template_execution_rules_and_order]] 来获取相信信息。

它用于 code行时，一般没什么意义，在上面的链接中可以了解到。

{::template name="examplebox"} 
    Comment: 0,0:00:00.00,0:00:05.00,Default,,0000,0000,0000,<u>template syl char</u>,{\pos($x,$y)}
    Comment: 1,0:00:00.00,0:00:05.00,Default,,0000,0000,0000,<u>template syl char</u>,{\pos($x,$y)\bord0}

行中每个单独字符都会被分别定位。对于每个音节，每个模板对其中字符的应用也是一气呵成的，而不是被交错应用。

举个例子，如果行里有两个音节，"ab" 和 "cd"，上面给出的两个模板被应用于这两个音节，产生的结果会有8行:

    {\pos($x,$y)}a
    {\pos($x,$y)}b
    {\pos($x,$y)\bord0}a
    {\pos($x,$y)\bord0}b
    {\pos($x,$y)}c
    {\pos($x,$y)}d
    {\pos($x,$y)\bord0}c
    {\pos($x,$y)\bord0}d
{:/}


### fx _name_  ###


使模板只应用于含有内联特效 [[(inline-fx)|Karaoke_inline-fx]] 的音节。指定内联特效名称是必要的；内联特效名称也不建议和修饰语重复。

{::template name="examplebox"} 
    Comment: 0,0:00:00.00,0:00:05.00,Default,,0000,0000,0000,<u>template syl fx drop</u>,{\move($x,$y,$x,!$y+30!,$start,$end)}

使用这个模板，所有含有内联特效 "drop" 的音节会被模板处理，效果是音节会在持续时间向下移动30像素。

其它的不含有内联特效的模板会照常被应用。
{:/}


### fxgroup _name_  ###


声明这个模板属于一个有名称的特效组。指定特效组名称是必要的；该名称不建议和修饰语重复，也不建议和Lua保留词重复。

{::template name="examplebox"} 
有一个 _fxgroup_ 的例子，见 [[代码执行环境Code execution environment|Automation/Karaoke_Templater/Code_execution_environment#conditionaltemplateswithfxgroup]] 
{:/}


### keeptags  ###


使原始的标签在应用完模板后得到保留。

这个修饰语在 `char` 或 `multi`下没有效果。

{::template name="examplebox"} 
    template line <u>keeptags</u>: {\r\t($start,!$start+1!,\frx40)\t(!$start+1!,$end,\frx0)}
    karaoke: {\k21}hi{\k10}gu{\k23}ra{\k22}shi {\k38}ga {\k37\1c&H0000FF&}na{\k37}ku

音节 "沿X轴翻转"，并在高亮的时间内翻转回去。其中的一个音节 ("na") 和其它音节颜色不同。后面的音节不会受影响，因为存在 `\r` 标签。

 _notags_ 修饰语能确保应用模板后不再含有特殊音节的特殊颜色。

{:/}


### multi  ###


使模板对每个高亮应用一次 ，见[[多次高亮|Furigana_karaoke]] 。它会改变模板执行顺序，详见 [[模板执行顺序|Automation/Karaoke_Templater/Template_execution_rules_and_order]] 。

当它被用于 code行时，基本没什么卵用，具体可以参照执行顺序。

{::template name="examplebox"} 
    template syl <u>multi</u>: {\an5\pos($scenter,$smiddle)\1a&HFF&\t($start,$end,\bord5\3a&HFF&)}
    karaoke: {\k33}風<u>{\k36}#</u>{\k89}の{\k46}花<u>{\k28}#</u>{\k57}よ

打好K的时间轴使用了多次高亮(multi-highlight)标记， <tt>#</tt> 被用来创建多次高亮音节。比如，風 (ka-ze) 和 花 (ha-na) 日文汉字实际上都对应两个音节，在这种情况下它们被存储成一个音节，但是会有两次高亮， <tt>#</tt> 字符在应用模板后不会显示 (当然，在应用模板前还是存在的.....)

模板使用 _multi_ 修饰语来标识它会使一个音节多次高亮。这个效果是一种简单的 "边框扩张"，但是在唱到 風 和 花 时，会产生两次这个效果。如果没有 _multi_ 修饰语的话，一个汉字只会产生一次效果。
{:/}


### noblank  ###


说明该模板不会对被认为是"空"的音节起作用。一个音节在几种情况下会被认为是空，去掉音节前的标签后：
1.剩下的是ASCII的空格
2.剩下全角空格
3.真正是空的
特殊情况
4.音节的持续时间是0 (\k0)

> _ 查看 _notext_ 修饰语的例子_


### notext  ###


说明原文本在应用模板后不会在输出行中被显示。

这个修饰语一般用来达到清除文本同时输出图形一类的目的。

code行不可用。

{::template name="examplebox"} 
    code once: sword_shape = "m 0 0 l 5 -5 l 5 -30 l 10 -30 l 10 -32 l 2 -32 l 2 -40 l -2 -40 l -2 -32 l -10 -32 l -10 -30 l -5 -30 l -5 -5 "
    template syl notext noblank: {\an5\move($scenter,!$smiddle-30!,$scenter,$smiddle,!$start-20!,$start)\p2}!sword_shape!

第一个 code行为了方便定义了一个矢量绘图。这个图形是一个简单的剑尖朝下的剑形。这个效果是使用\move标签使剑的图形向下落到音节上。

这个模板使用了 _notext_ 修饰语来防止生成的行中带有原文本，因为生成的行中我们只需要剑的形状，使用模板只是为了使用音节的时间和定位信息。_noblank_ 修饰语会保证剑形不会落空到 "不可见的" 音节上。如果那个不可见的音节恰好是个长时间的空格，不加 _noblank_ 修饰，那效果看起来会比较悲剧。
{:/}


### repeat _n_, loop _n_  ###


模板会按照给定数值多次执行。需要给定数字。循环次数必须是正整数，不可是变量或者算式。

`repeat` 和 `loop` 是等价的。

注意 loop 修饰的行模板和 loop 修饰的 音节/假名标记(syl/furi)模板执行顺序不同。详见 [[模板执行顺序|Automation/Karaoke_Templater/Template_execution_rules_and_order]] 。

{::template name="examplebox"} 
    template syl <u>loop 4</u>: {\move($x,$y,!$x+math.random(-30,30)!,!$y+math.random(-30,30)!,$start,$end)\alpha&HC0&\t($start,$end,\alpha&HFF&)}

其中 _loop_ 修饰语用于创建4个音节的副本。这四个副本每个都沿随机方向移动，在X/Y方向上最大范围30像素，带有淡出。

每个音节副本的初始透明度都是 `&HC0`，因为C0(HEX)=256-(256/4)=192，4由循环数确定。这样每个副本的不透明度实际上叠加到了256。 (更科学的数字应该是255，但是靠偶数次循环实现不了)
{:/}
> _可以在 [[代码执行环境|Automation/Karaoke_Templater/Code_execution_environment#loopingtemplates]] 页面看到更多高级用法。_

{::template name="automation_navbox" /}

