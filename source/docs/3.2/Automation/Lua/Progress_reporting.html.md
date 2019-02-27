---
title: 进度报告
---
There functions are used to report various status and progress back to the GUI
while a script is running.

## Progress reporting  ##
A progress dialogue box is always shown when an Automation 4 Lua script is
running. You can use these functions to control what is displayed in it.

### aegisub.progress.set  ###
Synopsis: `aegisub.progress.set(percent)`

Set the position of the percent-done bar in the progress window.

**`percent`** (`number`)
: Number from 0 to 100.

### aegisub.progress.task  ###
Synopsis: `aegisub.progress.task(msg, ...)`

Set the "task" text in the progress window, which is the small text below the
progress bar showing what the script is currently doing.

**`msg`** (`string`)
: A format string specifying the message. See the Lua standard string library
`string.format` function for details on format strings.

**`...`**
: Parameters to the format string.

### aegisub.progress.title  ###
Synopsis: `aegisub.progress.title(title, ...)`

Set the title of the progress window, which is is the large text displayed
above the progress bar. This text should usually not change while the script
is running. By default this is set to the name of the macro running.

**`title`** (`string`)
: A format string specifying the title. See the Lua standard string library
`string.format` function for details on format strings.
**`...`**
: Parameters to the format string.

### aegisub.progress.is_cancelled  ###
Synopsis: `cancelled = aegisub.progress.is_cancelled()`

Tells whether the user has clicked on the Cancel button.

You should call this function regularly during long operations, and if it's
true call [[`aegisub.cancel()`|Miscellaneous_APIs#aegisub.cancel]] to
rollback all changes and immediately end execution of the script.

**`cancelled`** (`boolean`)
: `false` if the user has not clicked the Cancel button, `true` if the user has
clicked Cancel. If `is_cancelled` returns `true` all subsequent calls to it in
the current execution will also return `true`.

## Debug output  ##
The primary support for script debugging in Automation 4 Lua is through sending
debug messages to the message log integrated in the progress window.

If a script shows a debug or other message, the progress window stays open
after the script has finished running until the user clicks the Close button.
Please consider whether it's really that important that the user sees your
messages. Blocking other input to the program to display something that might
be irrelevant to the user can create a bad experience.

### aegisub.debug.out  ###
Synopsis:

* `aegisub.debug.out(msg, ...)`
* `aegisub.debug.out(level, msg, ...)`
* `aegisub.log(msg, ...)`
* `aegisub.log(level, msg, ...)`

The two names are synonymous; you can use either name depending on your
preference.

Sends a message to the message log, optionally with a specific severity level.
The user can control in Aegisub's options the highest level messages that will
be shown.

**`level`** (`number`)
: Severity level of the message. This parameter is optional. If you leave it
out (by entirely skipping it) the message will always be shown.

**`msg`** (`string`)
: A format string specifying the message. See the Lua standard string library
`string.format` function for details on format strings.

**`...`**
: Parameters to the format string.

The following severity levels are suggested:

0: "fatal"
: Something really bad happened and the script can't continue. Level 0 messages
are always shown. Note that Aegisub does not automatically terminate your
script. Call [[`aegisub.cancel()`|Miscellaneous_APIs#aegisub.cancel]]
afterwards if you want it to.

1: "error"
: A real error occurred so the user should expect something to have gone wrong
even though you tried to recover. A fatal error might happen later.

2: "warning"
: It looks like something is wrong and the user ought to know because it might
mean something needs to be fixed.

3: "hint"
: A tip or otherwise on how the user can improve things, or hints that
something might cause a warning or error later on.

4: "debug"
: Information meant to help fix errors in the script, such as dumps of variable
contents.

5: "trace"
: Extremely verbose information about what the script is doing, such as a
message for each single step done with lots of variable dumps.

{::template name="automation_navbox" /}
