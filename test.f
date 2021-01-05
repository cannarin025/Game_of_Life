: test_word 
    cr
    2 -1 do
        cr
        2 -1 do
            J . ." J counter" cr
            I . ." I counter" cr
            \ I J * . ." I * J counter" cr
            cr
        2 +loop
    2 +loop
;