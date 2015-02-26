本文档讲解如何声明template行和code行


* template行和code行要把注释（Comment）左边的方框打上√

<div></div>


* 
在特效栏，第一个被空格分隔的单词决定了该行是template行还是code行，是打好时间的karaoke行，还是设置好样式（被应用模板后）的karaoke行抑或其他的东西。

<div></div>


* 如果在特效栏填入的第一个单词是`template`，这行就是template行。

<div></div>


* 如果在特效栏填入的第一个单词是`code`，这行就是code行。

<div></div>


* 如果在特效栏看到 `fx`，这行就是karaoke行被应用模板后生成的行，执行自动化模板时，这些行首先会被删除。

<div></div>


* 如果在特效栏看到`Karaoke`，`karaoke `或者是空白的，这行就是打好时间的karaoke行。

<div></div>


* 如果特效栏含有其它的东西，这行就是未声明类型，不会被自动化模板执行器处理。

<div></div>

Template行和code行可以在template或code之后添加额外的文本，这些文本用一系列的被空格分隔的单词组成，被称作修饰语。欲了解更多请阅读[[Template修饰语|Automation/Karaoke_Templater/Template_modifiers]]。

{::template name="automation_navbox" /}

