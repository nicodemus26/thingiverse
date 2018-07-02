use <MCAD/2Dshapes.scad>;
$fn=360;

tube_radius=32.25/2;
cable_distance_from_tube=6;
cable_channel_width=2.4;
channel_guard_thickness=10;
channel_guard_degrees=30;
mount_thickness=4;
mount_degrees=210;

linear_extrude(10) // Guard length along tube
difference() {
    union() {
        // Mount brace
        rounded_corners=1;
        rotate([0,0,-channel_guard_degrees/2])
        minkowski() {
            circle(rounded_corners);
            donutSlice(tube_radius+rounded_corners,tube_radius+channel_guard_thickness-rounded_corners,0,channel_guard_degrees);
        }
        
        // Mount brace
        rotate([0,0,-mount_degrees/2])
        minkowski() {
            circle(rounded_corners);
            donutSlice(tube_radius+rounded_corners,tube_radius+mount_thickness-rounded_corners,0,mount_degrees);
        }
    }
    
    // Cable channel
    translate([tube_radius+cable_distance_from_tube,0])
    union() {
        circle(cable_channel_width/2);
        
        translate([0, -cable_channel_width/2])
        square([channel_guard_thickness,cable_channel_width]);
    }
}