
use <MCAD/2Dshapes.scad>;
$fn=360;
rotate([180,0,0])
union() {
    stake_shield(10,3,10);
    //stake(10, 1.75, 10-2, 90);
    

}

module cord_hole() {
    //translate([10, 5, 0])
    //rotate([0,-90,0])
    //cylinder(20, 5, 5);
    
    //translate([0,-3,0])
    //rotate([-45,0,0])
    //linear_extrude(20)
    //translate([-10,0,0])
    //square(20,20);
    translate([-10, 4, 3])
    union() {
        translate([0,-2,-4])
        cube([20,4, 4]);
        translate([0,0,-2])
        cube([20,4, 4]);
        rotate([0,90,0])
        cylinder(20, 2, 2);
    }
}

module stake_shield(radius, top, bottom) {
    
    // Bottom, with cutout for stake inside
    difference() {
        cylinder(bottom, 2, radius);
    
        stake(bottom, 2, radius-2, 90);
        
        rotate([0,0,105])
        cord_hole();
        
    }
    
    // Top, with no cutout and rounded top
    translate([0,0,bottom])
    rotate_extrude()
    rotate([0,0,90])
    polygon([[0,0], [top,0], [top, radius-(top/2)], [(top/2), radius], [0, radius]]);
    //translate([-radius/2,top/2,bottom])
    //complexRoundSquare([radius, top], rads4=[top/2,top/2]);
}

module stake(depth, thickness, fin_length, fin_angle) {
    //translate([0,0,depth/2])
    intersection() {
        cylinder(depth, fin_length+.5, fin_length+.5);
        scale([1.1,1.1,1])
        linear_extrude(depth)
        for (i = [0,1,2]) {
            rotate([0,0,120*i])
            fin(thickness, fin_length, fin_angle);
        }
    }

}
module fin(thickness, length, angle) {
    rotate([0,180,0]) {
        translate([(0-length+(thickness/2)),0,0]) {
            //module donutSlice(innerSize,outerSize, start_angle, end_angle) 
            //donutSlice([length-thickness,length+.5],[length,length],0,angle);
            donutSlice([length-thickness,length-(thickness/2)],[length,length],0,angle);
        }
    }
}