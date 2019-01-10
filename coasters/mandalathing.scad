$fn=36;
columns = 7;
starting_offset=25;
rows = 7;
shape_scaling = .7;
border_scaling = .95;
border = 1.5;
layer_rot=80;


module base_shape() {
    lobe_r=10;
    lobe_disp=9;
    translate([10,0])
    scale(.5)
    rotate([0,0,-36])
    union(){
        hull() {
            translate([-lobe_disp,0])
            circle(r=lobe_r);
            translate([0,-lobe_disp*2])
            circle(r=lobe_r/3);
        };
        hull() {
            translate([lobe_disp,0])
            circle(r=lobe_r);
            translate([0,-lobe_disp*2])
            circle(r=lobe_r/3);
        };
    }
};

module layer_shapes(i=0) {
    rotate(i*layer_rot)
    scale([pow(shape_scaling, i),pow(shape_scaling, i)])
    for (i=[0:columns-1]) {
        rotate([0,0,i*360/columns])
        translate([starting_offset,0])
        base_shape();
    }
}

module layer(i=0) {
    if (i==0) {
        layer_shapes(0);
    } else {
        union(){
            difference() {
                layer(i-1);
                minkowski() {
                    layer_shapes(i);
                    circle(r=pow(border_scaling, i)*border);
                };
            };
            if(i-1==rows) {
                hull() {
                    layer_shapes(i);
                }
            } else {
                layer_shapes(i);
            }
        }
    }
}

difference(){
    minkowski(){
        hull()
        layer(rows-1);
        circle(r=border);
    };
    layer(rows-1);
}