{::options toc_levels="2,3" /}

## 主音频视图 ##

当你加载了音频文件，Aegisub将会出现如下图的界面：
[[img/audio_display.png]]

You can click and drag just below the audio timeline to change the height of
the audio waveform/spectrum display.

Green and red buttons are toggle buttons. A green background indicates that
the option is turned on, while a red background indicates that the option is
turned off. The buttons and controls are as follows (many of these have
[[keyboard shortcuts|Keyboard_shortcuts]] associated with them by default):

1. Go to previous line, discarding any unsaved changes (previous syllable
  when in [[karaoke mode|Audio#karaokemode]])
1. Go to next line, discarding any unsaved changes (next syllable when in
  karaoke mode)
1. Play selected area of the audio waveform
1. Play currently selected line
1. Pause playback
1. Play 500ms before selection start
1. Play 500ms after selection end
1. Play first 500ms of selection
1. Play last 500ms of selection
1. Play from selection start to end of file (or until pause is pressed)
1. Add lead-in (how much is determined by the [[audio lead in
  setting|Options#audio]])
1. Add lead-out (exactly like the above, but the setting is called [[audio
  lead out|Options#audio]], logically enough)
1. Commit (save) changes
1. Scroll view to selection/go to selection
1. Toggle auto-commit (if enabled, all timing changes are committed
  instantly rather than waiting for the user to press commit)
1. Toggle auto next line on commit (if this is enabled, Aegisub will
  automatically select the next line when the current line is committed by
  the user. Auto-commits do not trigger this, for obvious reasons)
1. Toggle auto-scrolling (will center waveform on the currently selected
  line automatically when enabled)
1. Toggle spectrum analyzer mode (see below)
1. Toggle Medusa-style timing shortcuts
1. Toggle karaoke mode
1. Audio display zoom (horizontal)
1. Audio display zoom (vertical)
1. Audio volume
1. Toggle linking of vertical audio zoom slider with volume slider

## Basic audio timing ##
When you click on a line in the subtitles grid, Aegisub will highlight it in
the audio display and, if you have auto-scrolling enabled, scroll the audio
display so it's centered on the line (during normal timing, it's usually a good
idea to disable auto-scrolling). You'll notice various vertical lines in the
audio display; the pink ones indicate keyframes in the video if you have it
loaded (see the [[Working with video|Video]] section), the white broken line
indicates the currently visible video frame, and the thick red and orange ones
are the line start and end markers (respectively) for the current line. To
(re-)define the start and end times of the line, you can either left-click to
set the start time and right-click to set the end time, or just drag-and-drop
the line boundaries.  Press the _play_ button (keyboard shortcut _s_ by
default) to listen to the selection, or the various other playing buttons to
listen to parts of the selection or the audio surrounding it. When you are
satisfied with the timing, press commit to save the line and move onto the next
one. Then repeat once for every line; it's as simple as that.

Holding shift will make line boundaries snap to other lines and keyframes (or disable snapping if you've set the option to snap by default).
Holding ctrl will let you drag multiple overlapping boundaries at once.
For example, if you have two lines already snapped to each other but want to shift the transition between the lines back a little, you can select both lines in the grid, then hold ctrl and drag the boundary between them to change both the end time of the first line and the start time of the second line.

Holding alt will make you drag all selected lines (both start and end times).

### Timing protips ###
If you want to finish timing your movie or episode within any reasonable
amount of time, there's some things you should note:

* Use keyboard shortcuts! They speed up your work by several orders of
  magnitude.
* You don't need to have video displayed while timing. If you think you do,
  there's a good change you're doing something wrong. Scene-timing, i.e.
  syncing line start/ends to scene changes, can be done later. Either
  manually, or with the [[timing postprocessor|Timing_Post-Processor]].
* Use "go to next line on commit".
* Experiment with different timing styles when you're new and stick to one
  that suits you. Then practice. Lots.
* Aegisub heavily relies on the concept of "focus", and doing things in a
  way that require you to switch back and forth between video/audio/subtitle
  edit box a lot will cost you a lot of time. Do it in several "passes"
  instead.
* The spectrum analyzer mode looks weird at first, but usually makes it lot
  easier to "see" where lines start and end, especially when there is
  background noise.
* With practice, it's often faster and easier to time something from scratch
  than fix bad timing, due to that fixing bad timing requires spending a small
  amount of time thinking about each line.
* If you want to delete all timing data and start over, a simple way is to use
  the [[shift times dialog|Shift_Times]] to shift all lines backwards by
  9:59:59.99.

One common timing style (preferred by the author of this page) goes something
like the following: Turn on "go to next line on commit" but disable
auto-committing, auto-scrolling and Medusa timing shortcuts. Keep the four main
fingers of your left hand on s/d/f/g. You won't be using the thumb so do
whatever you want with it. Keep your right hand on the mouse. Now select (by
left- and right-clicking) an area in the waveform that seems likely to contain
a line of speech matching the current subtitle line, and hit _s_ to play it
back.  While it's playing, adjust the start time if necessary. When the
playback marker has passed the end time mark, adjust the end time as well. If
greater accuracy is needed, play the last 500ms of the selection by pressing
_d_, 500ms before the selection start by pressing _q_, 500ms after the
selection end by pressing _w_, or the first 500ms of the selection by pressing
_e_. As you grow more experienced, you won't be using anything else than _s_
very much, except maybe _d_ and _q_. When you're satisfied with the timing, hit
_g_ to commit changes and go on to the next line. Scroll the audio display
forward by pressing _f_. If you need to scroll it backwards, use _a_. To go to
next or previous line without committing changes, use _z_ and _x_.

This style has the advantage that you never need to move your hands at all.
With some training, it can also be very fast; audio timing 350-400 lines of
dialog to a 25-minute episode can easily be done in less than 40 minutes,
and less verbose scripts can sometimes be done faster than real time.

Of course, this style may not feel comfortable for all people; you should
experiment with other timing styles before deciding which one is best for
you.

### The spectrum analyzer mode ###
[[img/spectrum.png]]

When you press the spectrum analyzer button, the waveform does no longer
show amplitude (signal strength) on the vertical axis - instead it shows
frequency. The higher up, the higher the frequency. The colors instead
indicate amplitude, with black/dark blue being silence and white being the
strongest sound. This may seem confusing, but since the frequency window is
set to fit human voices rather well, it can make it easy to tell where a
line (or a word in karaoke mode) starts and ends when there's a lot of
background noise (or music) that makes it hard to tell from the normal
waveform. It can be especially useful when timing karaoke. Play around with
it for a little while, and you'll understand how it works.

Note that in spectrum analyzer mode, the "vertical zoom" slider is redefined
to control color intensity instead, since the colors indicate signal
strength.

Because calculating the spectrum data is very CPU intensive, it in initially
set to be in a medium quality. You can increase the quality of the spectrum
in the [[audio options|Audio#options]]. This is mostly important when you built
Aegisub yourself and did not use FFTW3; FFTW3 is fast enough that the default
quality is bumped up a bit.

## Karaoke timing ##
{::template name="todo"}here be dragons{:/}
