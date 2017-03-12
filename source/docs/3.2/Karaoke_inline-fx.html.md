卡拉OK inline-fx（内联特效）可以用来给[[打过k的时间轴|Timing#ok]]的不同部分分配不同的特效。

inline-fx标记本身并不会有任何影响，只有当应用可以识别它的[[卡拉ok特效脚本|Automation]]时才会应用于打了k的轴。

## 标记  ##
Inline-fx tags are (otherwise invalid) ASS override tags of the form
`\-effectname`, where _effectname_ is the name of the inline-fx defined.
内联特效标签是一个（无效的）ASS特效标签，格式是`\-特效名`，其中 _特效名_ 是内联特效所定义的。

和普通特效标签一样，内联特效标签同样只会影响其后的音节，直到下一个内联标签为止。

一行的开始会重设为无内联特效。

{::template name="examplebox"}
Here is a timed karaoke line with inline-fx markup:

<pre><code>{\k40}zu{\k20}t{\k42}to {\k32<u>\-paint</u>}e{\k17}ga{\k45}i{\k32}te{\k26}ta {\k24<u>\-cloud</u>}yu{\k55}me</code></pre>

These syllables get inline-fx assigned like this:

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

## Usage in Karaoke Templater  ##
If you use [[Karaoke Templater|Automation/Karaoke_Templater]] to create
effects, you can use the _fx_ modifier on templates to make that template
affect only syllables with a specific inline-fx. It isn't possible
(directly) to match only syllables with blank inline-fx.

{::template name="examplebox"}
With the sample timed karaoke from above, you could have the following templates:

<code><pre>template syl: {base effect applied for all syllables}
template syl <u>fx paint</u>: {overlay effect applied only to the 'paint' syllables}
template syl <u>fx cloud</u>: {overlay effect applied only to the 'cloud' syllables}</pre></code>

The idea here is to have a base effect and then some of the syllables get
some more effects on top of that.
{:/}
{::template name="examplebox"}
It is possible to match only syllables with blank inline-fx in
kara-templater by using an _fxgroup_ that enables or disables basing on
inline-fx. You can also use _fxgroup_s to have templates that run for
multiple inline-fx.

<code><pre><u>code syl</u>: fxgroup.blankfx = (syl.inline_fx == "")
template syl <u>fxgroup blankfx</u>: {effect only applied on blank inline-fx syllables}</pre></code>

The important thing is that the code line runs per syllable and runs before
any per-syllable templates that must use it.
{:/}

## Usage in Lua scripts  ##
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
