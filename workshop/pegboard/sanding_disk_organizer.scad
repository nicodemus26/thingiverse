//--------------------------------------------
// Changable

// Pick Sizes for each compartment bottom to top
//compartments = ["320", "220", "180", "120", "80", "40"];
compartments = ["2000", "1500", "1200", "1000", "800", "600"];
// Number of compartments
compartment_count=len(compartments); 
// Disk Size in Inch (tested 5)
disk_diam=5; // In Inches

//--------------------------------------------

mm_per_in=25.4;

wall=1.2;
compartment_height=1*mm_per_in+(wall*2);
backplate_width=((disk_diam+.25)*mm_per_in)+(wall*2);


hang_tab_height=18;
peg_hole_radius=3.3;
peg_hole_distance=2*mm_per_in;

pullout_radius=1.25*mm_per_in;

lable_extrude=.4;

//echo(getsplit("123 456 789", 0)); // ECHO: "789"

module make_peg_holes(cp_h) {
    holeable_space=backplate_width-(wall*2)-(peg_hole_radius*2);
    holes=round(holeable_space/peg_hole_distance-.5);
    side_gap=(holeable_space-(holes*peg_hole_distance))/2+wall+peg_hole_radius;
    echo(holeable_space);
    echo(holes);
    echo(side_gap);
    
    for ( i = [0 : holes] ) {
        translate([side_gap+i*peg_hole_distance,(cp_h+hang_tab_height)-(peg_hole_radius*2),0])
		cylinder(h = wall+.2, r=peg_hole_radius,$fn=20);
    }
}

module make_back_wall(cp_h) {

	
	cube([backplate_width,cp_h+hang_tab_height,wall]);


}

module make_compartment(cpn) {

	translate([0,cpn*(compartment_height-wall),0]) {
	difference() {
		cube([backplate_width,compartment_height,disk_diam*mm_per_in]);
		translate([wall,wall,wall]) {
			cube([backplate_width-(wall*2),compartment_height-(wall*2),(disk_diam*mm_per_in)]);
		}
	

		translate([(backplate_width)/2,0,disk_diam*mm_per_in]) {
			rotate([270,0,0]) {
                hull() {
                    cylinder(h = compartment_height+.1, r=pullout_radius,$fn=56);
                    translate([0,backplate_width-pullout_radius*1.5,0])
                    cylinder(h = compartment_height+.1, r=pullout_radius,$fn=56);
                }
			}
		}
	}
	}



}

module make_text_tabs(shift) {

    translate([shift,0,0]) {
        cube([22,(compartment_count*(compartment_height-wall)),wall]);
    }
    
    
}



    difference() {
    hull() {
        make_back_wall(compartment_count*(compartment_height-wall));
        //make_text_tabs(-4);
        //make_text_tabs(backplate_width);    
    }
        make_peg_holes(compartment_count*(compartment_height-wall));
    }


union() {
    
    for ( i = [0 : compartment_count-1] ) {
        make_compartment(i);
    }
}

union() {
    for ( i = [0 : compartment_count-1] ) {
        do_label(i,0,1);
        translate([lable_extrude/2, 0, -lable_extrude/2])
        do_label(i,0,1);
        
        do_label(i,backplate_width+lable_extrude,-1);
        translate([-lable_extrude/2, 0, -lable_extrude/2])
        do_label(i,backplate_width+lable_extrude,-1);
    }    
}


module do_label(cph,shift,side) {
    align = (side > 0) ? "right" : "left";
    ts=compartment_height/2;
    translate([shift,0,disk_diam*mm_per_in-wall])
    rotate([0,-90*side,0])
    translate([0,cph*(compartment_height-wall),0])    
    linear_extrude(height = lable_extrude, center = false, convexity = 0, twist = 0) 
    translate([0, compartment_height/4]) 
    text(compartments[cph], font = "Liberation Sans",halign=align,size = ts);
}