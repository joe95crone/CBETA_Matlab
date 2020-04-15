function plot_tunes()

% h.txt : Straight, columns are energy (eV), 2*cos(2*pi*nux), 2*cos*(2*pi*nuy)
% i.txt : Arc, columns are energy (eV), 2*cos(2*pi*nux), 2*cos(2*pi*nuy), ToF (s)

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

zx_h_col = 7;
zx_v_col = 8;

figure(1);
plot(straight_energy, straight_nu_x, 'r-', straight_energy, straight_nu_y, 'b-');
hold on;
energies = 6 + 36*[1,2,3,4];
errorbar(energies, data.tune(:,zx_h_col), data.tune_std(:,zx_h_col), 'ro');
errorbar(energies, data.tune(:,zx_v_col), data.tune_std(:,zx_v_col), 'bo');
hold off;
xlim([20, 180]);
prettyplot(gcf, 1.5, 8);
title('Straight section')
ylabel('Tune per cell');
xlabel('Energy (MeV)');
legend({'Horizontal (fieldmap)', 'Vertical (fieldmap)', 'Horizontal (measured)', 'Vertical (measured)'})

fa_h_col = 3;
fa_v_col = 4;

figure(2);
plot(arc_energy, arc_nu_x, 'r-', arc_energy, arc_nu_y, 'b-');
hold on;
energies = 6 + 36*[1,2,3,4];
errorbar(energies, data.tune(:,fa_h_col), data.tune_std(:,fa_h_col), 'ro');
errorbar(energies, data.tune(:,fa_v_col), data.tune_std(:,fa_v_col), 'bo');
hold off;
xlim([20, 180]);
prettyplot(gcf, 1.5, 8);
title('FA section')
ylabel('Tune per cell');
xlabel('Energy (MeV)');
legend({'Horizontal (fieldmap)', 'Vertical (fieldmap)', 'Horizontal (measured)', 'Vertical (measured)'})

fb_h_col = 11;
fb_v_col = 12;

figure(3);
plot(arc_energy, arc_nu_x, 'r-', arc_energy, arc_nu_y, 'b-');
hold on;
energies = 6 + 36*[1,2,3,4];
errorbar(energies, data.tune(:,fb_h_col), data.tune_std(:,fb_h_col), 'ro');
errorbar(energies, data.tune(:,fb_v_col), data.tune_std(:,fb_v_col), 'bo');
hold off;
xlim([20, 180]);
prettyplot(gcf, 1.5, 8);
title('FB section')
ylabel('Tune per cell');
xlabel('Energy (MeV)');
legend({'Horizontal (fieldmap)', 'Vertical (fieldmap)', 'Horizontal (measured)', 'Vertical (measured)'})

end

