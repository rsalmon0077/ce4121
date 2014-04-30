function [la] = lake_area( e )
% Finds surface area of White Bear Lake as a function of the lake level.
% e -- lake level [ft above mean sea level (MSL 1912)]
% la -- surface area [sq ft]
%----------------------------------------------------------------------------

% datum is the average of all the lake level readings taken in May 1978,
% which is when the lake map data was taken.
datum = 922.92;
depth = datum - e;

% d -- depths that contours were created for.
d = [0;5;10;15;20;30;40;50;60;70;80;83];

% a -- surface areas of each contour.
a = [104607319;84730331;62802698;47974568;36678205;22109011;8455253;3065039;1717276;969639;211162;0];

if e > datum
    la = interp1(d,a,depth,'linear','extrap');
else
    la = interp1(d,a,depth);
end

end