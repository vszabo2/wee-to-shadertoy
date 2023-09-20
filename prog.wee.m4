define(`prog_pos', 0)dnl
define(`prog_pos_incr', 1)dnl
define(`prog_pos_wrap_value', 2)dnl
define(`prog_pos_wrap_sub', 3)dnl
define(`prog_pos_new', 4)dnl
define(`prog_mouse_x', 134217728)dnl
define(`prog_mouse_y', 134217729)dnl
define(`prog_key_left', 49766437)dnl
define(`prog_key_up', 49766438)dnl
define(`prog_key_right', 49766439)dnl
define(`prog_key_down', 49766440)dnl
define(`prog_screen_addr', 223488)dnl
define(`prog_screen_cell_size', 3)dnl
define(`prog_screen_line_size', eval(prog_screen_cell_size * 64))dnl
define(`prog_screen_size', eval(prog_screen_line_size * 36))dnl
define(`prog_store_A_to_lit', `dnl
swap
mov $1
store')dnl
define(`prog_store_lit_to_lit', `dnl
mov $2
prog_store_A_to_lit($1)')dnl
define(`prog_load_A_from_lit', `dnl
mov $1
load')dnl
dnl
prog_store_lit_to_lit(prog_pos, prog_screen_addr)
prog_store_lit_to_lit(prog_pos_incr, prog_screen_line_size)
prog_store_lit_to_lit(prog_pos_wrap_value, eval(prog_screen_addr + prog_screen_size))
prog_store_lit_to_lit(prog_pos_wrap_sub, prog_screen_size)
prog_load_A_from_lit(prog_pos_incr)
swap
prog_load_A_from_lit(prog_pos)
add
prog_store_A_to_lit(prog_pos_new)
dnl prog_pos_new is in B now
prog_load_A_from_lit(prog_pos_wrap_value)
swap
setlt
dnl jump to reduce prog_pos_new
jmpz 104
prog_load_A_from_lit(prog_mouse_x)
swap
prog_load_A_from_lit(prog_pos_new)
store
swap
mov 1
add
swap
prog_load_A_from_lit(prog_mouse_y)
swap
store
mov 0
swap
prog_load_A_from_lit(prog_pos)
store
swap
mov 1
add
swap
mov 0
swap
store
prog_load_A_from_lit(prog_pos_new)
prog_store_A_to_lit(prog_pos)
prog_load_A_from_lit(prog_key_left)
jmpz 69
prog_store_lit_to_lit(prog_pos_incr, -prog_screen_cell_size)
mov 0
dnl I didn't think about this...
prog_load_A_from_lit(prog_key_up)
jmpz 80
prog_store_lit_to_lit(prog_pos_incr, prog_screen_line_size)
prog_store_lit_to_lit(prog_pos_wrap_value, eval(prog_screen_addr + prog_screen_size))
prog_load_A_from_lit(prog_key_right)
jmpz 95
prog_store_lit_to_lit(prog_pos_incr, prog_screen_cell_size)
prog_load_A_from_lit(prog_pos)
swap
mov prog_screen_line_size
add
prog_store_A_to_lit(prog_pos_wrap_value)
prog_load_A_from_lit(prog_key_down)
dnl loop: jump to increment
jmpz 16
prog_store_lit_to_lit(prog_pos_incr, -prog_screen_line_size)
dnl I didn't think about this
mov 0
dnl loop: jump to increment
jmpz 16
prog_load_A_from_lit(prog_pos_wrap_sub)
swap
prog_load_A_from_lit(prog_pos_new)
sub
prog_store_A_to_lit(prog_pos_new)
mov 0
jmpz 30
