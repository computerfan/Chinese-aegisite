Aegisub引入了一个Windows自带取色器高端很多的颜色选择器。它允许你使用不同的色彩空间输入颜色值，16进制的HTML和ASS都可以，pick colors from a mini-screenshot and use three different color spectrums for graphically picking colors.


## Overview ##


[[img/Colour_picker.png]]{: class="center"}

The color picker has the following components:

* Color spectrum
* Parametric settings for four color-spaces 
* HEX input for ASS and HTML formats 
* Pick-from-screen control, for taking a mini-screenshot and picking a color from it 
* List of 32 last picked colors 

The last used mode of the color spectrum is remembered.


## Using the pick-from-screen function ##


1. The pick-from-screen control is located to the left of the last-used colors, in the lower part of the window. 
1. To start using it, click on the "pick color" symbol.
1. As you drag over the screen, you'll notice that the square box beside the pick color button turns into a magnification of the area the cursor is hovering over. 
1. When you've found the area you want to grab a color from, click the left mouse button to fixate the magnification.
1. Now click on the pixel you want to grab a color from in the magnification.

On OS X, you have to drag the pick control to the desired spot due to clicking on it and then clicking on the spot to pick from due to technical limitations.


## Descriptions of the color spaces ##

Here's a short round-up of the three available color spaces:

* _RGB_ - Red, Green and Blue, the three component colors a computer monitor uses to display images. In RGB mode, you specify the intensity of each of those three components. 
* _HSL_ - Hue, Saturation and Luminance. Hue is the actual "color of the color", that is, red, green, blue or a mix of those. Saturation is the "greyness" of the color, the lower the saturation, the closer to a shade of grey, the color becomes. Luminance is the lightness, max luminance means pure white, while zero luminance means pure black. 
* _HSV_ - Hue, Saturation and Value. Hue and Saturation mean the same as in HSL. Value, however, is different from the luminance in HSL. Value is the "non-blackness" of the color, the smaller the value, the closer the color is to pure black.

