
$side_length = 96;

$radius = $side_length / 1.175;
$inradius = $side_length / (2*tan(36));

$thickness = 10;
$thinness = 1;

$temp_height = $side_length * 1.1135;

module led() {
  sphere(d=8);
  cylinder(5,4,4);
  translate([0,0,5]) {
    cylinder(2,9.25/2,9.25/2);
  }
}

    difference() {
    //create the hexagon
            cylinder(h = $temp_height,
               r1 = $radius,
               r2 = 0,
               $fn = 5);
        
      translate([0,0,$thickness]) {
        cylinder(h = $temp_height,
        r1 = $radius,
        r2 = 0,
        $fn = 5);
      }    
    
  //punch out the center led
  translate([0,0,5 + $thinness]) {
    led();
  }
  
  // punch out the 5 ledsaround the edge.
  rotate([0,0,-18]) {
    for(i = [0 : 4]) {
      rotate([0,0,(360/5)*i]) {
        translate([0,$radius*0.66,5 + $thinness]) {
          led();
        }
      }
    }
  }
  
  // punch out a butterfly dado
    $dado_length = $side_length/5;
    translate([-$inradius,0,-1]) {
      rotate([0,0,60]) {
        cylinder(h = $thickness+2,
        r1 = $dado_length,
        r2 = $dado_length,
        $fn = 3);
    }
  }
}
