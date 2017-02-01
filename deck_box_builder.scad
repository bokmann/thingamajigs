 decks = 5;
 thickness = 3;
 deck_size = [68,19,60];
 
 difference() {
     cube([(deck_size[0]+(2*thickness)),
           (deck_size[1] * decks) + ((thickness * (decks + 1))),
           deck_size[2]]);
     
     for(i = [0 : decks - 1]) {
       translate([thickness,
                 ((thickness+deck_size[1]) * i + thickness),
                 thickness]) {
         cube(deck_size);
       }
     }
 }
 