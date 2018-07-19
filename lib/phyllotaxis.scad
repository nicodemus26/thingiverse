// Adapted from work by Eric Buijs at https://www.youtube.com/watch?v=FOuHWXN8g2s

/* Phyllotaxis is a term used for the patterns that emerge in the growth of plants. Spiral phyllotaxis is observed in the heads of sunflowers, in pine-cones and pineapples, and in a variety of other plants.

In the script below Vogel's formula is used to describe a pattern of seeds in a plane (a=n*137.5 and r=c*sqrt(n))

A general articles on Phyllotaxis can be found here
https://en.wikipedia.org/wiki/Phyllotaxis
http://algorithmicbotany.org/papers/abop/abop-ch4.pdf

For the relation between Phyllotaxis and the Fibonacci sequence watch this YouTube video
https://www.youtube.com/watch?v=_GkxCIW46to&t=210s

Approaches to generate these patterns can be found in these links
http://www.mathrecreation.com/2008/09/phyllotaxis-spirals.html
https://maxwelldemon.com/2012/03/18/prime-phyllotaxis-spirals/
http://www.algorithmicbotany.org/papers/abop/abop-ch4.pdf
https://www.youtube.com/watch?v=KWoJgHFYWxY (Daniel Schiffman)
*/

$fn=36;
//c determines the radius of the phyllotaxis pattern (scale)
c = 4;
//pi is, well you know what pi is.
pi = 3.1418;

//min_r is the minimum distance from the center to make holes.
min_r=20;

/* Variables */

//max_seeds is an integer that contains the maximum number of seeds
max_seeds = 400; //[400:2000]

//seed_diameter determines the diameter of the seed. The higher the seed_diameter the smaller the diameter of the seed
seed_diameter = 3.7; //[3:8]

//fibonacci is a number that highlights different spirals with a secundary color
fibonacci = 2;//[2,3,5,8,13,21,34,55,89,144]

//different angles to choose from. 137.5 however is the 'golden angle'
golden_angle = 137.5; //[137.3, 137.5, 137.6]

/* Modules */ 
module phyllotaxis (max_seeds, seed_diameter, fibonnaci=2, golden_angle=137.5, min_r=20) {
    for (n = [1:max_seeds]) {
        //Vogel's formula
        theta = n *golden_angle;
        r = c * sqrt(n);
        //end Vogel's formula
        x = r * cos(theta);
        y = r * sin(theta);
        cyl_radius = sqrt(r)/seed_diameter;
        //cyl_radius = 10 * sqrt(1/r);
        if (sqrt((x*x)+(y*y)) >= min_r) {
            if (n % fibonacci == 0) {
                translate([x,y]) circle(r=cyl_radius+0.3);
            }
            else {
                translate([x,y]) circle(r=cyl_radius);
            }
        }
    }
}

/* MAIN */
//make it 3d printable
module phyllotaxis_body (max_seeds, seed_diameter, fibonnaci=2, golden_angle=137.5, min_r=20) {
    difference() {
        //diameter of the cylinder scales with the number of seeds.
        union() {
            circle(r=(seed_diameter/2)+min_r);
            offset(r=seed_diameter*1.5) {
                phyllotaxis(max_seeds, seed_diameter, fibonacci, golden_angle, min_r);
            }
        }
        phyllotaxis(max_seeds, seed_diameter, fibonacci, golden_angle, min_r);
    }
}

//phyllotaxis_body(max_seeds, seed_diameter);