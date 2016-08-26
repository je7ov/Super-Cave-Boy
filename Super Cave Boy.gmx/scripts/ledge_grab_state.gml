///legde_grab_state()
var key_up = keyboard_check(vk_up);
var key_down = keyboard_check(vk_down);
hspd = 0;
vspd = 0;

if(key_down) {
    state = move_state;
}

if(key_up) {
    state = move_state;
    vspd = -jump;
}
