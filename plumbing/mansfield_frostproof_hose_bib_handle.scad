include <../lib/phyllotaxis.scad>;

handle_depth=5;
handle_to_square_depth=5;
square_fitting_depth=12;
square_fitting_od=13.50; 
square_fitting_inner_width=8.59;
square_fitting_chamfer_square=9.74;
screw_bore=6.8;
max_seeds=100;

handle(handle_depth, screw_bore, max_seeds);

translate([0,0,handle_depth])
handle_to_square(square_fitting_od, handle_to_square_depth, screw_bore);

translate([0,0,handle_depth+handle_to_square_depth])
square_fitting(square_fitting_depth, square_fitting_od, square_fitting_inner_width, square_fitting_chamfer_square);

module handle_to_square(square_fitting_od, handle_to_square_depth, screw_bore) {
    difference() {
        cylinder(d=square_fitting_od, h=handle_to_square_depth);
        cylinder(d=screw_bore, h=handle_to_square_depth);
    }
}

module handle(depth, screw_bore, max_seeds) {
    linear_extrude(depth)
    difference() {
        phyllotaxis_body(max_seeds=max_seeds, seed_diameter=3.7, min_r=screw_bore*2);
        circle(d=screw_bore);
    }
}

module square_fitting(depth, od, inner_width, chamfer_width) {
    linear_extrude(depth)
    difference() {
        circle(d=od);
        intersection() {
            square(inner_width, center=true);
            rotate(45)
            square(chamfer_width, center=true);
        }
    }
}