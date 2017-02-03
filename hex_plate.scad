$shape = "dado"; // "plate" or "dado"
$side_length = 90;



$radius = $side_length / 1.175;
$inradius = $side_length / (2*tan(36));

$thickness = 10;
$thinness = 1;

$temp_height = $side_length * 1.1135;

module rgb_led(body_diameter) {
  sphere(d=body_diameter);
  cylinder(5.5,body_diameter/2,body_diameter/2);
  translate([0,0,5]) {
    cylinder(2,9.5/2,(body_diameter+1)/2);
  }
}

function dado_size() = $side_length/4;

module hex_plate() {
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
      
  }
  }
  
module dado_triangle() {
  cylinder($thickness*2,
           dado_size(),
           dado_size(),
           $fn = 3);

}

module dado_wedge() {
    rotate([0,115.86-90,0]) {  
            rotate([0,0,60]) {
              dado_triangle();
            }
          }
      }

module dado_chunk() {
  difference() {
    half_dado();
  //  rotate([0,(115.56*2)-180,0]) {
      
//      translate([-$inradius/2,-$inradius/2,$thickness+2]) {
//        cube($inradius);
//      }

      translate([0,-$inradius/2,-$inradius/2]) {
        cube($inradius);
      }
      
//  }
  }  
}








 if ($shape == "plate") {
    difference() {

    hex_plate();
    
    //punch out the center led
    translate([0,0,5 + $thinness]) {
      rgb_led(8.5);
    }
  
    // punch out the 5 ledsaround the edge.
    rotate([0,0,-18]) {
      for(i = [0 : 4]) {
        rotate([0,0,(360/5)*i]) {
          translate([0,$radius*0.66,5 + $thinness]) {
            rgb_led(8.5);
          }
        }
      }
    }
    
    // punch out a butterfly dado
    for(i = [0 : 4]) {
      rotate([0,0,(360/5)*i]) {
        translate([-$inradius,0,-1]) {
          dado_wedge();
        }
      }
    }
  }
}
    

module half_dado() {
    // why 0.65?
    translate([$inradius+0.65,0,1]) {
    intersection() {
      hex_plate();
      translate([-$inradius,0,-1]) {
        dado_wedge();
      }
    }
  }}


if ($shape == "dado") {
  rotate([0,-(180-116.56)/2,0]) {
    half_dado();
  }
  
  rotate([0,(180-116.56)/2,0]) {
    rotate([0,0,180]) {
        half_dado();
    }
  }
}