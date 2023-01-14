function [colormap_type] = color_type(v)
% Colormap
% v: a vector of labels

color_1=[0.69,0.19,0.38];
color_2=[1.00,0.89,0.52];
color_3=[0.25,0.41,0.88];
color_4=[0.63,0.32,0.18];
color_5=[0.92,0.56,0.33];
color_6=[0.50,0.54,0.53];
color_7=[0.53,0.81,0.92];
color_8=[0.63,0.40,0.83];
color_9=[0.74,0.56,0.56];
color_10=[1.00,0.50,0.31];
color_11=[0.13,0.55,0.13];

color_map_RGB=[color_1;color_2;color_3;color_4;color_5;color_6;color_7;color_8;color_9;color_10;color_11];
colormap_type=color_map_RGB(unique(v),:);

end

