%% Hilary Palevsky 11/17/2022
% Code will produce figures in Chapter 4 of OOI BGC Sensor Best Practices
% CSV files are in shared google drive. 
% https://drive.google.com/drive/u/0/folders/1kL_F7oWQ6wk_rl0UStI4ljkFYcYj0zuE
addpath('C:\Users\palevsky\Desktop\carbonate')

%% General plotting stuff from Kristen

blue = [0     0.44706     0.74118];
red = [0.85098     0.32549    0.098039];
yellow = [0.92941     0.69412     0.12549];
purple = [0.49412     0.18431     0.55686];
green = [0.46667     0.67451     0.18824];
cyan = [0.30196      0.7451     0.93333];
maroon = [0.63529    0.078431     0.18431];
grey = [0.5 0.5 0.5];
lightcyan = [0.67843 0.92157 1];
brightpurple = [0.74902           0     0.74902];
forestgreen = [0     0.49804           0];
teal = [0     0.74902     0.74902];
navy = [0.078431     0.16863     0.54902];

%% Worked Example figure

pco2w_sensor = readtable('Figure_4-5_data.csv','TextType','string');
bottle_data = readtable('Figure_4-5_bottle_data.csv','TextType','string');

%Calculate correction
T1 = nanmean(datetime(bottle_data.CTDBottleClosureTime_UTC_(1:2)));
T2 = nanmean(datetime(bottle_data.CTDBottleClosureTime_UTC_(3:4)));
ind_T1 = find(pco2w_sensor.time < T1+0.25);
ind_T2 = find(pco2w_sensor.time > T2-0.5);
sensor_T1 = nanmean(pco2w_sensor.partial_pressure_of_carbon_dioxide_in_sea_water(ind_T1));
sensor_T2 = nanmean(pco2w_sensor.partial_pressure_of_carbon_dioxide_in_sea_water(ind_T2));
bottle_T1 = nanmean(bottle_data.CalculatedPCO2_uatm_(1:2));
bottle_T2 = nanmean(bottle_data.CalculatedPCO2_uatm_(3:4));
slope = [(bottle_T2-sensor_T2) - (bottle_T1-sensor_T1)]./ datenum((T2-T1));

correction = (bottle_T1-sensor_T1) + datenum((pco2w_sensor.time - T1))*slope;

figure
plot(pco2w_sensor.time, pco2w_sensor.partial_pressure_of_carbon_dioxide_in_sea_water + pco2w_sensor.pCO2_weekly_std,'Color',lightcyan,'Linewidth',1); hold on;
plot(pco2w_sensor.time, pco2w_sensor.partial_pressure_of_carbon_dioxide_in_sea_water - pco2w_sensor.pCO2_weekly_std,'Color',lightcyan,'Linewidth',1)
h1 = plot(pco2w_sensor.time, pco2w_sensor.partial_pressure_of_carbon_dioxide_in_sea_water,'.','Color',blue); hold on
h2 = plot(pco2w_sensor.time, pco2w_sensor.partial_pressure_of_carbon_dioxide_in_sea_water + correction,'.','Color',grey); hold on
h3 = plot(datetime(bottle_data.CTDBottleClosureTime_UTC_),bottle_data.CalculatedPCO2_uatm_,...
    'ok','MarkerSize',5,'MarkerFaceColor','k')
ylabel('Seawater pCO_2 (\muatm)')
xlim([datetime(2015,5,1) datetime(2015,10,30)])
legend([h1 h2 h3], 'SAMI-CO2 L1 data','Corrected','Discrete samples','Location','southeast')
title({'Coastal Pioneer: Central Surface Mooring' 'Seafloor Multi-function Node: SAMI-CO2'})

