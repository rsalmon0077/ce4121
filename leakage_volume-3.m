function lv = leakage_volume(t, alpha, level)
%% Introduction
% This function calculates the leakage volume in cubic feet for a given day
% out of White Bear Lake, MN.
%
%% Input Arguments
% * t -- time (in datenum format)
%
% * alpha -- Fitted parameter that will be allowed to be changed by the
% user. A combination of the hydraulic conductivity and area of the lake
% bottom used in Darcy's Law.
%
% * level -- the lake level at the specified time, t.
%
%% Output Arguments
% * lv -- the leakage volume out of the bottom of the lake and into the
% aquifer for a given day specified by t.
%
%% Notes
% This function is part of a set of functions used to model the decreasing
% lake elevation in White Bear Lake, MN.
%
%% Development Team:
% Randal Barnes, Clayton Bayer, Matthew Dalrymple, Curtis Degidio, 
% Anthony Delzotto, Jedidiah Dordal, Zachary Einck, Brian Folta, 
% Noah Kimmes, Derek Lehrke, Jared Mullenbach, Amrish Patel, Laura Robinson, 
% Ryan Salmon, Andrew Stasson
%
% Department of Civil Engineering
% University of Minnesota
% Call excel spreadsheet, convert dates to datenum format and save as a
% matrix as a persistent variable.
%
%% Version
% 04/30/2014
%
%% Code

% Call excel spreadsheet, saving the data as persistent variables.
persistent NUM TXT RAW;
if length(RAW) == 0
    [NUM, TXT, RAW] = xlsread('well_62044.xlsx','DATA','B2:C15569');
end

% Change well dates from excel spreadsheet into datenum format. 
well(:,1) = datenum(RAW(:,1));
depth_to_water = NUM(:,1);
% Add depth to water to well ground level elevation to get water elevation
% in well.
well(:,2) = depth_to_water + 930.15;

% If t is in the spreadsheet, find corresponding water table elevation and
% perform calculation to find lv.
if any(t == well(:,1));
    [row,col] = find(t == well(:,1),1,'first');
    well_elevation = well(row,2);
    lv = alpha*(level - well_elevation);
    
    % If t is out of the date range of the spreadsheet, return lv = nan.
elseif t > datenum('31-Dec-2013') || t < datenum('1-Jan-1996');
    lv = nan;
    
    % If t is not in the spreadsheet, but is inbetween start date and end
    % date of spreadsheet, interpolate between two closest dates
    % corresponding water table elevations to find a water table elevation
    % for t and then perform calculation to find lv.
else any(t ~= well(:,1));
    [row_a,col_a] = find(t > well(:,1),1,'first');
    [row_b,col_b] = find(t < well(:,1),1,'first');
    well_elevation = interp1([well(row_b,1),well(row_a,1)],[well(row_b,2),well(row_a,2)],t);
    lv = alpha*(level - well_elevation);
end
