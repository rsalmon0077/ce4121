function [e] = lake_level( V )
% Finds volume of White Bear Lake as a function of the lake level.
% e -- lake level [ft above mean sea level (MSL 1912)]
% V -- volume of lake [ft^3]
%----------------------------------------------------------------------------

% datum is the average of all the lake level readings taken in May 1978,
% which is when the lake map data was taken.
datum = 922.92;

% d -- depths that contours were created for.
d = [0;5;10;15;20;30;40;50;60;70;80;83];

% v -- volumes of water in each depth range.
v = [473344125;368832572.5;276943165;211631932.5;293936080;152821320;57601460;23911575;13434575;5904005;1055810;0];
v_cumulative = flip(cumsum(flip(v)));

% depth -- ft below water surface (at avg. May 1978 level)
if V > max(v_cumulative)
    depth = interp1(v_cumulative,d,V,'linear','extrap');
else
    depth = interp1(v_cumulative,d,V);
end

e = datum - depth;
end