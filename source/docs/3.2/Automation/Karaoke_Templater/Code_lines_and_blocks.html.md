---
title: Code行 和 Code区
---
Code行和Code区是由卡拉OK模板执行器产生的概念，它们允许你使用小段的Lua代码来创作高级特效。
代码可以是几个数字之间的简单运算，也可以是复杂的函数，例如生成各种各样的图形和颜色。

Code行和Code区的代码执行都是在一个半封闭的执行环境进行的，这意味着它们的执行几乎不会受自带的Lua运行环境影响。想知道什么样的变量可以应用在Code行/区，可以查看: [[代码执行环境|Automation/Karaoke_Templater/Code_execution_environment]]。

## Code 行  ##

Code行是一种特殊的template行。它不使用`template`来声明，而是使用`code`。 
一个Code行中只应该含有Lua代码，并且无法独立作用生成新的行。

Code行的两种用途:

* 定义/更新变量，为变量在template行中的使用做准备
* 定义函数，为函数在template行中的使用做准备

例如，如果你需要一个随机数，但是需要在template行中两次用到同一个随机数，你可以采用code line来生成这个随机数，然后再在template行中使用它。

另一个例子是定义一个返回随机颜色的函数。


### Code行的类型  ###

就像template行一样，Code行也有很多种类。有一些和template是类似的，有一些只在code中独立存在或者只在template中独立存在。

你通过在特效栏的 `code` 后添加关键词(修饰语)来进行code行类型的指定。
可用的类型(修饰语)有:

once
: `once` 类型的code行在模板执行器的整个运行过程中只执行一次。通常用来定义函数或者一个通用的表，以便你之后多次调用。它是默认类型，如果你不指定code行类型，那么它默认以 `once` 的规则执行。

line
: `line` 类型的code行每检测到一行karaoke行便执行一次。这个类型的code行一般与 `line`/`pre-line` 类型的模板配合使用。
(code行并没有"pre-line"这个类别)

syl
: `syl` 类型的code行每检测到一个音节便执行一次。它与 `syl` 类型的template行配合使用。

furi
: `furi` 类型的code行每检测到一个注音音节便执行一次。它与 `furi` 类型的template行配合使用。

你 _不能_ 用 `char` 或者 `multi` 修饰语来配合code行使用。这是执行模式带来的限制。这一点在未来的卡拉OK模板执行器中也不会改变。

## Code 区  ##

Code区是在template行中使用Lua代码的一个区块。插入一个Code区，就可以在里面使用复杂的东西，这类东西可以表述为 [[内联变量|Automation/Karaoke_Templater/Inline_variables]]。

Code区要求是一个单独的Lua表达式，因为 `return`这种步骤已经预先包含在了code区的规则中。
这意味着你无法在code区中使用类似 `if` 这种表达式，如果你一定要使用，只能在code行中进行。(虽然有一种方式可以在code区基本实现if逻辑，请继续阅读)

code区的插入方式是使用一对半角感叹号(!)，两个感叹号中间的区域即code区，如下:

    {\t($start,**!syl.start_time+20!**,\bord0)}

在code区中可以使用内联变量。它们在code区执行前就已经被赋值，所以对于Lua解释器来说，它们就是常量。

### code区使用的小提示  ###

大多数的简单数学表达式都像你所想的一样正常执行。
因为执行顺序就和我们学习的算术顺序一致。

Code区总是返回一串字符或者数学数值，如果要求它返回一个布尔型(boolean)或者一个表(table)或者其它乱七八糟的东西，它就会报错或者在生成的行中包含一些错误的信息。

想要在code区进行简单的逻辑判断需要使用 `and` 和 `or`，例如:

    {\k**!syl.duration > 100 and "f" or ""!**$kdur}

如果音节持续时间大于 100 ms ，子表达式1为真，code区会返回 <tt>"f"</tt> 作为结果。否则整个 `and`
表达为false，右边的参数 `or` 表达式会被执行并返回空。

在Lua中， `and` 的优先级高于 `or` ，这意味着 `and` 表达式会先被评估。如果用小括号分组表示优先级，就像这样:
`((syl.duration > 100) and "f") or ""`

{::template name="automation_navbox" /}

