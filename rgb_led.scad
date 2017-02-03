
module rgb_led(body_diameter) {
  sphere(d=body_diameter);
  cylinder(5.5,body_diameter/2,body_diameter/2);
  translate([0,0,5]) {
    cylinder(2,9.5/2,(body_diameter+1)/2);
  }
}

rgb_led(8.5);