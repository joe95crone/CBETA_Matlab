% Get chromaticity from the fieldmap tune data

% Fieldmap data
data = load('4pass_tune_measurements.mat');
data = data.trial_run;

h_data = importdata('h.txt');
i_data = importdata('i.txt');

straight_energy = h_data(:,1)/1e6; % MeV
straight_nu_x = acos(0.5*h_data(:,2))/(2.0*pi);
straight_nu_y = acos(0.5*h_data(:,3))/(2.0*pi); 

arc_energy = i_data(:,1)/1e6; % MeV
arc_nu_x = acos(0.5*i_data(:,2))/(2.0*pi);
arc_nu_y = acos(0.5*i_data(:,3))/(2.0*pi); 

% Plot of Tune
figure();
plot(arc_energy(21:1221),arc_nu_x(20:1220));
% 40MeV up to 160MeV
hold on;
plot(arc_energy(21:1221),arc_nu_y(20:1220));
title('FFA Tune Plot');
xlabel('Fractional Energy Change');
ylabel('Tune')

% 42 MeV Tune vs Fractional E change
f1x1 = polyfit((42-arc_energy(36:46))/42,arc_nu_x(35:45),1);
g1x1 = polyval(f1x1,(42-arc_energy(36:46))/42);
f2x1 = polyfit((42-arc_energy(36:46))/42,arc_nu_x(35:45),2);
g2x1 = polyval(f2x1,(42-arc_energy(36:46))/42);
f3x1 = polyfit((42-arc_energy(36:46))/42,arc_nu_x(35:45),3);
g3x1 = polyval(f3x1,(42-arc_energy(36:46))/42);
f4x1 = polyfit((42-arc_energy(36:46))/42,arc_nu_x(35:45),4);
g4x1 = polyval(f4x1,(42-arc_energy(36:46))/42);


figure();
scatter((42-arc_energy(36:46))/42,arc_nu_x(35:45));
hold on;
plot((42-arc_energy(36:46))/42,g1x1);
hold on;
plot((42-arc_energy(36:46))/42,g2x1);
hold on;
plot((42-arc_energy(36:46))/42,g3x1);
hold on;
plot((42-arc_energy(36:46))/42,g4x1);
title('X data 42MeV');
xlabel('Factional Energy Change');
ylabel('Tune');

% 78 MeV Tune vs Fractional E change
f1x2 = polyfit((78-arc_energy(396:406))/78,arc_nu_x(395:405),1);
g1x2 = polyval(f1x2,(78-arc_energy(396:406))/78);
f2x2 = polyfit((78-arc_energy(396:406))/78,arc_nu_x(395:405),2);
g2x2 = polyval(f2x2,(78-arc_energy(396:406))/78);
f3x2 = polyfit((78-arc_energy(396:406))/78,arc_nu_x(395:405),3);
g3x2 = polyval(f3x2,(78-arc_energy(396:406))/78);
f4x2 = polyfit((78-arc_energy(396:406))/78,arc_nu_x(395:405),4);
g4x2 = polyval(f4x2,(78-arc_energy(396:406))/78);

figure();
scatter((78-arc_energy(396:406))/78,arc_nu_x(395:405));
hold on;
plot((78-arc_energy(396:406))/78,g1x2);
hold on;
plot((78-arc_energy(396:406))/78,g2x2);
hold on;
plot((78-arc_energy(396:406))/78,g3x2);
hold on;
plot((78-arc_energy(396:406))/78,g4x2)
title('X data 78MeV');
xlabel('Factional Energy Change');
ylabel('Tune');

% 114 MeV Tune vs Fractional E change
f1x3 = polyfit((114-arc_energy(756:766))/114,arc_nu_x(755:765),1);
g1x3 = polyval(f1x3,(114-arc_energy(756:766))/114);
f2x3 = polyfit((114-arc_energy(756:766))/114,arc_nu_x(755:765),2);
g2x3 = polyval(f2x3,(114-arc_energy(756:766))/114);
f3x3 = polyfit((114-arc_energy(756:766))/114,arc_nu_x(755:765),3);
g3x3 = polyval(f3x3,(114-arc_energy(756:766))/114);
f4x3 = polyfit((114-arc_energy(756:766))/114,arc_nu_x(755:765),4);
g4x3 = polyval(f4x3,(114-arc_energy(756:766))/114);

figure();
scatter((114-arc_energy(756:766))/114,arc_nu_x(755:765));
hold on;
plot((114-arc_energy(756:766))/114,g1x3);
hold on;
plot((114-arc_energy(756:766))/114,g2x3);
hold on;
plot((114-arc_energy(756:766))/114,g3x3);
hold on;
plot((114-arc_energy(756:766))/114,g4x3)
title('X data 114MeV');
xlabel('Factional Energy Change');
ylabel('Tune');

% 150 MeV Tune vs Fractional E change
f1x4 = polyfit((150-arc_energy(1116:1126))/150,arc_nu_x(1115:1125),1);
g1x4 = polyval(f1x4,(150-arc_energy(1116:1126))/150);
f2x4 = polyfit((150-arc_energy(1116:1126))/150,arc_nu_x(1115:1125),2);
g2x4 = polyval(f2x4,(150-arc_energy(1116:1126))/150);
f3x4 = polyfit((150-arc_energy(1116:1126))/150,arc_nu_x(1115:1125),3);
g3x4 = polyval(f3x4,(150-arc_energy(1116:1126))/150);
f4x4 = polyfit((150-arc_energy(1116:1126))/150,arc_nu_x(1115:1125),4);
g4x4 = polyval(f4x4,(150-arc_energy(1116:1126))/150);

figure();
scatter((150-arc_energy(1116:1126))/150,arc_nu_x(1115:1125));
hold on;
plot((150-arc_energy(1116:1126))/150,g1x4);
hold on;
plot((150-arc_energy(1116:1126))/150,g2x4);
hold on;
plot((150-arc_energy(1116:1126))/150,g3x4);
hold on;
plot((150-arc_energy(1116:1126))/150,g4x4)
title('X data 150MeV');
xlabel('Factional Energy Change');
ylabel('Tune');

% Plot of 1st order chromaticity values
f = [f1x1(1),f1x2(1), f1x3(1), f1x4(1); f2x1(2),f2x2(2), f2x3(2), f2x4(2); f3x1(3),f3x2(3), f3x3(3), f3x4(3); f4x1(4),f4x2(4),f4x3(4),f4x4(4)];
energy = [42,78,114,150];

figure();
scatter(energy(1),f(1,1),'o')
hold on;
scatter(energy(1),f(2,1),'x')
hold on;
scatter(energy(1),f(3,1),'+')
hold on;
scatter(energy(1),f(4,1),'s')
title('Pass 1 X Arc')
xlabel('Tune');
ylabel('Energy');
legend({'linear','quadratic','cubic','quaternic'},'Location','best');

figure();
scatter(energy(2),f(1,2),'o')
hold on;
scatter(energy(2),f(2,2),'x')
hold on;
scatter(energy(2),f(3,2),'+')
hold on;
scatter(energy(2),f(4,2),'s')
title('Pass 2 X Arc')
xlabel('Tune');
ylabel('Energy');
legend({'linear','quadratic','cubic','quaternic'},'Location','best');

figure();
scatter(energy(3),f(1,3),'o')
hold on;
scatter(energy(3),f(2,3),'x')
hold on;
scatter(energy(3),f(3,3),'+')
hold on;
scatter(energy(3),f(4,3),'s')
title('Pass 3 X Arc')
xlabel('Tune');
ylabel('Energy');
legend({'linear','quadratic','cubic','quaternic'},'Location','best');

figure();
scatter(energy(4),f(1,4),'o')
hold on;
scatter(energy(4),f(2,4),'x')
hold on;
scatter(energy(4),f(3,4),'+')
hold on;
scatter(energy(4),f(4,4),'s')
title('Pass 4 X Arc')
xlabel('Tune');
ylabel('Energy');
legend({'linear','quadratic','cubic','quaternic'},'Location','best');