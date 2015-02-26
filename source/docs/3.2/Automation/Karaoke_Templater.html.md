**卡拉OK模版执行器**是一个Aegisub自带的[[自动化|Automation]]脚本。它的主要目的是帮助你使用特别设计的模版语言来制作[[卡拉OK特效|Glossary/Karaoke_effect]]。卡拉OK模版执行器已随Aegisub安装并可以使用。

## Tutorials: Introducing Karaoke Templater  ##
* [[A simple example|Automation/Karaoke_Templater/Tutorial_1]]
* [[Using math expressions|Automation/Karaoke_Templater/Tutorial_2]]
* [[Using multiple template lines|Automation/Karaoke_Templater/Tutorial_3]]
* [[More advanced effects with positioned syllables|Automation/Karaoke_Templater/Tutorial_4]]

{::template name="todo"}Plan more tutorials. Also actually write those above.{:/}

## Reference  ##
* [[Declaring template and code lines|Automation/Karaoke_Templater/Declaring_template_and_code_lines]]
* [[Rules for when and in what order templates are run|Automation/Karaoke_Templater/Template_execution_rules_and_order]]
* [[Template modifiers|Automation/Karaoke_Templater/Template_modifiers]]
* [[Inline variables (dollar-variables)|Automation/Karaoke_Templater/Inline_variables]]
* [[Rules for code blocks and code lines|Automation/Karaoke_Templater/Code_lines_and_blocks]]
* [[Contents of the code block/line execution environment|Automation/Karaoke_Templater/Code_execution_environment]]

Also see the [[Automation/Lua/Modules/karaskel.lua]] section for more
information on what's in the `line` and `syl` variables, and more.

## For users of _multi-template_  ##
If you have used the _multi-template_ script from Aegisub 1.10 you should
recognise several similar concepts in the karaoke templater, but there are also
several pitfalls. Some of them are:

* You no longer declare template lines in the Actor field but in the Effect
  field instead. You can also put much more than just `template` in there. Read
  the tutorials above for an introduction, or the reference below if you feel
  adventurous.
* Instead of using percent-signs to write Lua code blocks you use exclamation
  marks. So write `!$start+$i*30!` instead of `%$start+$i*30%`.
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
