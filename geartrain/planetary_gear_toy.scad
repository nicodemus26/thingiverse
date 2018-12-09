$fn=60;

big_num_teeth=20;
small_num_teeth=10;
big_gear_radius=20;
small_gear_radius=10;
tooth_depth=5;
axel_radius=5;
triangle_side=big_gear_radius*2+tooth_depth+small_gear_radius*2;

planetary_thickness=10;
planetary_inner_radius=big_gear_radius+(triangle_side/2)/cos(30);
planetary_outer_radius=planetary_inner_radius+planetary_thickness;
big_to_outer_arm_len=triangle_side/2+planetary_thickness;
mat_thick=25.4/8;

module gear(radius, num_teeth) {
    circumference=2*3.14159*radius;
    tooth_width=circumference/num_teeth/2-1;
    minkowski(){
        difference() {
            union() {
                circle(r=radius);
                for (i=[0:num_teeth-1]) {
                    rotate([0,0,i*360/num_teeth])
                    translate([radius,0])
                    square(size=[tooth_depth,tooth_width],center=true);
                }
            };
            circle(r=axel_radius);
        };
        circle(r=.5, $fn=12);
    }
}

module rounded_triangle(thickness=10, side=65){
    rotate([0,0,120])
    rounded_bar(thickness=thickness, side=side);
    translate([-side, 0])
    {
        rotate([0,0,60])
        rounded_bar(thickness=thickness, side=side);
        rounded_bar(thickness=thickness, side=side);
    }
}

module rounded_bar(thickness=10, side=65){
    translate([0,-thickness/2])
    union() {
        translate([side,thickness/2])
        circle(d=thickness);
        translate([0,thickness/2])
        circle(d=thickness);
        square(size=[side,thickness]);
    }
}

module billy_gears() {
    linear_extrude(mat_thick)
    rotate([0,0,30])
    translate([0,big_to_outer_arm_len])
    gear(radius=small_gear_radius,num_teeth=small_num_teeth);
}

module gear_shits() {
    translate([0,-triangle_side/2])
    linear_extrude(mat_thick)
    gear(radius=small_gear_radius,num_teeth=small_num_teeth);
    
    rotate([0,0,60])
    translate([0,-triangle_side/2])
    linear_extrude(mat_thick)
    gear(radius=small_gear_radius,num_teeth=small_num_teeth);
    
    translate([0,-triangle_side])
    rotate([0,0,30])
    translate([triangle_side/2,0])
    linear_extrude(mat_thick)
    gear(radius=small_gear_radius,num_teeth=small_num_teeth);
    
    rotate([0,0,60])
    translate([0,-triangle_side])
    linear_extrude(mat_thick)
    gear(radius=big_gear_radius,num_teeth=big_num_teeth);
    
    translate([0,-triangle_side])
    linear_extrude(mat_thick)
    gear(radius=big_gear_radius,num_teeth=big_num_teeth);
    
    
    linear_extrude(mat_thick)
    gear(radius=big_gear_radius,num_teeth=big_num_teeth);
    
    color(c=[1,0,1,.25])
    translate([0,0,mat_thick])
    linear_extrude(mat_thick)
    harness();
    translate([0,0,-mat_thick])
    linear_extrude(mat_thick)
    harness();
}

module orbit(){
    translate([(triangle_side/2)*tan(30),-triangle_side/2])
    linear_extrude(mat_thick)
    difference(){
        gear(radius=planetary_outer_radius, num_teeth=round(planetary_outer_radius));
        gear(radius=planetary_inner_radius, num_teeth=round(planetary_inner_radius));
    };
}

module harness(triangle_side=65) {
    translate([0,-triangle_side])
    rotate([0,0,30])
    {
        translate([triangle_side, 0])
        {
            rounded_triangle();
            rotate([0,0,-30])
            rounded_bar(side=big_to_outer_arm_len);
        }
        rotate([0,0,-150])
        rounded_bar(side=big_to_outer_arm_len);
    }
    rotate([0,0,120])
    rounded_bar(side=big_to_outer_arm_len);
}

gear_shits();
orbit();
billy_gears();