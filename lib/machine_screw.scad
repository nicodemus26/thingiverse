$fn=36;
$fs=.01;
space_per_hole=5;
holes=10;

difference(){
    cube([space_per_hole*holes,space_per_hole*2,10]);
    
    for (hole = [0:holes-1]) {
        offset = space_per_hole*hole+(space_per_hole/2);
        bore_offset=-.15+hole*.03;
        
        translate([offset,space_per_hole,0])
        cylinder(h=10,d=2+bore_offset);
    }
}