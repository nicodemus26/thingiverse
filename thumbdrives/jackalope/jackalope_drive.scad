
//union() {
//   
//    scale([0.5,0.5,0.5])
//    import("jackalope_head_cap.stl");
//
//    cube([35, 17, 2], center=true);
//}

// Thumbdrive base
!difference() {
cube([35, 17, 5.6]);
translate([0,0,1])
linear_extrude(4.6)
scale([35.5/35, 1, 1])
translate([-16.80, 17,0])
rotate([180,0,0])
polygon([
[16.80, 15.00],
[20.70, 15.00],
[20.70, 15.50],
[22.28, 15.47],
[22.60, 14.28],
[22.81, 14.20],
[24.22, 14.16],
[24.44, 14.47],
[24.08, 14.88],
[24.12, 15.66],
[48.71, 15.66],
[49.50, 14.99],
[50.22, 14.96],
[50.23, 12.46],
[47.55, 12.14],
[47.55, 4.93],
[50.16, 4.89],
[50.16, 2.27],
[49.25, 2.16],
[48.47, 1.32],
[23.97, 1.44],
[24.00, 2.61],
[24.33, 2.88],
[24.36, 3.17],
[22.50, 3.25],
[22.46, 2.28],
[21.87, 1.56],
[20.80, 1.60],
[20.68, 2.45],
[16.80, 2.32]
]);
}