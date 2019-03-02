---
title: 字幕文件接口
---
This page describes the **subtitle file interface** use in Automation 4 Lua
scripts to manipulate subtitle files.

此页面描述了用于 Automation 4 Lua 脚本中操作字幕文件的**字幕文件接口**。

There is one special object (the **subtitles** user data object) which has a
number of functions, and a number of table formats defined.

这里定义了一个拥有多个方法（function）、表格式（table format）定义的特殊对象（**subtitles**用户数据对象）。

## subtitles 对象  ##
Most Automation 4 Lua feature functions are passed a **subtitles object** when
called. This object is used to obtain data from and manipulate the subtitles
the feature is being applied on.

**subtitles对象**会在多数基于 Automation 4 Lua 的函数在被调用时被传入。此对象用于
在应用功能时获得相应数据并操作字幕文件。

A subtitles object can have two special properties depending on the context it
is created for:

一个subtitles对象可以根据使用场景来定义两种特殊属性：

**只读**
: Some feature functions must not be allowed to modify the subtitle file at
all. This includes for example [[macro validation
functions|Automation/Lua/Registration#macrovalidationfunction]] and [[export
filter configuration panel
providers|Automation/Lua/Registration#_export_filter_configuration_panel_provider]],
because this would be outside user expectations.

: 一些功能函数理应不允许其修改字幕文件。这种函数包括例如 [[宏验证函数|Automation/Lua/Registration#macro-validation-function]] 以及 [[导出滤镜配置面板提供程序|Automation/Lua/Registration#export-filter-processing-function]]，因为可能会有与用户预期不符的效果。

**允许撤消点**
: Only [[macro processing
functions|Automation/Lua/Registration#macroprocessingfunction]] can set undo
points, as it makes no sense to do so at any other time.

仅有[[宏处理函数|Automation/Lua/Registration#macro-processing-function]]可设置撤销点，
因为在其他任何时候设置没有意义。


To allow the most flexibility, the subtitles object represents a complete ASS
format file, line by line, including all meta-lines such as section headers.

为提供最大的灵活性，subtitles 对象可表示完整的ASS格式文件的每一行，包括meta行的
内容，例如每个section的标题。

The subtitles object supports the following operations:

subtitles 对象支持如下的操作：

* Retrieve number of lines
* Read line
* Append line (to end of file)
* Insert line (at arbitrary position in file)
* Replace line
* Delete line
* Create undo point

* 获取总行数
* 读取行
* 附加行（至文件末尾）
* 插入行（至文件任意位置）
* 删除行
* 创建撤销点

These operations are described in detail below. In all operation synopses and
examples, `subtitles` is used for name of the subtitles object being operated
on.

下面会详细描述这些操作。在所有操作摘要及示例中，`subtitles`是正在操作的 subtitles 
对象的名称。

### 获取总行数  ###
摘要:

* `num_lines = #subtitles`
* `num_lines = subtitles.n`

This operation retrieves the total number of lines in the subtitle file
currently. This number only changes by using the other operations on the
subtitle object. It cannot change spontaneously during the execution of a
script.

此操作可获取当前字幕文件中的总行数。此数字仅会在对 subtitle 对象使用其他操作时更改，
它不会在执行脚本时自发更改。

Note that this is not a constant-time lookup, but lua does cache the value if
used in `for i = 1, #subs`.

注意这个查找所消耗的时间不是常数阶的，但在 `for i = 1, #subs` 中使用的话Lua会缓存这个值。

**`num_lines`** (`number`)
: Number of lines in the subtitle file.

: 字幕文件的行数。

The first syntax is the preferred one, per normal Lua 5.1 coding style.

根据正常的Lua 5.1编码风格，第一个写法是首选。

### 读取行  ###
摘要：`line = subtitles[i]`

This retrieves the indexed line and creates a new table object with data about
it.

这会读取索引行并创建一个新的表对象来存储此行的数据。

**`line`** (`table`)
: Table with data about the retrieved line.

: 包含读取行数据的一个表。

**`i`** (`number`)
: Index into the subtitles file of the line number to retrieve. This is
one-based, i.e. the first line in the file has index 1.

: 获取的行位于字幕文件中的行号。这个值始于1，即文件中第一行的索引是1。

Aegisub internally stores the subtitle file as a linked list, which means that
random access is slow, but sequential access is fast. While Automation 4 Lua
presents the subtitles as if it was an array, it internally maintains a cursor
used to optimise for sequential access. It is faster to access a line with an
index close to the one you last accessed than to access one further away. It is
always fast to access lines near the beginning or end of the file.

Aegisub内部将字幕文件存储为一个链表，这意味着随机访问慢，但顺序访问快。虽然 Automation 4 Lua 
将 subtitles 表示为数组，但它内部维护着一个用于优化顺序访问的指针。访问索引接近上次访问的行
会比访问原离的行更快。访问文件开头或结尾附近的行时总会很快。

### 附加行  ###
摘要：

* `subtitles[0] = line`
* `subtitles.append(line)`
* `subtitles.append(line1, line2, ...)`

Append one or more lines to the end of the appropriate section of the subtitles
file. If the section does not exist, it will be created. In the first syntax, it
is the number 0 (zero) used for index. (Setting index 0 causes an append
operation.)

附加一行或多行至字幕文件指定的section末尾。如果相应section不存在则会被创建。在第
一种写法里，数字0（零）被用作索引。（设置索引为0即为附加操作。）

The third syntax supports appending multiple lines with one single operation.

第三个写法支持一次操作附加多行。

**`line`** (`table`)
: The line object table to append to the subtitles file.
: 附加至字幕文件的行的对象表。

The latter function-call syntax is preferred for readability. The table index
setting syntax is slightly faster.

后两个函数调用写法更利于可读性。表索引写法会稍微快一点。

Appending a line does not move the cursor otherwise used to optimise sequential
access.

附加行不会改变之前用于优化顺序读取的指针。

### Insert line  ###
Synopsis:

* `subtitles[-i] = line`
* `subtitles.insert(i, line)`
* `subtitles.insert(i, line1, line2, ...)`

Inserts one or more lines into the subtitles file before the numbered line. In
the first syntax, you supply a negative index. E.g. to insert a line before
line 5 you supply index -5 (negative 5.)

Inserting lines will move lines after the inserted lines to move down in index,
such that old indexes will no longer be valid.

Inserting lines into the wrong section of the subtitle file has undefined
results, and may break in weird ways.

**`i`** (`number`)
: Index to insert before.

**`line`** (`table`)
: The line object table to insert into the subtitles file.

The latter function-call syntax is preferred for readability. The table index
setting syntax is slightly faster.

Inserting lines uses the list cursor and will move it.

### Replace line  ###
Synopsis: `subtitles[i] = line`

Delete the indexed line and insert the given line in its stead.

**`i`** (`number`)
: The line index to replace at.

**`line`** (`table`)
: The line object table to replace with.

Replacing lines uses the list cursor and will move it.

Replacing lines with lines of a different type has undefined results, and may
break in weird ways.

### Delete line  ###
Synopsis:

* `subtitles[i] = nil`
* `subtitles.delete(i)`
* `subtitles.delete(i1, i2, ...)`
* `subtitles.delete({i1, i2, ...})`
* `subtitles.deleterange(first, last)`

Remove one or more from the subtitles file. All lines after the deleted line(s)
will move up to fill the deleted indexes, so old indexes will no longer be
valid.

The third syntax supports deleting multiple indexed lines in one call. The
indexes given must all be correct for the subtitle file's state before any
lines are deleted.

The fourth syntax is identical to `subtitles.delete(unpack(tbl))`, but
supports tables which are too large to unpack and will be slightly
faster if you have the lines in a table anyway.

Trying to delete a nonexistent line is an error, except for with deleterange.

The fifth syntax deletes a range of lines, both indexed lines inclusive.

**`i`** (`number`)
: Index of the line to delete.

**`first`** (`number`)
: Index of the first line of the range to delete.

**`last`** (`number`)
: Index of the last line of the range to delete.

Deleting lines uses the list cursor and will move it.

### Creating an undo point  ###
Synopsis: `aegisub.set_undo_point(description)`

You should always create an undo point at the end of any macro which made
changes to the subtitles object. If you do not, one will automatically be set
for you, but in future versions of Aegisub this may change to rolling back any
changes made instead.

You can set multiple undo points in a single macro, but it is rarely a good
idea to.

Only available in macro processing functions, as it doesn't make sense anywhere
else either.

**`description`** (`string`)
: Text to appear in the Edit menu for the Undo and Redo items to describe the
action that can be undone.

This is not really a function in the subtitles object, but it is still closely
tied to it.

## Line data tables  ##
When you read lines from the subtitle file object they will always be one of a
few classes of lines, and when you write lines back to the subtitle file they
must also follow the format of one of those classes.

The line data objects are regular Lua tables with some specific fields defined.

Here's a list of the different classes of lines:

**`info`**
: A key/value pair in the Script Info section of the file

**`style`**
: a regular style definition line

**`dialogue`**
: A dialogue line, which may or may not be a comment. These are the lines you
see in the grid in Aegisub.

**`unknown`**
: An unknown kind of line.

There's three fields that always exist in all line data tables:

**`class`** (`string`)
: The name of the class of line this is, see the list above.

**`raw`** (`string`)
: The raw text of the line, from first to last character on the physical line.

**`section`** (`string`)
: Which section of the file the line belongs to. If the line is placed before
the first section heading, this field is `nil`.

### `info` class  ###
This class defines two additional fields:

**`key`** (`string`)
: The part of the line before the first colon, with leading and trailing spaces
removed.

**`value`** (`string`)
: Everything after the first colon on the line, also with leading and trailing
spaces removed.

### `style` class  ###
This class defines a large number of additional fields. It's usually processed
by the _karaskel_ and modified a bit by that. See the _karaskel.lua_ section on
[[style tables|Automation/Lua/Modules/karaskel.lua#styletable]] for more
information about this class.

### `dialogue` class  ###
This class defines a large number of additional fields. It's usually processed
by the _karaskel_ and has many calculated fields added by that. See the
_karaskel.lua_ section on [[dialogue line
tables|Automation/Lua/Modules/karaskel.lua#dialoguelinetable]] for more
information on this class.

### `unknown` class  ###
No additional fields are defined by this class, due to its nature. This might
be things like files embedded into the subtitles. You shouldn't try to work
with these lines unless you really know what you're doing. Deleting, modifying
and inserting `unknown` lines has undefined consequences. (That means, even if
it works today it might not work tomorrow or in the next version of Aegisub.)

{::template name="automation_navbox" /}
