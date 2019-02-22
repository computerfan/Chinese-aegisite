**注册** 涵盖了以下内容：使你自己编写的Lua脚本[[Automation 4 Lua|Lua]]出现在Aegisub中、
提供和脚本有关的信息、该脚本提供了什么样的 _特性_。

## 有关特性(Feature)的解释  ##

Automation 4 中的一个最基础的概念就是 _特性_ 。特性决定了Aegisub如何响应用户的动作去调用脚本。

特性不是简单的回调。它通常是一组几个回调函数,以及如何在GUI中向用户呈现它们的一些信息。

一种特性的类型是 **macro** (宏)，宏会被作为一个小项展示在自动化菜单中，它有一个名字(即菜单中显示的内容)，
一段描述(当鼠标悬停在该项时，状态栏显示的说明文本)，一个处理函数(当用户点按该项时执行的函数)
还有一个可选的有效性确认函数(决定这个宏在当前状态下是否可以运行，如：卡拉OK模板执行器就具有这个属性，如果检测不到template行，该项为灰色不可用)

另外一种特性是 **export filter**(导出滤镜)。导出滤镜会被展示在[[Export|Exporting]] 对话框中，在进行导出操作时被应用
导出滤镜也有名字、描述、处理函数，同时提供了配置面板函数。使用配置面板函数可以返回一个配置面板对话框，
在执行导出滤镜的时候会被展示给用户，在配置面板中输入的参数和配置可以传递给处理函数作为参数。

## 全局脚本信息变量  ##

一个脚本中，可以设置一些全局变量，来给Aegisub提供一些元数据。
这些全局变量会被展示在[[Automation Manager|Automation/Manager]] 对话框中和脚本信息对话框中。

* **script_name** (脚本名，字符串) - 脚本的名称，应尽量简洁
* **script_description** (脚本描述，字符串) - 描述该脚本可以达成什么目的，也不建议太长。
* **script_version** (脚本版本号，字符串或数字) - 脚本的版本号
* **script_author** (脚本作者，字符串) - 脚本作者信息

上述的变量均为可选项，即使一个脚本头部没有定义这些变量，Aegisub也会调取文件名来显示。

## 注册函数  ##

注册函数是指一些Automation 4 提供的现成 Lua 函数，可以方便你把一项特性变为Aegisub可用的形式
你经常会在顶部或者底部调用它。

### aegisub.register_macro  ###

摘要: `aegisub.register_macro(name, description, processing_function, validation_function, is_active_function)`

将脚本注册成为一个具有marco(宏)特性的项。

* **name** (名称，字符串) - 自动化 菜单中显示出来的名字。尽量简洁。

  如果名字中有向前斜杠(/)，名字会被斜杠分开，斜杠后的内容在自动化菜单中表现为子项。
  例如，如果你注册了宏 "Foo/Bar" 和 "Foo/Baz"，自动化菜单中， "Foo" 下会有 "Bar" 和 "Baz" 两个子项。

  菜单可以支持多级的嵌套，不过多级嵌套不是什么好主意
  
* **description** (描述，字符串) - 当鼠标悬停在该项时，状态栏显示的说明文本。
  建议这部分写的简明直接，描述清楚该脚本是做什么的。
  
* **processing_function** (处理函数，函数) - 当用户点击了这项时，调用的处理函数 [[macro
  processing function API|Automation/Lua/Registration#macroprocessingfunction]].。
  
* **validation_function** (有效性检测函数，函数, 可选) - 这个函数被用来检测当前项是否可用。
  (灰色还是正常)。如果不设置该函数，宏则一直处于可用状态。
  这个函数遵循 [[macro validation
  function API|Automation/Lua/Registration#macrovalidationfunction]] 中的说明。
  
* **is_active_function** (活动检测函数，函数, 可选) - 这个函数会在当前可用项的左侧显示一个对勾。
规则同有效检测函数

### aegisub.register_filter  ###

摘要: `aegisub.register_filter(name, description, priority, processing_function, configuration_panel_provider)`

将脚本注册成为一个具有filter(滤镜)特性的项。

* **name** (名称，字符串) - 在 导出滤镜 列表中呈现的名称，应尽可能简洁。
* **description** (描述，字符串) - 当用户选中该导出滤镜时，在描述框中显示的描述文字。
* **priority** (优先级，数字) - 决定导出滤镜的应用顺序。高优先级的滤镜会被优先应用。
  用户可以在 导出 对话框中修改顺序。
  Aegisub内置导出滤镜的优先级顺序:

  * 帧率转换 = 1000 (卡拉OK效果应该比这个有更高的优先级)
  * 清除脚本信息 = 0 (你的脚本可能依赖于这个脚本会清理掉的信息，所以它最后被应用)
  * 修复样式 = -5000 (一般总是最后运行)

* **processing_function** (处理函数，函数) - 当用户执行导出操作时调用的处理函数。
  这个函数需要符合 [[export filter processing function
  API|Automation/Lua/Registration#exportfilterprocessingfunction]]的要求。
* **configuration_panel_provider** (配置面板函数，函数，可选) - 为导出滤镜提供了配置面板的函数
  如果不写这个函数，导出滤镜不会具有配置面板。需要遵循 [[export filter configuration panel provider
  API|Automation/Lua/Registration#exportfilterconfigurationpanelprovider]] 的要求。

## Feature callback functions  ##

These are the callback functions you provide to the registration functions.

### Macro processing function  ###

Signature: `process_macro(subtitles, selected_lines, active_line)`

Macro processing functions passed to
[[`aegisub.register_macro`|Automation/Lua/Registration#aegisub.register_macro]]
must have this signature. The name `process_macro` is a placeholder for your
own function name.

* **subtitles** (user data) - The [[subtitles
  object|Automation/Lua/Subtitle_file_interface]] you use to manipulate
  the subtitles with.
* **selected_lines** (table) - An array with indexes of the selected lines.
  The values in this table are line indexes in the _subtitles_ object at its
  initial state. Only `dialogue` class lines can ever be selected.
* **active_line** (number) - The line that is currently available for
  editing in the subtitle editing area. This is an index into the
  _subtitles_ object. This line will usually also be selected, but this is
  not a strict requirement.

**Return value:**
The macro processing function can return up to two values: a new
`selected_lines` table containing indices of the lines to select after the
macro returns, and an index of the line to make the new `active_line`. If
set, the new active line index must be one of the lines in the new
`selected_lines` table.

### Macro validation function  ###

Signature: `validate_macro(subtitles, selected_lines, active_line)`

Macro validation functions passed to
[[`aegisub.register_macro`|Automation/Lua/Registration#aegisub.register_macro]]
must have this signature. The name `validate_macro` is a placeholder for
your own function name.

**Important, execution time:** Validation functions should always run very
fast. Do as little work as possible inside this function, because it is run
every time the user pulls open the Automation menu, and every millisecond
you spend in `validate_macro` is one millisecond delay in opening the menu.
Consider that the user might have very large files open. Don't block the UI.


* **subtitles** (user data) - The [[subtitles
  object|Automation/Lua/Subtitle_file_interface]] for the current subtitle
  file. This is **read-only**. You cannot modify the subtitles in the
  validation function, and attempting to do so will cause a run-time error.
* **selected_lines** (table) - An array with indexes of the selected lines.
  The values in this table are line indexes in the _subtitles_ object at its
  initial state. Only `dialogue` class lines can ever be selected.
* **active_line** (number) - The line that is currently available for
  editing in the subtitle editing area. This is an index into the
  _subtitles_ object.

**Return value:**
Boolean, `true` if the macro can run given the current
state of _subtitles_, _selected_lines_ and _active_line_, `false` if it can
not.

In addition to the primary return value, the validation function can return
a string. If it does, the description of the macro is set to the string.
This is intended for reporting information to the user about why the macro
cannot be run, but there may be more uses for it.

### Export filter processing function  ###

Signature: `process_filter(subtitles, settings)`

Export filter processing functions passed to
[[`aegisub.register_filter`|Automation/Lua/Registration#aegisub.register_filter]]
must have this signature. The name `process_filter` is a placeholder for
your own function name.

You do not have to worry about undo issues with export filters. You always
work on a copy of the subtitle file.

* **subtitles** (user data) - The [[subtitles
  object|Automation/Lua/Subtitle_file_interface]] you use to manipulate
  the subtitles with. This is a copy of the open subtitles file, so
  modifying this subtitles object does not modify the open file and will
  only affect the exported file.
* **settings** (table) - Configuration settings entered into the
  configuration panel or an empty table if there is no configuration panel.
  See the page on [[configuration
  dialogues|Automation/Lua/Dialogs]] for more information
  on the format of this table.

**Return value:**
Nothing.

### Export filter configuration panel provider  ###

Signature: `get_filter_configuration_panel(subtitles, old_settings)`

Export filter configuration panel providers passed to
[[`aegisub.register_filter`|Automation/Lua/Registration#aegisub.register_filter]]
must have this signature. The name `get_filter_configuration_panel` is a
placeholder for your own function name.

**Important, execution time:**
This function is called automatically when
the user opens the Export dialogue, and Aegisub blocks until it returns with
a configuration panel. Consider that the user might have a very large file
open, and that every millisecond spent creating your configuration dialogue
is one more millisecond the user has to wait for the Export dialogue to
open. Don't block the UI.

* **subtitles** (user data) - The [[subtitles
  object|Automation/Lua/Subtitle_file_interface]] for the current subtitle
  file. This is **read-only**. You cannot modify the subtitles in the filter
  configuration provider. Attempting to modify the subtitles will cause a
  run-time error.
* **old_settings** (table) - Previous configuration settings entered into
  the configuration panel, if any. When an Automation 4 export filter is
  run, any configuration settings are automatically stored to the original
  file. If any stored settings exist for this filter, they are passed as
  _old_settings_ so you can use them as a base for filling in defaults.

**Return value:**
A configuration dialogue table. See the page on
[[configuration dialogues|Automation/Lua/Dialogs]] for
more information on the format of this table.

{::template name="automation_navbox" /}


