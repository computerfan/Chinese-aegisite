**卡拉OK模版执行器**是一个Aegisub自带的[[自动化|Automation]]脚本。它的主要目的是帮助你使用特别设计的模版语言来制作[[卡拉OK特效|Glossary/Karaoke_effect]]。卡拉OK模版执行器已随Aegisub安装并可以使用。

## 教程：卡拉OK模版执行器介绍  ##
* [[一个简单的例子|Automation/Karaoke_Templater/Tutorial_1]]
* [[使用数学表达式|Automation/Karaoke_Templater/Tutorial_2]]
* [[Using multiple template lines|Automation/Karaoke_Templater/Tutorial_3]]
* [[More advanced effects with positioned syllables|Automation/Karaoke_Templater/Tutorial_4]]

{::template name="todo"}计划制作更多教程，并补完上面的教程。{:/}

## 相关  ##
* [[声明template和code行|Automation/Karaoke_Templater/Declaring_template_and_code_lines]]
* [[模版执行器将在何时以及以何种顺序执行|Automation/Karaoke_Templater/Template_execution_rules_and_order]]
* [[template修饰语|Automation/Karaoke_Templater/Template_modifiers]]
* [[内联变量（$变量）|Automation/Karaoke_Templater/Inline_variables]]
* [[code区和code行的规则|Automation/Karaoke_Templater/Code_lines_and_blocks]]
* [[code区/行的执行环境的内容|Automation/Karaoke_Templater/Code_execution_environment]]

Also see the [[Automation/Lua/Modules/karaskel.lua]] section for more
information on what's in the `line` and `syl` variables, and more.
也请看一下[[Automation/Lua/Modules/karaskel.lua]]，有更多关于什么是`line`和`syl`变量以及更多其他的内容。

## 对于使用过 _multi-template_ 的用户 ##
译者注：从2.x或是3.x版本入门的用户可以无视下面这块……

如果你已用过1.10版本的Aegisub的 _multi-template_ 脚本，你应该了解在卡拉OK模版执行器中的几个类似的概念，但也有几个不同的地方。其中的一些是：

* 你不再需要在说话人栏中声明template行，取而代之的是在特效栏声明。你也可以把除`template`外的更多的东西放到那里。请阅读上面的教程来获得介绍，或者你觉得你能看懂的话可以参考下面的内容。
* Instead of using percent-signs to write Lua code blocks you use exclamation
  marks. So write `!$start+$i*30!` instead of `%$start+$i*30%`.
  Lua code区不再使用百分号来标记，改为使用感叹号。所以得用 `!$start+$i*30!` 代替 `%$start+$i*30%`。
* The `A` global is gone, but `line` and `syl` are directly accessible. The
  escaped Lua code is no longer run in the true global environment but instead
  in its own environment, so clashes between your templates and Karaoke
  Templater itself is much less probable.
* The `return false` hack to cancel execution of a template no longer works.
  Neither does having multi-statement Lua blocks and returning from them in
  general. For the first purpose the `fxgroup` functionality has been
  introduced, and for your multi-statement needs code lines have been
  introduced.
* Instead of working with `newline` and `line` (for being-generated and
  original line) you now work with `line` and `orgline` for being-generated and
  original lines.
* The `retime` function has been introduced to make it much easier to control
  the start and end times of your generated lines.
* Lots of more fancy features. Check the tutorials or read the reference to
  learn about it all.

{::template name="automation_navbox" /}
