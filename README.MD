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

#### SequenceBuilder
The `SequenceBuilder` API has the following methods:

* rotator(x,y,radians) : a rotate transformation, centered on x/y, rotating a specified number of radians a second
* translator(x,y,dx,dy,bx,by,bw,bh) : a translate transformation that starts at position x/y, moves dx/dy with each frame, but always remains in a rectangle defined by bx/by/bw/bh (boundaries defined as a java.awt.Rectangle)
* path(speed, ...points) : A path that traces a loop through a series of points at speed. Use the `v(x,y)` convenience function to define a point, eg: `.path(0.15, v(0,0), v(0,10), v(10,10))`
* anchor(x,y) : a translate transformation that doesn't continue to move after the fact
* pen(x,y) : a pen, which draws, at the offset specified
* sequence() : convert this builder process to a sequence object (final step in the chain)

#### FilterChain
The `FilterChain` is a set of post-processing filters, applied to the image-to-be-drawn in sequence. You can construct a filter chain with the following methods:

* draw() : draw the image with the current filters in the chain applied to it
* draw(x,y) : draw the image with the current filters applied, at this x/y coordinate
* tint(color) : add a tint to the filter-chain- all images drawn in the future will use this tint
* slide(x,y): move all future drawings of the image by this x/y displacement
* jitter(amount), jitter(amount,w,h) : a slide that moves the image randomly with each frame. By default, will always stay within 3x3 pixels of its origin, but w/h override that. Makes a jumpy appearance

## Apologies
I mean, this is something I hacked together for myself. Apologies for the documentation, and some… interesting quirks in the API.