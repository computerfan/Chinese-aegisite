---
title: 杂项API
---
{::options toc_levels="2,3" /}

This page documents **miscellaneous APIs useful for working with
subtitles**. These can't be clearly placed into any of the other main
categories and there's too few of each kind to warrant a separate category.

## aegisub.cancel ##
Synopsis: `aegisub.cancel()`

Immediately end execution of the current script, rolling back any changes
that have been made in it.

This function never returns.

## aegisub.text_extents ##
Synopsis: `width, height, descent, ext_lead = aegisub.text_extents(style, text)`

Obtain system font metrics and determine the rendered size in pixels of the
given **text** when using the **style**.

**`@style`** (`table`)
:   A [[style
    table|Automation/Lua/Subtitle_file_interface#styletable]] as defined by
    the subtitle interface. The font name, size, weight, style, spacing and
    encoding is used to determine the size of the text.

**`@text`** (`string`)
:   The text the extents should be determined for. This
    should not contain line breaks (`\n` or `\r\n`) nor should it contain
    formatting codes of any kind. Formatting codes are not interpreted and
    will be taken as verbatim text.

**`width`** (`number`)
:   Width in pixels of text. This may be non-integer.

**`height`** (`number`)
:   Height in pixels of the text. This may be non-integer.

**`descent`** (`number`)
:   Length of descenders in the font. This may be
    non-integer.

**`ext_lead`** (`number`)
:   External leading for the font. This may be non-integer.

You should only feed plain text strings without line breaks into this
function. It cannot handle any kind of formatting codes or text layout.
Rather, it is intended as a helper to create text layouts by determining
rendered sizes of bits and pieces of a longer text, which can then be
laid out by the script.

## aegisub.gettext ##
Synopsis: `translation = aegisub.gettext(untranslated)`

Get the translation for a string. This is mostly only intended for scripts
bundled with Aegisub (as there's no way for you to add your own
translations), but if you happen to be using strings that are present in
Aegisub it may be useful.

Note that in the bundled macros this is always aliased to `tr` for the sake
of the string extractor.

## Getting information on the video  ##
Automation 4 Lua offers two functions designed to be able to work with
frame-based timing without having to consider whether the video source is
VFR or CFR.

The primary purpose of these functions is to be able to generate per-frame
effects, i.e. get the timestamps of a number of sequential frames and
calculate coordinates, sizes etc. for an object for each of those frames.

One thing to remember when using these functions is that, considering a
one-dimensional time line, a time stamp is a point on the time line, while
a video frame spans a range of the time line, from its beginning time to
its ending time. The ending time of a frame is the beginning time of the
next. The beginning time of a frame is included in the range while the
ending time is excluded from the range.

### aegisub.frame_from_ms  ###
Synopsis: `frame = aegisub.frame_from_ms(ms)`

Use loaded frame rate data to convert an absolute time given in
**milliseconds** into a **frame** number.

**`@ms`** (`number`)
:   Absolute time from the beginning of the video, for
    which to determine the frame number.

**`frame`** (`number`)
:   Frame number corresponding to the time in ms, or `nil` if there is no
    frame rate data loaded.

If the time is in the middle of the frame it is **rounded down** to the frame
number that contains the given time.

### aegisub.ms_from_frame  ###
Synopsis: `ms = aegisub.ms_from_frame(frame)`

Use loaded frame rate data to convert a **frame** number of the video into
an absolute time in **milliseconds**.

**`@frame`** (`number`)
:   Frame to obtain the beginning time of.

**`ms`** (`number`)
:   First integer millisecond time stamp to lie within the frame, or `nil` if
    there is no frame rate data loaded.

Because beginning times of frames can have better precision than one
millisecond this function rounds up and returns the first whole millisecond
that is guaranteed to be within the frame.

### aegisub.video_size  ###
Synopsis: `xres, yres, ar, artype = aegisub.video_size()`

Get information about the resolution and aspect-ratio of the loaded video,
if any.

**`xres`** (`number`)
:   Coded width of the video in pixels, or `nil` if there is no video loaded.

**`yres`** (`number`)
:   Coded height of the video in pixels, or `nil` if there is no video loaded.

**`ar`** (`number`)
:   Custom display aspect ratio override. Meaningless unless `artype` is 4.

**`artype`** (`number`)
:   There are 5 values that `artype` can take:

    * 0: The video has square pixels, i.e. PAR is 1.00 and DAR is `xres`/`yres`.
    * 1: The video is 4:3, i.e. DAR is 1.33.
    * 2: The video is 16:9, i.e. DAR is 1.78.
    * 3: The video is 2.35 format, i.e. DAR is 2.35.
    * 4: The DAR is whatever the `ar` return value contains.

### aegisub.keyframes ###
Synopsis `keyframes = aegisub.keyframes()`

Get a list of what video frames are keyframes.

**`keyframes`** (`table`)
:   A sorted table where each entry is the frame number of a keyframe. If
    no keyframe data is loaded, the table will be empty.

## aegisub.decode_path ##
Synopsis `path = aegisub.decode_path(encoded_path)`

Convert a path beginning with a [[path specifier|Aegisub_path_specifiers]]
to an absolute path.

**`@encoded_path`** (`string`)
:   A string which may optionally begin with an Aegisub [[path specifier|Aegisub_path_specifiers]].

**`@path`** (`string`)
:   If `encoded_path` began with a valid [[path
    specifier|Aegisub_path_specifiers]], an absolute path. If it began with an
    invalid path specifier (such as if ?video was used when no video is open),
    a string that is unlikely to be useful in any way. Any other strings are
    passed through untouched.

## aegisub.project_properties
Synopsis `properties = aegisub.project_properties()`

Get a table containing information about what files the user currently has open.
The exact contents of this table are deliberately undocumented, and may change without warning.

{::template name="automation_navbox" /}
