///create_light(x, y, radius)

global.light_x_array[global.num_lights] = argument0;
global.light_y_array[global.num_lights] = argument1;
global.light_rad_array[global.num_lights] = argument2;

global.num_lights++;

return global.num_lights - 1;

