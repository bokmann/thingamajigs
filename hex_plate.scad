// variables you control

$shape = "prototype"; // "plate" or "dado"
$side_length = 50;
$thickness = 4;
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

function dado_size() = $side_length/4;

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
  
module dado_triangle() {
  cylinder($thickness*2,
           dado_size(),
           dado_size(),
           $fn = 3);
}

module dado_wedge() {
   rotate([0,$dihedral-90,0]) {  
      rotate([0,0,60]) {
        dado_triangle();
      }
   }
}

module half_dado() {
    translate([$inradius,0,0]) {
    intersection() {
      plate();
      translate([-$inradius,0,0]) {
        dado_wedge();
      }
    }
  }
}




// draw the plate for the dodecahedron
 if ($shape == "plate") {
  difference() {
    plate();
   
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
    
    // punch out a butterfly dado
    for(i = [0 : $sides - 1]) {
      rotate([0,0,(360/$sides)*i]) {
        translate([-$inradius,0,0]) {
          dado_wedge();
        }
      }
    }
  }
}
    


// draw the dado wedge to join plates together
if ($shape == "dado") {
    half_dado();
    rotate([180, -($dihedral) ,0]) {
      half_dado();
    }
}

if ($shape == "prototype") {
    difference() {
    plate();
   

    // punch out a butterfly dado
 *   translate([-$inradius,0,0]) {
      dado_wedge();
    }
      rotate([0,0,(360/5)*2]) {
        translate([-$inradius,0,0]) {
          dado_wedge();
        }
    }     
  }
  //attach the  butterflies
  //for(i = [0 : $sides - 1]) {

  rotate([0,0,(360/5)*i]) {
    translate([-$inradius,0,0]) {
      rotate([180, -($dihedral), 0]) {
        scale([.95,.95,.95]) {
        half_dado();}
      }
   // }
  }
  }

}

