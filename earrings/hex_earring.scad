$fn=36;
module spokes(loops=36,angle=360,length=100,width=3,inner_radius=15) {
    difference(){
        minkowski(){
            union(){
                for (i = [0: loops]) {
                    rotate([0,0,i*(angle/loops)])
                    translate([inner_radius,-(width/6),0])
                    square(size=[length,width/3]);
                }
                circle(inner_radius+(width/2));
            };
            circle(width/3,$fn=36);
        }
        circle(inner_radius,$fn=36);
    }
};
module engrave(){
    difference(){
        difference() {
            union(){
                for (i = [0:6]) {
                    rotate([0,0,i*60])
                    translate([115,0,0])
                    rotate([0,0,120])
                    difference(){
                        spokes(loops=10,angle=120,length=200,width=3);
                    }
                };
                circle(34);
            }
            for (i = [0:6]) {
                rotate([0,0,i*60])
                translate([115,0,0])
                circle(15);
            };
        };
        union(){
            circle(30);
            for (i = [0:6]) {
                rotate([0,0,60*i+30])
                translate([100,-200])
                square([200,400]);
            };
        }
    };
};
module cut(){
    translate([118,0,0]) 
    difference(){
        circle(25);
        circle(15);
    };
    offset(r=3)
    engrave();
};

color("red")
scale([0.2,0.2,1])
cut();
color("green")
scale([0.2,0.2,1])
engrave();
