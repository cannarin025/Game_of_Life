{ ---------------------File containing words required to play a game of life---------------------- }

: Show                                { Update bmp and display to match changes in conway_array}
  bmp-address @ Update_BMP            { Copy conway_array as BMP                        }
  bmp-address @ bmp-to-screen-stretch { Stretch .bmp to display window                  }
;

: init_life                           { Create life window with variable pixel size}
  clear_stack
  ." Creating life stretch BMP window"
  0 iteration !
  New-bmp-Window-stretch
  bmp-window-handle !
  reset_array
  Show
;

: play_life                           { Draw bmp to screen at variable pixel size       }
  clear_stack
  Make_Sim_File
  cr ." Starting simulation " 
  cr
  0 iteration !
  0 total_alive_last !
  begin                               { Begin update / display loop                     }
  Show
  iteration_delay ms                  { Delay for viewing ease, reduce for higher speed }
  \ reset_rule_cells                    { resets so current values don't impact next      }
  \ fill_rule_cells                     { gets new random cells to apply rules to         }
  update_game_unwrapped               { Run next iteration of life                      }
  Write_Sim_Data
  key?                                { Break test loop on key press                    }
  until
  End_Sim_File 
  cr ." Done! "
  ;

: play_life_wrapped
  clear_stack
  Make_Sim_File
  cr ." Starting simulation " 
  cr
  0 iteration !
  0 total_alive_last !
  begin                               { Begin update / display loop                     }
  Show
  iteration_delay ms                  { Delay for viewing ease, reduce for higher speed }
  \ reset_rule_cells                    { resets so current values don't impact next      }
  \ fill_rule_cells                     { gets new random cells to apply rules to         }
  update_game_wrapped                 { Run next iteration of life                      }
  Write_Sim_Data
  key?                                { Break test loop on key press                    }
  until 
  End_Sim_File
  cr ." Done! " 
;

: run_test
  clear_stack
  Make_Sim_File
  cr ." Starting simulation " 
  cr
  0 iteration !
  0 total_alive_last !
  begin                               { Begin update / display loop                     }
  Show
  iteration_delay ms                  { Delay for viewing ease, reduce for higher speed }
  \ reset_rule_cells                    { resets so current values don't impact next      }
  \ fill_rule_cells                     { gets new random cells to apply rules to         }
  update_game_wrapped                 { Run next iteration of life                      }
  Write_Sim_Data
  key?                                { Break loop on key press                         }
  iteration @ max_iterations @ >=       { Break loop if max_iterations has been reached   }
  or
  until 
  End_Sim_File
  cr ." Done! " 
  iteration @ max_iterations @ >=
  if
  cr ." Max iterations reached!"
  cr
  then
;