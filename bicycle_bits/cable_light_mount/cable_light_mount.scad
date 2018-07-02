use <MCAD/2Dshapes.scad>;
$fn=360;

tube_radius=32.25/2;
cable_distance_from_tube=5;
cable_channel_width=2.4;
channel_guard_thickness=9;
channel_guard_degrees=20;
mount_thickness=3;
mount_degrees=210;
brace_length=5;

rounded_corners=1;

//linear_extrude(10) // Guard length along tube
difference() {
    union() {
        // Mount brace
        linear_extrude(brace_length)
        rotate([0,0,-channel_guard_degrees/2])
        minkowski() {
            circle(rounded_corners);
            donutSlice(tube_radius+rounded_corners,tube_radius+channel_guard_thickness-rounded_corners,0,channel_guard_degrees);
        }
        
        // Mount brace
        linear_extrude(brace_length/2)
        rotate([0,0,-mount_degrees/2])
        minkowski() {
            circle(rounded_corners);
            donutSlice(tube_radius+rounded_corners,tube_radius+mount_thickness-rounded_corners,0,mount_degrees);
        }
    }
    
    // Cable channel
    linear_extrude(brace_length)
    translate([tube_radius+cable_distance_from_tube,0])
    union() {
        circle(cable_channel_width/2);
        
        translate([0, -cable_channel_width/2])
        square([channel_guard_thickness,cable_channel_width]);
    }
    
    // sister mount brace cavity
    translate([0,0,brace_length/2])
    linear_extrude(brace_length)
    rotate([0,0,-mount_degrees/2])
    minkowski() {
        circle(rounded_corners);
        donutSlice(tube_radius+rounded_corners-1,tube_radius+mount_thickness-rounded_corners,0,mount_degrees);
    }
}

