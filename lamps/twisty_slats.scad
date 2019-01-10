$fn=60;
slats=36;

lamp_inner_radius=35;

slat_groove_thickness=.5;
slat_groove_radius=20;
slat_insert_width=.25*3.1415*slat_groove_radius;
slat_length=100;
slat_disk_thickness=25.4/8;

module slat_disc() {
    difference(){
        circle(r=50);
        for (i=[0:slats-1]) {
            rotate([0,0,i*360/slats])
            translate([38.5,0])
            rotate([0,0,-45])
            slat_groove();
        }
        circle(r=lamp_inner_radius);
    }
}

module slat_groove() {
    rotate([0,0,90])
    translate([-(slat_groove_radius-slat_groove_thickness*0.5),0])
    union(){
        rotate([0,0,-45])
        translate([slat_groove_radius-slat_groove_thickness*0.5,0])
        circle(r=slat_groove_thickness/2);
        translate([slat_groove_radius-slat_groove_thickness*0.5,0])
        circle(r=slat_groove_thickness/2);
        difference(){
            circle(r=slat_groove_radius);
            circle(r=slat_groove_radius-slat_groove_thickness);
            translate([-slat_groove_radius,0])
            square([slat_groove_radius*2,slat_groove_radius]);
            rotate([0,0,135])
            translate([-slat_groove_radius,0])
            square([slat_groove_radius*2,slat_groove_radius]);
        }
    }
}

//slat_disc();
linear_extrude(slat_length-slat_disk_thickness/2,twist=180)
difference(){
    union(){
        square([100,100], center=true);
        for(i=[0:3]) {
            rotate([0,0,i*90])
            translate([50,0])
            circle(r=20);
        }
    }
    circle(r=lamp_inner_radius);
}