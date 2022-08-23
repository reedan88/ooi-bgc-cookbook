%% Kristen Fogaren 8/23/22
% Code will produce figures in Chapter 2 of OOI BGC Sensor Best Practices
% CSV files are in shared google drive. 
% https://drive.google.com/drive/folders/1ZQyt2YfRBE1IAxZcQewDwRvfDUufSuoX?usp=sharing

%% General plotting stuff 

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

%% Figure 2-2 
glider = readtable('Figure_2-2_Glider.csv','TextType','string');
% variables of depth, oxygen_umol_kg, oxygen_gain_corr_umol_kg
winklers = readtable('Figure_2-2_Winklers.csv','TextType','string');
% variables of depth, oxygen_umol_kg

f = figure;
plot(glider.oxygen_umol_kg,glider.depth,'Linewidth',1.5,'Color',blue)
hold on
plot(glider.oxygen_gain_corr_umol_kg,glider.depth,'Linewidth',1.5,'Color',red)
plot(winklers.oxygen_umol_kg,winklers.depth,'ok','MarkerSize',5,'MarkerFaceColor','k')
axis ij
x = gca;
x.XAxisLocation = 'top';
grid on
x.FontSize = 12;
xlabel('Oxygen (\mumol kg^-^1)')
ylabel('Depth (m)')
legend('Uncorrected','Corrected','Winkler','Location','SE')

%% Figure 2-3
deepiso = readtable('Figure_2-3.csv','TextType','string');
% variables date and o2

% Izi's file doesn't break up by deployment so I found deployments
% Used diff(deepiso.date), quick and easy, not efficient 
deployment1 = 1:194;
deployment2 = 195:378;
deployment3 = 379:596;
deployment4 = 597:782;
deployment5 = 783:1011;
deployment6 = 1012:1168;

f = figure;
plot(deepiso.date(deployment1),deepiso.o2(deployment1),'Color',blue)
hold on
plot(deepiso.date(deployment2),deepiso.o2(deployment2),'Color',red)
plot(deepiso.date(deployment3),deepiso.o2(deployment3),'Color',yellow)
plot(deepiso.date(deployment4),deepiso.o2(deployment4),'Color',purple)
plot(deepiso.date(deployment5),deepiso.o2(deployment5),'Color',green)
plot(deepiso.date(deployment6),deepiso.o2(deployment6),'Color',cyan)
x = gca;
x.FontSize = 12;
ylabel('Oxygen (\mumol kg^-^1)')
grid on

%% Figure 2-4
DO1 = readtable('Figure_2-4_DO1.csv','TextType','string');
% variables datenum_wUV oxygen_wUV_umol_kg

DO2 = readtable('Figure_2-4_DO2.csv','TextType','string');
% variables datenum_noUV oxygen_noUV_umol_kg

figure
plot(DO2.datenum_noUV,DO2.oxygen_noUV_umol_kg,'Linewidth',1.25) 
hold on
plot(DO1.datenum_wUV,DO1.oxygen_wUV_umol_kg,'Linewidth',2)
datetick
axis tight
ylabel('DO (\mumol kg^-^1)')
xlim([datetime(2017,11,01) datetime(2018,02,01)])
f = gca;
f.FontSize = 12;
legend('DOSTA','DOSTA-UV','Location','NW')
title({'Oregon Shelf Surface Mooring' 'Near-surface instrument frame'})

%% Figure 2-5
deploy8 = readtable('Figure_2-5_Deploy8File.csv','TextType','string');
% variables datetime, oxygen_uncorrected_umol_kg, oxygen_corrected_umol_kg
deploy9 = readtable('Figure_2-5_Deploy9File.csv','TextType','string');
% variables datetime, oxygen_uncorrected_umol_kg, oxygen_corrected_umol_kg
winklers = readtable('Figure_2-5_Winkler.csv','TextType','string');
% variables CTDBottleClosureTime_UTC DiscreteOyxgen_umolkg

figure
subplot(2,1,1)
plot(deploy8.datetime,deploy8.oxygen_uncorrected_umol_kg,'Color',blue,'Linewidth',1.5)
hold on
plot(deploy9.datetime,deploy9.oxygen_uncorrected_umol_kg,'Color',red,'Linewidth',1.5)
plot(deploy8.datetime,deploy8.oxygen_corrected_umol_kg,'Color',grey,'Linewidth',1.5)
plot(deploy9.datetime,deploy9.oxygen_corrected_umol_kg,'Color',grey,'Linewidth',1.5)
plot(winklers.CTDBottleClosureTime_UTC,winklers.DiscreteOxygen_umolkg,...
    'ok','MarkerSize',5,'MarkerFaceColor','k')
ylabel('DO (\mumol kg^-^1)')

subplot(2,1,2)
plot(deploy8.datetime,deploy8.oxygen_uncorrected_umol_kg,'Color',blue,'Linewidth',2.5)
hold on
plot(deploy9.datetime,deploy9.oxygen_uncorrected_umol_kg,'Color',red,'Linewidth',2.5)
plot(deploy8.datetime,deploy8.oxygen_corrected_umol_kg,'Color',grey,'Linewidth',2.5)
plot(winklers.CTDBottleClosureTime_UTC,winklers.DiscreteOxygen_umolkg,...
    'ok','MarkerSize',8,'MarkerFaceColor','k')
plot(deploy9.datetime,deploy9.oxygen_corrected_umol_kg,'Color',grey,'Linewidth',2.5)
plot(winklers.CTDBottleClosureTime_UTC,winklers.DiscreteOxygen_umolkg,...
    'ok','MarkerSize',8,'MarkerFaceColor','k')
ylabel('DO (\mumol kg^-^1)')
legend('Deployment 8','Deployment 9','Corrected','Winkler','Location','southoutside',...
    'Orientation','horizontal')
