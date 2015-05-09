{::options toc_levels="2,3" /}

{::template name="todo"}截屏图片待更新{:/}

**关于这个功能，你能在 [[视频教程|Tutorials]]中找到。**

## 总览  ##
[[img/video_display.png]]{: class="center"}

### 播放 ###
播放视频, 从当前帧开始。查看
[[使用视频#playingvideo]] 来获取Aegisub中有关的信息。

### 播放当前行 ###
从当前活动行的开始帧播放视频，到该行结束帧停止。

### 自动定位视频至行开始帧 ###
当选择新一行时，视频自动定位到该行的开始帧。

### 帧时间和编号 ###
显示当前帧数和当前帧对应的开始时间。如果当前播放的帧是关键帧，这个框区的背景色就是绿色的。

注意，有些情况下使用 "将当前视频帧设为所选字幕的开始时间" (Ctrl-3) 和 "将当前视频帧设为所选字幕的结束时间" (Ctrl-4) 得到的结果会与预期显示的不同，这是因为一些近似取整的错误导致的。（译者注：主要发生在预览视频为60FPS或15FPS时，所谓的逐帧对不准现象，可以手动调节时间解决）

{::template name="todo"}Is the main toolbar actually documented anywhere?{:/}

### 字幕相对时间 ###
显示当前视频帧相对于当前活动行开始时间的时间（偏移量），或相对于活动行结束时间。
当你使用含有相对时间参数的特效标签时，这两个时间十分有价值，如 [[\t|ASS_Tags#animatedtransform]] 和 [[\fad|ASS_Tags#fade]]。

### 缩放 ###
缩放当前视频的显示大小。

### 视频位置滑块 ###
用来定位视频位置。按住Shift的同时拖动滑块会自动吸附关键帧。默认情况下←→键可以逐帧定位视频;
Alt-left/right可以一次性调整10帧;Shift-left/right可以跳到前后的关键帧。激活视频滑块可以用右键单击它或者按Ctrl-Space。如果视频滑块已经被激活，按Ctrl-Space可以回到之间的活动部分。

## 视频背景菜单 ##
你可以右键单击视频部分打开一个背景菜单，它有以下选项:

[[img/Visual_menu.png]]{: class="center"}

保存PNG截图
: 把当前帧保存为一张 PNG 屏幕截图，保存路径在 [[选项]] 中可以调节。截图分辨率和视频分辨率相同，不会受缩放或其它因素影响。

复制图像至剪贴板
: 与上面功能相同，只是把这张图片复制到剪切板，而不是存储成PNG文件，你可以把它粘贴到其他编辑软件里。

保存PNG截图 (不带字幕)
: 和之前的功能相同，不过图片中字幕是不可见的。

复制图像至剪贴板 (不带字幕)
: 和上面的功能相同，但是只把它复制到剪切板。

复制坐标到剪切板
: 复制目前鼠标所在的坐标到剪切板, 例如"230,152"

## 左边栏工具描述  ##
目前有七种不同的可视化排版工具可供使用: 十字工具（标准模式定位工具）,
拖放字幕, 绕z轴旋转字幕,绕xy轴旋转字幕,缩放工具（沿X轴或Y轴的缩放工具）,矩形裁剪工具和矢量裁剪工具。

### 十字工具  ###

这是标准模式，点击工具后在视频区域移动光标，光标会变为十字，十字附近会显示出光标所在点相对视频的坐标。默认情况下这个坐标是相对于左上角，按下Shift后这个坐标是相对于右下角计算。双击点会把该点的坐标以 [[\pos 标签|ASS_Tags#setposition]] 的形式写入到当前行中。如果按下Alt同时双击，当前所有选择的行都会和被移动的行移动相同的距离(包括当前帧不可见的行)。(译者注:用于批量调整已有pos行的重定位，不会造成相对移动)

[[img/Visual_crosshair.png]]{: class="center"}

### 拖动工具  ###

拖动工具有两种模式。你可以使用辅助工具条在两种模式之间切换。


[[img/Visual_drag.png]]{: class="center"}

在定位模式下，你可以简单地在视频表面点击-拖动字幕（通过“锚”，即那个方块）。你松开按键时的 [[\pos|ASS_Tags#setposition]] 参数会被写入到行中。

在移动模式下，会有另一个圆形的“锚”，它用来定位移动终点的坐标。设置好移动的起点终点后，会有一条箭头线从起点指向终点。为了更好地控制时间，建议起点按照移动的起始帧定位，终点按照移动的终止帧定位。举个例子，如果你想让一行字幕从行开始5000毫秒后开始移动，就先把视频调节到相对该行5000毫秒的时候，定起点，确定完成移动的时间，调节视频到结束时间，定终点。

如果你的行已经定了原点，你会看见第三个三角形的“锚”，和方形锚之间以虚线连接。你可以拖动它来改变原点的定位，在选择其他的旋转工具时，锚也是可见的。

如果按住Shift进行拖动操作，则只能进行X或者Y坐标的变化 (变化谁取决于哪个变化量大)。

按下Ctrl同时点选锚可以进行批量操作。

双击没有锚的部分会把当前活动锚移动到该点，和十字工具相似。如果按住 Alt 同时进行操作，已选择的行的锚定位会相对于活动行进行。（不会相对移动）

### 沿Z轴旋转  ###

在此模式下，你会看见一个圆圈（以字幕中心为圆心）和字幕底边线，圆圈被6个弧度包围，用以辅助旋转和计算角度。

[[img/Visual_rotate_1.png]]{: class="center"}

这个工具提供了两种可调节功能。你可以定位旋转中心（原点），相当于使用 [[\org|ASS_Tags#rotationorigin]] 标签)，或者你随意点击来确定旋转的角度。

你会注意到圆心和光标有一条连线，当你按住鼠标左键的同时拖动时，可以看到字幕旋转的实际效果。旋转角度合适时松开鼠标。按住Ctrl同时进行旋转会以30°为单位角度增量进行。

如果原点距离字幕中心较远，你会看见字幕下方有一条辅助线，它也会随着角度变化重新定位。

如果已选多行，所有的行都会被加入旋转标签(但是不会像十字工具或者拖动工具那样相对旋转)。


[[img/Visual_rotate_2.png]]{: class="center"}

### 沿XY轴旋转 ###
这个模式和上面的模式相似，尽管有很多要点不同。因为这个旋转同时定位两个轴的旋转角，所以看起来是3D的，因此也更难准确使用。

为了使它更容易用，字幕所在平面会显示为一个网状辅助平面。从原点有三条射线，指明XYZ轴正方向。

[[img/Visual_rotate_xy.png]]{: class="center"}

To use this tool, simply hold the mouse button anywhere on the screen and move
it. As you move it left and right, it will rotate the line on the Y axis, and
as you move it up and down, it will rotate the line on the X axis.

If you hold down the shift key while rotating, the rotation will be limited to
only one of the two axes - whichever has the greatest movement. If you hold
down the ctrl key, rotation will happen in steps of 30 degrees.

If multiple lines are selected, all selected lines are set to the new rotation
(and not rotated relative to each other as in the drag and crosshair tools).

As with the Z rotation tool, you can also drag the origin anchor here.

### Scale  ###
This is the simplest tool, and allows you to scale subtitles on the X and Y
axes. It will show one bar for each axis, showing not only the 100% size, but
also the current scale.

[[img/Visual_scale.png]]{: class="center"}

To use this tool, simply hold down the mouse button and drag the mouse up and
down (to scale on the Y axis) or left and right (to scale on the X axis). You
can hold down the shift key to limit scaling to the axis where the biggest
change happened, and ctrl to limit it to increments of 25%.

### Rectangular clip  ###
The rectangular clip tool allows you to clip the subtitles so that nothing
OUTSIDE an axis-aligned rectangle can be displayed (in essence, the
`\clip(x1,y1,x2,y2)` tag).

[[img/Visual_clip.png]]{: class="center"}

There are two ways to use this tool. You can either click and grab one of the
four vertices of the rectangle, to resize an already-existing clip, or you can
click-and-drag in empty space to create a new rectangle from scratch. The areas
that will be invisible will be darkened.

### Vectorial clip  ###
Similarly to the last tool, the vectorial clip tool allows you to draw an area,
so that nothing outside it will be rendered. The difference, however, is that
this area can have any arbitrary shape defined by a path of lines and bézier
curves.

[[img/Visual_vector_clip.png]]{: class="center"}

This mode has 8 sub-tools:

[[img/Visual_vector_toolbar.png]]{: class="center"}

1. Drag - Allows you to drag a control point
1. Insert line - Allows you to insert a straight line from the last point to
    the current mouse position by clicking the point.
1. Insert bézier bicubic curve - The same as above, but it instead inserts a
    bicubic curve. You can then use the two control points to adjust the shape
    of the curve.
1. Convert between line and curve - Click on a line segment or bicubic curve
    to convert it to the other type.
1. Split curve - Click on a line segment or bicubic curve to split it in
    two, at the marked point.
1. Remove point - Click on a point to delete it.
1. Freehand shape - Click and drag with the mouse over the video and move
    the mouse to draw a freehand shape composed of line segments. This shape
    will automatically be closed, with the last point connecting to the first.
1. Freehand smooth shape - Same as above, but the shape will be smoothed
    with bicubic curves.

As with the drag tool, multiple control points can be selected at one by
ctrl-clicking on the anchors to be added or removed from the selection. By
default all control points are selected; to deselect them all click on a
blank spot when in Drag mode. Multiple control points can be selected at once
by clicking and dragging in move mode to perform a box selection.
