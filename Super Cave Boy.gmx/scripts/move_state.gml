///move_state()
var key_right = keyboard_check(vk_right);
var key_up = keyboard_check(vk_up);
var key_up_release = keyboard_check_released(vk_up);
var key_left = keyboard_check(vk_left);
var key_down = keyboard_check(vk_down);

// Check if player is on the ground
if(!place_meeting(x, y + 1, Solid)) {
     sprite_index = spr_player_jump;
     image_speed = 0;
     image_index = (vspd > 0);
     
     vspd += grav;
     if(vspd > grav_max) {
        vspd = grav_max;
     }
     
     // Control jump height on key release
     if(key_up_release && vspd < -jump_cut_off ) {
         vspd = -jump_cut_off;
     }
} else {
    if(hspd == 0) {
        sprite_index = spr_player_idle;
    } else {
        sprite_index = spr_player_walk;
        image_speed = 24 / room_speed * delta;
    }
    vspd = 0;
    
// Jump
    if(key_up) {
        vspd = -jump;
    }
}

if(key_right || key_left) {
    // Accelerate player
    hspd += (key_right - key_left) * acc * delta;
    hspd_dir = key_right - key_left;
    // Cap speed
    if(hspd > spd) hspd = spd;
    if(hspd < -spd) hspd = -spd;
} else {
    apply_friction(acc);
}

if(hspd != 0) {
    image_xscale = sign(hspd);
}

move(Solid);

// Check for ledge grab state
var falling = y - yprevious > 0;
var wasnt_wall = !position_meeting(x + (17 * image_xscale), yprevious, Solid);
var is_wall = position_meeting(x + (17 * image_xscale), y, Solid);

if( falling && wasnt_wall && is_wall) {
    while(!place_meeting(x + image_xscale, y, Solid)) {
        x += image_xscale;
    }
    
    while(position_meeting(x + (17 * image_xscale), y - 1, Solid)) {
        y -= 1;
    }
    
    sprite_index = spr_player_ledge_grab;
    state = ledge_grab_state;
}

