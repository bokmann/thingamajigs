// variables you control

$shape = "prototype"; // "plate" or "dado"
$side_length = 30;
$thickness = 2;
$leds = 0;


// things to change only if you're changing the code
$radius = $side_length / 1.175;
$sides = 5;
$inradius = $side_length / (2*tan(36));
$dihedral = 116.56;
$rgb_led_dimension = 8.5;
$led_delta = .5;


$cone_height = $side_length * 1.1135;

module rgb_led(body_diameter) {
  sphere(d=body_diameter);
  cylinder(5.5,body_diameter/2,body_diameter/2);
  translate([0,0,5]) {
    cylinder(2,9.5/2,(body_diameter+1)/2);
  }
}


module plate() {
  difference() {
      cylinder(h = $cone_height,
               r1 = $radius,
               r2 = 0,
               $fn = $sides);
        
      translate([0,0,$thickness]) {
        cylinder(h = $cone_height,
        r1 = $radius,
        r2 = 0,
        $fn = $sides);
      }    
      
  }
}
  

    

if ($shape == "prototype") {
    
    translate([0,$inradius*4],0) plate();
    
    
    plate();
   
    for(i = [0 : $sides - 1]) {
      rotate([0,0,(360/5)*i])
        translate([-$inradius,0,0])
          rotate([0, 180-($dihedral), 0])
            translate([-$inradius,0,0])
              rotate([0,0,180])
                plate();
    }
    
    translate([0,0,$inradius*3.14+ $thickness]) {
    rotate([0,180,0]) {
    for(i = [0 : $sides - 1]) {
      rotate([0,0,(360/5)*i])
        translate([-$inradius,0,0])
          rotate([0, 180-($dihedral), 0])
            translate([-$inradius,0,0])
              rotate([0,0,180])
                plate();
    }}}
    
    
    if ($leds == 1) {
    //punch out the center led
    translate([0,0,$rgb_led_dimension/2]) {
      rgb_led($rgb_led_dimension-$led_delta);
    }
    
    // punch out the 5 ledsaround the edge.
    rotate([0,0,-18]) {
      for(i = [0 : $sides - 1]) {
        rotate([0,0,(360/5)*i]) {
          translate([0,$radius*0.66,$rgb_led_dimension/2]) {
            rgb_led($rgb_led_dimension-$led_delta);
          }
        }
      }
    }
  }
}