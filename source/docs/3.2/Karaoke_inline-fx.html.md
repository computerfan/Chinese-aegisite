卡拉OK inline-fx（内联特效）可以用来给[[打过k的时间轴|Timing#ok]]的不同部分分配不同的特效。

inline-fx标记本身并不会有任何影响，只有当应用可以识别它的[[卡拉ok特效脚本|Automation]]时才会应用于打了k的轴。

## 标记  ##
内联特效标签是一个（无效的）ASS特效标签，格式是`\-特效名`，其中 _特效名_ 是内联特效所定义的。

和普通特效标签一样，内联特效标签同样只会影响其后的音节，直到下一个内联标签为止。

一行的开始会重设为无内联特效。

{::template name="examplebox"}
这是一行带内联特效标签的卡拉OK字幕：

<pre><code>{\k40}zu{\k20}t{\k42}to {\k32<u>\-paint</u>}e{\k17}ga{\k45}i{\k32}te{\k26}ta {\k24<u>\-cloud</u>}yu{\k55}me</code></pre>

这些音节会被分配如下的内联特效：

| Syllable | Inline-fx
| -------- | --------------
| zu       | (blank)
| t        | (blank)
| to       | (blank)
| e        | `paint`
| ga       | `paint`
| i        | `paint`
| te       | `paint`
| ta       | `paint`
| yu       | `cloud`
| me       | `cloud`
{:/}

## 卡拉OK模版执行器中的用法  ##
如果你用[[卡拉OK模版执行器|Automation/Karaoke_Templater]]来制作特效，你可以在模版上使用 _fx_ 修饰语来指定其仅对特定的内联特效生效。这种方式无法（直接）匹配无内联特效标记的音节。

{::template name="examplebox"}
接着之前的卡拉OK行的例子，你可以写出下面的模版：

<pre><code>template syl: {对所有音节生效的默认效果}
template syl <u>fx paint</u>: {仅对“paint”音节叠加生效的效果}
template syl <u>fx cloud</u>: {仅对“cloud”音节叠加生效的效果}</code></pre>

这里的想法是先有一个基本的效果，然后为某些音节设计更多的效果。
{:/}
{::template name="examplebox"}
通过使用一个基于内联特效而启用或禁用的 _fxgroup_，可以在卡拉OK模版执行器中匹配空白内联特效的音节。
您也可以使用多个 _fxgroup_来执行多个内联特效的模板。

<pre><code><u>code syl</u>: fxgroup.blankfx = (syl.inline_fx == "")
template syl <u>fxgroup blankfx</u>: {仅对空内联特效音节叠加生效的效果}</code></pre>

重要的是，code行在每个音节都会执行，并且会在每个需要使用它的对音节生效的模版之前执行。
{:/}

## Lua脚本中的用法  ##
The inline-fx tags are parsed by
[[`karaskel.preproc_line_text`|Automation/Lua/Modules/karaskel.lua#karaskel.preproc_line_text]]
so they will only work if you have applied at least that much karaskel
pre-processing on your subtitle lines.

The inline-fx for a syllable is then available as `syl.inline_fx`, which
you can compare to a string to conditionally apply effects.

{::template name="examplebox"}
In some code that runs per-syllable in your script:

~~~ lua
if syl.inline_fx == "" then
    apply_base_effect(subs, meta, line, syl)
elseif syl.inline_fx == "paint" then
    apply_paint_effect(subs, meta, line, syl)
elseif syl.inline_fx == "cloud" then
    apply_cloud_effect(subs, meta, line, syl)
end
~~~

Simply compare the inline-fx name to the various possibilities and run the
right effect code.
{:/}
{::template name="examplebox"}
In some code that runs per-syllable in your script:
At top-level of your script:

~~~ lua
effects = {}
effects[""] = function(subs, meta, line, syl)
    -- base effect code here
end
effects.paint = function(subs, meta, line, syl)
    -- paint effect code here
end
effects.cloud = function(subs, meta, line, syl)
    -- cloud effect code here
end
~~~

Then later, in some per-syllable processing code:

~~~ lua
effects[syl.inline_fx](subs, meta, line, syl)
~~~

First, a table is created and filled with functions for applying the
different effects. The keys used for the table are the names of the
possible inline-fx. When the effect has to be applied, the right function
is looked up in the effect table and then called.
{:/}

{::template name="automation_navbox" /}
