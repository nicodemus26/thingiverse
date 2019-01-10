set raytracer::size [3840x2160]
set raytracer::samples 32

#define thk 0.15
#define phk 1.15
#define xhk 0.15
#define corner 5
#define rotx 8
#define roty 9
#define rotz 10


{ hue 20 sat 0.8 a 0.8 s 20 } r2 

rule r2 maxdepth 40 {
{ s 0.75 rx rotx ry roty rz rotz b 0.9 hue 36   }  r2
frame
}

rule frame  {
{ s thk phk thk x 5  z 5 } box
{ s thk phk thk x 5  z -5 } box
{ s thk phk thk x -5  z 5 } box
{ s thk phk thk x -5  z -5 } box

{ s phk thk thk y 5  z 5 } box
{ s phk thk thk y 5  z -5 } box
{ s phk thk thk y -5  z 5 } box
{ s phk thk thk y -5  z -5 } box

{ s thk thk phk y 5  x 5 } box
{ s thk thk phk y 5  x -5 } box
{ s thk thk phk y -5  x 5 } box
{ s thk thk phk y -5  x -5 } box

{ s xhk y 5 x 5 z 5 s corner } sphere
{ s xhk y 5 x 5 z -5 s corner } sphere
{ s xhk y 5 x -5 z 5 s corner } sphere
{ s xhk y 5 x -5 z -5 s corner } sphere
{ s xhk y -5 x 5 z 5 s corner } sphere
{ s xhk y -5 x 5 z -5 s corner } sphere
{ s xhk y -5 x -5 z 5 s corner } sphere
{ s xhk y -5 x -5 z -5 s corner } sphere
}
