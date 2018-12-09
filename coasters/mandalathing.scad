$fn=36;
columns = 6;
starting_offset=25;
rows = 8;
shape_scaling = .8;
border_scaling = .9;
border = 1.5;
layer_rot=36;


module base_shape() {
    rotate([0,0,45])
    union() {
        circle(r=15);
        square(size=[50,7], center=true);
        square(size=[7,50], center=true);
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