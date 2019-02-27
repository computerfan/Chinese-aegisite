---
title: 对话框
---
{::options toc_levels="2,3" /}

These functions are used to display dialogs for the user to interact with.

## Display dialog functions ##

### aegisub.dialog.display ###
Synopsis: `button, result_table = aegisub.dialog.display(dialog, buttons, button_ids)`

This function displays a configuration dialog to the user and waits for it to
close. It then returns whether the user accepted or cancelled the dialog, and
what values were input.

**`@dialog`** (`table`)
: A [[Dialog Definition
  table|Dialogs#dialog-definition-table-format]] containing
  the controls to be in the dialog.

**`@buttons`** (`table`)
: Optional. This is an array of strings defining the buttons that appear in
  the dialog. If this is left out, empty or is otherwise not a table, the
  standard Ok and Cancel buttons appear.  
  The strings in this table are used as labels on the buttons, and for
  identifying them in the return values of the function.

**`@button_ids`** (`table`)
: Optional. A table which specifies which buttons in the dialog correspond to
which [[platform button IDs|Dialogs#dialog-button-ids]], making it possible to
specify which button will be triggered if the user hits Enter or ESC.

**`button`** (`boolean` or `string`)
:   If no custom buttons were specified, this is a boolean telling whether
    Ok (true) or Cancel (false) were clicked in the dialog. If custom buttons
    were specified, this is the text on the button clicked by the user. Even if
    custom buttons were specified, this can still be boolean false if the user
    closes the dialog without pressing any button.

**`result_table`** (`table`)
:   The [[Dialog Result
    table|Dialogs#dialog-result-table-format]] corresponding to
    the values the user input in the dialog.

{::template name="examplebox"}
~~~ lua
config = {
    {class="label", text="Times to frobulate", x=0, y=0},
    {class="intedit", name="times", value=20, x=0, y=1}
}
btn, result = aegisub.dialog.display(config,
        {"Frobulate", "Nevermind"},
        {"ok"="Frobulate", "cancel"="Nevermind"})
if btn then
    frobulate(result.times)
end
~~~
{:/}

### aegisub.dialog.open ###
Synopsis: `file_name = aegisub.dialog.open(title, default_file, default_dir, wildcards, allow_multiple=false, must_exist=true)`

Open a standard file open dialog to ask the user for a filename. Returns
the path to the selected file(s), or nil if the user canceled.

**`@title`** (`string`)
:   Title of the dialog

**`@default_file`** (`string`)
:   Default filename to preselect. May be empty.

**`@default_dir`** (`string`)
:   Initial directory to show in the open dialog. If empty, the
    last used directory is shown.

**`@wildcards`** (`string`)
:   File filters to show. If empty, a sane default will be used.  
    E.g. "All Files (*.*)|*.*|XYZ files (*.xyz)|*.xyz"

**`@allow_multiple`** (`boolean`)
:   Let the user select multiple files. If this is true, a table of
    filenames will be returned rather than a single string, even
    if only one file is selected by the user.

**`@must_exist`** (`boolean`)
:   Only let the user select files that actually exist.

**`file_name`** (`nil`, `string`, or `table`)
:   `nil` if the user cancelled. A `string` containing the path to the
    selected file if `allow_multiple` is false, or a table containing the
    paths to all selected files if `allow_multiple` is true.

{::template name="examplebox"}
~~~ lua
filename = aegisub.dialog.open('Select file to read', '', '',
                               'Text files (.txt)|*.txt', false, true)
if not filename then aegisub.cancel() end

file = io.open(filename, 'rb')
....
~~~
{:/}

### aegisub.dialog.save ###
Synopsis: `file_name = aegisub.dialog.save(title, default_file, default_dir, wildcards, dont_prompt_for_overwrite=false)`

Open a standard file save dialog to ask the user for a filename.  Returns
the path to the selected file, or nil if the user canceled.

**`@title`** (`string`)
:   Title of the dialog

**`@default_file`** (`string`)
:   Default filename to preselect. May be empty.

**`@default_dir`** (`string`)
:   Initial directory to show in the open dialog. If empty, the
    last used directory is shown.

**`@wildcards`** (`string`)
:   File filters to show. If empty, a sane default will be used.  
    E.g. "All Files (*.*)|*.*|XYZ files (*.xyz)|*.xyz"

**`@dont_prompt_for_overwrite`** (`boolean`)
:   Don't ask the user to confirm that they wish to overwrite the file if
    they select a filename that already exists.

**`file_name`** (`nil`or  `string`)
:   `nil` if the user cancelled, and a `string` containing the path to the
    selected file otherwise.

## Configuration Dialog interface ##

This section describes the tables passed to and received from
`aegisub.dialog.display` and the [[export filter configuration
panel|Registration#exportfilterconfigurationpanelprovider]].

This file describes the functions and data structures used for the
Configuration Dialog functionality in Automation 4.

### Dialog Control table format ###

A Dialog Control table describes a single control in a configuration dialog,
which can display information to the user and allow them to change it.

There are a number of different classes of controls, and the keys a Dialog
Control table must contain depends on the control class.

Common keys for all control classes:

**`class`** (`string`)
: Defines which class this control has. Must be one of:

    * "label",
    * "edit", "intedit", "floatedit", "textbox",
    * "dropdown",
    * "checkbox",
    * "color", "coloralpha", "alpha"

**`x`** (`number`)
**`y`** (`number`)
**`width`** (`number`)
**`height`** (`number`)
:   Determines the position and size of the control in the dialog. These values
    are used to create a grid containing the controls. They should all be
    integer. The top left corner is `x`,`y`=0,0.
    If any of width and height are set to zero or less, it will be set to one
    instead.

Keys defined for all classes except "label":

**`hint`** (`string`)
:   A string displayed to the user as tooltip, when hovering over the control.

**`name`** (`string`)
:   A name that uniquely identifies the control. This is recommended to be a
    string easily used as an identifier in Lua, since it will be used to access
    the value input into the control.

Keys defined only for "label" and "checkbox" classes:

**`label`** (`string`)
: The text displayed to the user on the control.

Key defined only for the "edit" and "textbox" classes:

**`text`** (`string`)
: The contents of the control when the dialog is first displayed.
  This can contain newlines if the control is of the "textbox" class.

Keys defined only for the "intedit" and "floatedit" classes:

**`value`** (`number`)
: The value in the control when the dialog is first displayed. For the
  "intedit" class, if this is a non-integer number it will be truncated.

**`min`** (`number or nil`)
**`max`** (`number or nil`)
: If one of these are nil, the other must also be nil. (i.e. undefined.) If
  both are present, the control gets a spin button that the user can click
  to update the value of the control. The user won't be able to enter
  values outside the (inclusive) range between `min` and `max`.

Key defined only for the "floatedit" class:

**`step`** (`number or nil`)
: Specifies the size of change when the spin buttons are clicked. If nil,
  spin buttons will not be displayed even if `min` and `max` are set (but
  the values accepted will still be limited). Note that this does not
  require that `min` and `max` be set.

Keys defined only for the "dropdown" class:

**`items`** (`table`)
: This is an Array Table containing only strings. They are used for the
  options displayed to the user in the dropdown box.
  All strings in the array table should be unique. (There is not way to
  distinguish non-unique strings from each other.)

**`value`** (`string`)
: Determines which item is selected when the dialog is first displayed. If
  this is not one of the items specified, no item is selected. This is case-
  sensitive.

Key defined only for the "checkbox" class:

**`value`** (`boolean`)
: Determines whether the checkbox is checked or not when the dialog is first
  displayed.

Keys defined only for the "color", "coloralpha" and "alpha" classes:

**`value`** (`string`)
: A color value in VB or HTML hexadecimal format.
  For the "color" class, this should be a 3 byte value, i.e. "#RRGGBB".
  For the "coloralpha" class, this should be a 4 byte value, i.e. "#RRGGBBAA".
  For the "alpha" class, this should be a one-byte value, i.e. "#AA".

### Dialog Definition table format ###

The Dialog Definition table is simply an array of Dialog Control tables.

Note, however, that while the visual ordering of the controls are decided
entirely by the "x", "y", "width" and "height" of the controls, the
"tab order" of the controls is decided by their ordering in the Dialog
Definition table. Your users will thank you if you make these match up.

### Dialog Result table format ###

A Dialog Result table contains the user input from a configuration dialog.

The control "`name`" properties are used as keys in this table.

The type of the value for each entry in the table depends on the class of the
control. The control classes map to types in the following manner:

**`label`**: `nil`
: Since the user cannot change a label, they do not produce any value.

**`edit`**, **`textbox`**: `string`
: The text input in the box. This can contain newlines in the case of a
  **`textbox`** class control.

**`intedit`**, **`floatedit`**: `number`
: The number input into the control, guaranteed to be within the
  constraints set by the class (integer or float) and the min/max properties.

**`dropdown`**: `string`
: The case-exact text of the selected item.

**`checkbox`**: `boolean`
: The checked-state of the checkbox.

**`color`**, **`coloralpha`**, **`alpha`**: `string`
: A VB colorstring following the same scheme as for setting the
  **`value`** property.

Dialog result tables are purely output from the dialog. Changing them and then
redisplaying the dialog will not have any effect.

### Dialog button IDs
Legal values for button IDs are:
        ok
        yes
        save
        apply
        close
        no
        cancel
        help
        context_help

Note that many combinations of button IDs do not make sense and may have
strange effects. For example, having both `cancel` and `close` buttons is a bad
idea.

Buttons with an ID of `cancel` return false, as if ESC was pressed. A
button with an ID of `close` results in that button being triggered on
ESC rather than cancel.

Buttons with an ID of `ok`, `yes` and `save` are set as the default
affirmative button for the dialog.

Buttons with the ID `help` will be displayed as a question mark in a circle on
the left side of the dialog on OS X.

{::template name="automation_navbox" /}
