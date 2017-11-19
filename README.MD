# Trailers
## Capsule
Trailers is an "advanced spirograph", or more practically, a transformation sequencer. Pens trace out a path described by a sequence of transformations to create arcs, patterns, etc.

## Examples
Note: some of these examples have had a little post-processing in an image editor, but I'll be adding those features to the images later…

<img src="https://i.imgur.com/rlTWSSK.png" width="120">
<img src="https://i.imgur.com/8VVVrRe.png" width="120">
<img src="https://i.imgur.com/S4UIVsJ.png" width="120">
<img src="https://i.imgur.com/RXKbsM5.png" width="120">

[Gallery](https://imgur.com/a/PUXCl)

## Usage
### Running
The `draw` and `setup` methods are in `Trailers.pde`. It runs as any other sketch. While running, you can use the following keys:

* SPACE: pause the drawing
* f: toggle whether post-filtering happens
* s (or mouse click): save a screenshot of the current view

### Designing
In `SetupSystem.pde` there are two methods, `buildSequence` and `buildFilters`. These both use a builder-pattern API, which allows you to add transformations and filters to the output. This is the main thing you need to edit to create your own pictures.

Check [SampleSequences](SampleSequences.md) for examples.

#### SequenceBuilder
##### Using the sequence builder
The sequence builder is your tool for constructing sequences. It is a fluent API, which allows you to construct a chain of transformations.

##### Constructing your SequenceBuilder
You can create a `SequenceBuilder` with two different constructors:

* `SequenceBuilder()` : creates a `SequenceBuilder` with a default color of pure white, and no palette applied.
* `SequenceBuilder(Palette p)`: creates a `SequenceBuilder`, also with a default color of white, but with aa palette available. This palette object can control pens and colors.

This initiates the construction of a sequence. Once the sequence is built, the `sequence()` method ends the chain and returns it.

##### Building Transformation Chains
The core job of your sequencer is to construct a matrix through a series of transforms. Each of these methods returns a `SequenceBuilder` object, making this a fluent API.

* `anchor(x,y)`/`anchor(PVector p)` : a simple translation
* `translator(float x, float y, float dx, float dy, float bx, float by, int w, int h)` : this awkward method signature defines a point (x/y), and a velocity (dx/dy). This point is contained in a box, defined by (bx,by,w,h). When the point strikes the edge of the box, it reflects. Boundaries need to be defined relative to the origin of the point.
* `translator(PVector point, PVector vel, Rectangle r)` : same as above, but using vectors/rectangles to define the boundaries
* `rotator()` : create a rotating transformation centered at (0,0) with a speed of 0.125 radians / frame.
* `rotator(float x, float y, float speed)`/`rotator(PVector p, float speed)` : create a rotating transformation centered at the point given, rotating with the speed, in radians per frame.
* `path(float speed, PVector... points)` : define a path, and then translate along that path, based on the speed. Use the convenience function `v(x,y)` to define points, eg: `.path(0.15, v(0,0), v(0,10), v(10,10))`
* `ellipse(float x, float y, float major, float minor, float speed)`: translate along points that fall on an ellipse, centered at x/y, with radii major/minor. Speed is the delta-x on the boundary of the ellipse, per frame.
* `sin(float x, float y, float scaleX, float scaleY, float speed)` : a sin/cos translator. X is controlled by sin, Y is controlled by cos. Points are centered on x/y, and the output of the sin/cos function is scaled by scaleX/scaleY. Speed is delta-radians per frame.

##### Wrapper Transfomations
There are "special" transform methods which alter the last added transformation to the chain.

* `ratchet(int frames)` : a "sleep" or "stutter" function. As most transforms are time based, this adds stutter to that timing. Instead of ticking every frame, it ticks after `frames` have passed. It then ticks forward the same number of frames, meaning it catches up with where it was supposed to be.
* `ramp(float step, float max)` : cause the wrapped transform to "tick" n\*step times in each frame, where n is the number of frames. When n\*step = max, n resets to zero.

##### OscWrappers
In addition to being able to wrap some basic modifiers around transforms, these transforms can also be wrapped in OpenSoundControl-based controllers, allowing audio software to send messages to the application.

*This is a white-box API, which means you need to know the names of fields exposed by the wrapped transform. It's basically useless without knowing details about the implementation of the underlying Transform. I may or may not change that in the future.*

All of these transforms *unwrap* any previously wrapped transforms, that is to say they can only control *base* transforms- `rotator`, `sin`, `pen`, but not `ramp` or `ratchet`.

* `osc(String addr, String... mappings)` : listens for an OSC message sent to `addr`. Upon receiving that message, it will take the first `mappings` entry, the first field on the message, and set the property of the underlying transform with the `mappings` name equal to that value. It repeats that for each other mapping, and it will throw an exception if you don't have at least as many fields on the OSC message as there are in the `mappings` set.
* `oscColor(String addr)` : May only be applied to a `Pen`. Listens for an OSC message sent to `addr`. That message must contain 4 floating point values. Changes the pen color to those values, using (rgba). These values should be between 0 and 1.
* `oscColor(String addr, Palette p)` : May only be applied to a `Pen`. Listens for an OSC message sent to `addr`. That message should contain a string which is the name of a color in the `Palette p`. Changes the pen color to that value.

##### Pens
None of the transforms are useful unless you draw something, which is where pens come into play. Pens trace a line through the points they visit, providing the sequence with what should be drawn.

* `col(int col)`: set the default color for the next pens on the chain. This is the default color until the `col` method is called again. The parameter is the Processing color value.
* `col(int r, int g, int b, int a)`: same as above, but defined by its color components.
* `col(String name)`: same as above, but gets the color from the current palette, by name. 
* `pen()`: adds a pen at the *current* origin in the transform matrix, with the current color as its color.
* `pen(PVector pos, int col)` : add a new pen, translated by pos, with color `col`
* `pen(float x, float y, int col)` : same as above
* `pen(float x, float y, String name)` : a new pen, at x/y, with a named color from our palette
* `pens(PVector pos, PVector step, int n)` : add `n` pens, starting at `pos`, then translating by `step` before each added pen
* `pens(PVector pos, PVectorr step)` : adds one pen for each color in the palette.

#### FilterChain
The `FilterChain` is a set of post-processing filters, applied to the image-to-be-drawn in sequence. You can construct a filter chain with the following methods:

* draw() : draw the image with the current filters in the chain applied to it
* draw(x,y) : draw the image with the current filters applied, at this x/y coordinate
* tint(color) : add a tint to the filter-chain- all images drawn in the future will use this tint
* slide(x,y): move all future drawings of the image by this x/y displacement
* jitter(amount), jitter(amount,w,h) : a slide that moves the image randomly with each frame. By default, will always stay within 3x3 pixels of its origin, but w/h override that. Makes a jumpy appearance

## Apologies
I mean, this is something I hacked together for myself. Apologies for the documentation, and some… interesting quirks in the API.