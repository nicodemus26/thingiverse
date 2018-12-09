start_gap = 0;
length = 100;
gradients = 10;
gap_delta = .1;
grad_width = length/gradients;
sine_height = 5;
end_gap = gradients*gap_delta+start_gap;
pi=3.141592653589793238;

for (grad = [0:gradients]) {
    x_off=length*grad/gradients;
    gap = grad*gap_delta+start_gap;
    
    // Label
    color("#FF0000")
    translate([x_off,-2*gap_delta*gradients])
    rotate(90)
    scale(.5)
    text(text=str(gap), font="Beon", halign="right", valign="center");
}
x_offs = [ for(i=[-grad_width/3:.05:length+grad_width/3]) i ];
sine_bottom = [ for (i=[0 : len(x_offs)-1]) 
    [x_offs[i], -cos(x_offs[i]*(360/grad_width))+1+(end_gap-start_gap)*(1-(-x_offs[i]+length)/length)]
];
polygon(points=concat([[-grad_width*2,grad_width/2]],sine_bottom,[[length+grad_width*2,grad_width/2]]));
echo(sine_bottom);
translate([-grad_width*2,-gap_delta*gradients])
square(size=[length+grad_width*4,gap_delta*gradients]);
