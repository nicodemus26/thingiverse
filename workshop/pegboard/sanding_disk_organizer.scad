//--------------------------------------------
// Changable

// Number of compartments
NO_COMPARTMENTS=6; 
// Pick Sizes for each compartment bottom to top
SIZE = "600 320 220 180 120 80";
// Disk Size in Inch (tested 2
DISK_SIZE=2; // In Inches

//--------------------------------------------

CONV=25.4;

THICKNESS=2;
COMPARTMENT_H=13+(THICKNESS*2);
DISK_SIZE=2;
//BACKPLATE_H=20;
BACKPLATE_W=(DISK_SIZE*CONV)+(.25*CONV);
NO_COMPARTMENTS=6; //6


HANG_TAB=18;
HOLE_RADIUS=3.3;

PULLOUT_RADIUS=15;





TXT_H_SPACE=4;

//echo(getsplit("123 456 789", 0)); // ECHO: "789"

module make_peg_holes(cp_h) {
    
	translate([((BACKPLATE_W)/2)+(CONV),(cp_h+HANG_TAB)-(HOLE_RADIUS*2),0]) {
		cylinder(h = THICKNESS+.1, r=HOLE_RADIUS,$fn=20);
	}
	translate([((BACKPLATE_W)/2)-(CONV),(cp_h+HANG_TAB)-(HOLE_RADIUS*2),0]) {
		cylinder(h = THICKNESS+.1, r=HOLE_RADIUS,$fn=20);
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
				cylinder(h = COMPARTMENT_H+.1, r=PULLOUT_RADIUS,$fn=56);
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
        make_text_tabs(-22);
        make_text_tabs(BACKPLATE_W);    
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
        do_label(i,"80",-23);
        do_label(i,"80",BACKPLATE_W-2);
    }    
}


module do_label(cph,txt,shift) {
    
    ts=8;
    
    translate([shift,0,0]) {

    
    translate([0,cph*(COMPARTMENT_H-THICKNESS),2]) {    
        linear_extrude(height = 2, center = false, convexity = 10, twist = 0) {
             translate([TXT_H_SPACE, 4]) {
                 
                //text(SIZES[cph], font = "Liberation Sans",halign="left",size = ts);
                 text(getsplit(SIZE, cph), font = "Liberation Sans",halign="left",size = ts);


                 
                 
               
             }
        }
    }
    }
}



function getsplit(text, index=0, car=" ") = get_index(text, index, car) == len(text)+1 ? undef : substr(text, get_index(text, index, car), get_index(text, index+1, car) - get_index(text, index, car) - len(car));
function get_index(text, word_number, car) = word_number == 0 ? 0 : search(car, text, len(text))[0][word_number-1] == undef ? len(text)+len(car) : len(car) + search(car, text, len(text))[0][word_number-1];
function substr(data, i, length=0) = (length == 0) ? _substr(data, i, len(data)) : _substr(data, i, length+i);
function _substr(str, i, j, out="") = (i==j) ? out : str(str[i], _substr(str, i+1, j, out));
