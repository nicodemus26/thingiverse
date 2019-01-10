start_c=200;
start_thickness=7.5;
min_thickness=1;
rot_per_layer=6;
points=5;
a=360/points;
b=(180-a)/2;
c_prime=180-rot_per_layer-b;
sine_ratio=start_c/sin(c_prime);
C_PRIME=sine_ratio*sin(b);
scale_ratio=C_PRIME/start_c;

layers=floor(log(min_thickness/start_thickness)/log(scale_ratio));

module layer(i=layers){
    union(){
        difference(){
            circle(r=start_c,$fn=points);
            //if(i > 0)
            circle(r=start_c-start_thickness,$fn=5);
        }
        if(i > 0) {
            scale(scale_ratio*0.9999)
            rotate(rot_per_layer)
            layer(i-1);
        }
    }
}

layer();