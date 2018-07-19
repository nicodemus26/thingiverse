$fn=36;
$fs=.01;
block_height=5;
space_per_hole=8;
holes=11;
font = "Monsterrat";

bore_min=3.8;
bore_max=4.2;
bore_step=(bore_max-bore_min)/(holes-1);

difference(){
    cube([space_per_hole*(holes+1),space_per_hole*1.5,block_height]);
    
    for (hole = [0:holes-1]) {
        offset = space_per_hole*hole+space_per_hole;
        bore=bore_min+hole*bore_step;
        echo(bore);
        translate([offset,space_per_hole*.75,0])
        cylinder(h=block_height,d=bore);
    }
}

translate([0,-space_per_hole*1.5,0])
cube([space_per_hole*(holes+1),space_per_hole*1.5,1]);

translate([0,-space_per_hole*.1,1])
linear_extrude(height = .5) {
    placement = [
        [bore_min, "left", 0],
        [bore_step, "center", (space_per_hole*(holes+1))/2],
        [bore_max, "right", (space_per_hole*(holes+1))]
    ];
    for (p = placement) {
        translate([p[2],0,0])
        text(text = str(p[0]), font = font, size = space_per_hole*1.2, valign = "top", halign=p[1]);
    }
}