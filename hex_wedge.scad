
$side_length = 20;

// constant to convert edge length to circumscribed circle radius
$radius = $side_length / 1.175;

// constant to convert edge length to inscribed sphere radius
$height = $side_length * 1.1135;

cylinder(h = $height,
         r1 = $radius,
         r2 = 0,
         $fn = 5);
        
