
$radius = 77;
$radius_delta = 7;
$thickness = 10;
$thinness = 1;

// the big rgb leds are diameter 10.
// this is roughly their shape.
module led() {
  sphere(5);
  cylinder($thickness + 1,5,5);
}

// 18 degrees is (90-(360/5)) and aligns the hex
// to drop the leds in correctly.
rotate([0,0,-18]) {
    difference() {
    //create the hexagon
    rotate([0,0,18]) {
      cylinder(h = $thickness,
               r1 = $radius,
               r2 = $radius - $radius_delta,
               $fn = 5);
    }

  //punch out the center led
  translate([0,0,5 + $thinness]) {
    led();
  }
  
  // punch out the 5 ledsaround the edge.
  for(i = [0 : 4]) {
    rotate([0,0,(360/5)*i]) {
      translate([0,$radius*0.66,5 + $thinness]) {
        led();
      }
    }
  }
}
}