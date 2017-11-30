# Simple Tune
## tune.rb (example Sonic-Pi script that sequences controls)
```
use_osc "localhost", 12000

def send_color(addr, c)
  osc addr, c[0],c[1],c[2],c[3]
end

live_loop :beat do
  sample :drum_bass_hard
  colors = (ring [1.0,0.0,0.0,0.5], [0.0,0.0,1.0,0.5], [0.0, 1.0, 1.0, 0.5])
  send_color "/color/inner", colors.tick()
  send_color "/color/outer", colors.tick()
  sleep 4
end

live_loop :casc do
  sample :drum_snare_soft if spread(2,4).tick
  sample :drum_cymbal_closed if spread(3,8).tick
  osc "/beat/inner", rrand(-5,5), rrand(-5,5) if spread(2,8).tick
  osc "/speed/outer", rrand(-0.09,0.09) if spread(5,8).tick
  sleep 1
end

live_loop :synth do
  notes = (scale :G, :minor_pentatonic).repeat(4).shuffle()
  if spread(5,8).tick()
    x = notes.tick()
    play x
    y = notes.tick()
    play y
    osc "/beat/inner", x,y
  end
  sleep 0.5
end
```

## Trailer Pattern
The associated trailer pattern
```
  return new SequenceBuilder(60*50)
  .anchor(center)
  .rotator(0,0,-0.005)
  .oscMomentum("/beat/inner", 0.5)
  .pen(100,0)
  .oscColor("/color/inner")
  .rotator(0,100,-0.0091)
  .oscSpeed("/speed/outer")
  .pen(200,0)
  .oscColor("/color/outer")
  .sequence();
```