Replace the code in `SetupSystem.pde#buildSequence` with one of these examples to see some useful demos in action.

**Scribbles**

```
  return new SequenceBuilder()
    .path(5,
      v(0,height),
      v(width,height/2),
      v(0,0))
    .path(10,
      v(0,100),
      v(100,50),
      v(0,0))
    .pen(0, 0)
    .rotator(0,0,-0.05)
    .pen(0,-40)
    .pen(0,120)
    .sequence();
```
---
**Pile of Ribbon**

```
  return new SequenceBuilder()
    .path(12,
      v(width/8,height/8),
      v(7*width/8,height/8),
      v(7*width/8,7*height/8),
      v(width/8,7*height/8)
    )
    .rotator(0,0,-PI/23)
    .rotator(75,0,PI/17)
    .pen(3,width/8)
    .pen(8,width/8)
    .pen(13,width/8)
    .sequence();
```
---
**Three Pen Cycloid**

```
  return new SequenceBuilder()
    .rotator(width/2,height/2,-PI/128)
    .rotator(90,0,PI/37)
    .pen(width/5,0)
    .pen(width/6,0)
    .pen(width/7,0)
    .sequence();
```
---

**Looping, Many Rotators**

```
  return new SequenceBuilder()
    .rotator(width/2,height/2,-PI/128)
    .rotator(width/15,0,-PI/128)
    .rotator(width/17,0,-PI/63)
    .rotator(-width/13,0,-PI/127)
    .pen(15,15)
    .pen(300,150)
    .sequence();
  ```
  ---

  **Marching Triangles**

  ```
    return new SequenceBuilder()
    .translator(0,height/2,width/65,0,0,0,width,height)
    .path(width/3.2,
      v(0,-100),
      v(100,0),
      v(0,100))
    .pen(-50,0)
    .pen(-50,200)
    .pen(-50,-200)
    .pen(-50,400)
    .pen(-50,-400)
    .sequence();
  ```

  **An OSC Controlled Sequence**

  ```
  return new SequenceBuilder()
    .anchor(center)
    .rotator(0,0,-0.005)
    .osc("/test/speed", "speed")
    .rotator(100,0,-0.009)
    .pen(100,0)
    .sequence();
```