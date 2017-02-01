module rgb_led() {
  sphere(d=8);
  cylinder(5,4,4);
  translate([0,0,5]) {
    cylinder(2,9.25/2,9.25/2);
  }
}

rgb_led();