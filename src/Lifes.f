Include src/Rnd.f

{ shapes}

{ still lifes}
: box \ box shape with bottom left corner at x,y
    1 pick 1 pick live
    1 pick 1 pick 1 + live
    1 pick 1 + 1 pick live
    1 pick 1 + 1 pick 1 + live
    drop drop

;

: boat \ still life with bottom left corner at x,y
    1 pick 1 + 1 pick live
    1 pick 1 pick 1 + live
    1 pick 1 pick 2 + live
    1 pick 2 + 1 pick 1 + live
    1 pick 1 + 1 pick 2 + live
    drop drop

;

{ non-still lifes}
: bar
    1 pick 1 pick live
    1 pick 1 + 1 pick live
    1 pick 2 + 1 pick live
    drop drop
;

: lwss \ lightweight spaceship, bottom left corner @ x,y
    1 pick 1 pick live
    1 pick 3 + 1 pick live
    1 pick 1 pick 2 + live
    1 pick 1 + 1 pick 3 + live
    1 pick 2 + 1 pick 3 + live
    1 pick 3 + 1 pick 3 + live
    1 pick 4 + 1 pick 3 + live
    1 pick 4 + 1 pick 2 + live
    1 pick 4 + 1 pick 1 + live
    drop drop
; 

: R-Pentomino
    1 pick 1 + 1 pick live
    1 pick 1 pick 1 + live
    1 pick 1 + 1 pick 1 + live
    1 pick 1 + 1 pick 2 + live
    1 pick 2 + 1 pick 2 + live
    drop drop 
;

{ random lifes}

: Random-Spawn \ n Random-Spawn, creates n cells at random locations between array_x_size and array_y_size
    0 do
       alive_num @ array_x_dim 1 - RND array_y_dim 1 - RND array_!
    loop
;

: Percent-Full \ n Percent-Full, randomly fills grid to n% capacity at random positions
    array_size * 100 / 0
    do
        alive_num @ array_x_dim 1 - RND array_y_dim 1 - RND array_!
    loop
;