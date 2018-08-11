//--------------------------------------------
// Changable

// Pick Sizes for each compartment bottom to top
//SIZES = ["320", "220", "180", "120", "80", "40"];
SIZES = ["2000", "1500", "1200", "1000", "800", "600"];
// Number of compartments
NO_COMPARTMENTS=len(SIZES); 
// Disk Size in Inch (tested 5)
DISK_SIZE=5; // In Inches

//--------------------------------------------

CONV=25.4;

THICKNESS=1.2;
COMPARTMENT_H=1*CONV+(THICKNESS*2);
BACKPLATE_W=((DISK_SIZE+.25)*CONV)+(THICKNESS*2);


HANG_TAB=18;
HOLE_RADIUS=3.3;
HOLE_DISTANCE=2*CONV;

PULLOUT_RADIUS=1.25*CONV;

LABEL_EXTRUDE=.4;

//echo(getsplit("123 456 789", 0)); // ECHO: "789"

module make_peg_holes(cp_h) {
    holeable_space=BACKPLATE_W-(THICKNESS*2)-(HOLE_RADIUS*2);
    holes=round(holeable_space/HOLE_DISTANCE-.5);
    side_gap=(holeable_space-(holes*HOLE_DISTANCE))/2+THICKNESS+HOLE_RADIUS;
    echo(holeable_space);
    echo(holes);
    echo(side_gap);
    
    for ( i = [0 : holes] ) {
        translate([side_gap+i*HOLE_DISTANCE,(cp_h+HANG_TAB)-(HOLE_RADIUS*2),0])
		cylinder(h = THICKNESS+.2, r=HOLE_RADIUS,$fn=20);
    }
}

module make_back_wall(cp_h) {

	
	cube([BACKPLATE_W,cp_h+HANG_TAB,THICKNESS]);


}

module make_compartment(cpn) {

	translate([0,cpn*(COMPARTMENT_H-THICKNESS),0]) {
	difference() {
		cube([BACKPLATE_W,COMPARTMENT_H,DISK_SIZE*CONV]);
		translate([THICKNESS,THICKNESS,THICKNESS]) {
			cube([BACKPLATE_W-(THICKNESS*2),COMPARTMENT_H-(THICKNESS*2),(DISK_SIZE*CONV)]);
		}
	

		translate([(BACKPLATE_W)/2,0,DISK_SIZE*CONV]) {
			rotate([270,0,0]) {
                hull() {
                    cylinder(h = COMPARTMENT_H+.1, r=PULLOUT_RADIUS,$fn=56);
                    translate([0,BACKPLATE_W-PULLOUT_RADIUS*1.5,0])
                    cylinder(h = COMPARTMENT_H+.1, r=PULLOUT_RADIUS,$fn=56);
                }
			}
		}
	}
	}



}

module make_text_tabs(shift) {

    translate([shift,0,0]) {
        cube([22,(NO_COMPARTMENTS*(COMPARTMENT_H-THICKNESS)),THICKNESS]);
    }
    
    
}



    difference() {
    hull() {
        make_back_wall(NO_COMPARTMENTS*(COMPARTMENT_H-THICKNESS));
        //make_text_tabs(-4);
        //make_text_tabs(BACKPLATE_W);    
    }
        make_peg_holes(NO_COMPARTMENTS*(COMPARTMENT_H-THICKNESS));
    }


union() {
    
    for ( i = [0 : NO_COMPARTMENTS-1] ) {
        make_compartment(i);
    }
}

union() {
    for ( i = [0 : NO_COMPARTMENTS-1] ) {
        do_label(i,0,1);
        translate([LABEL_EXTRUDE/2, 0, -LABEL_EXTRUDE/2])
        do_label(i,0,1);
        
        do_label(i,BACKPLATE_W+LABEL_EXTRUDE,-1);
        translate([-LABEL_EXTRUDE/2, 0, -LABEL_EXTRUDE/2])
        do_label(i,BACKPLATE_W+LABEL_EXTRUDE,-1);
    }    
}


module do_label(cph,shift,side) {
    align = (side > 0) ? "right" : "left";
    ts=COMPARTMENT_H/2;
    translate([shift,0,DISK_SIZE*CONV-THICKNESS])
    rotate([0,-90*side,0])
    translate([0,cph*(COMPARTMENT_H-THICKNESS),0])    
    linear_extrude(height = LABEL_EXTRUDE, center = false, convexity = 0, twist = 0) 
    translate([0, COMPARTMENT_H/4]) 
    text(SIZES[cph], font = "Liberation Sans",halign=align,size = ts);
}