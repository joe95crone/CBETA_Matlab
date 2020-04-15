
data = load('4pass_tune_measurements.mat');
data = data.trial_run;
load('last_day.mat');

h_data = importdata('h.txt');
i_data = importdata('i.txt');

straight_energy = h_data(:,1)/1e6; % MeV
straight_nu_x = acos(0.5*h_data(:,2))/(2.0*pi);
straight_nu_y = acos(0.5*h_data(:,3))/(2.0*pi); 

arc_energy = i_data(:,1)/1e6; % MeV
arc_nu_x = acos(0.5*i_data(:,2))/(2.0*pi);
arc_nu_y = acos(0.5*i_data(:,3))/(2.0*pi); 

straight_chromx = (diff(straight_nu_x)./diff(straight_energy)).*straight_energy(2:end);
straight_chromy = (diff(straight_nu_y)./diff(straight_energy)).*straight_energy(2:end);

arc_chromx = (diff(arc_nu_x)./diff(arc_energy)).*arc_energy(2:end);
arc_chromy = (diff(arc_nu_y)./diff(arc_energy)).*arc_energy(2:end);

% FA Plot
figure(1)
plot(arc_energy(2:end),arc_chromx)
hold on;
plot(arc_energy(2:end),arc_chromy)

% ZX Plot
figure(2)
plot(straight_energy(2:end),straight_chromx)
hold on;
plot(straight_energy(2:end),straight_chromy)

% FB Plot
figure(3)
plot(arc_energy(2:end),arc_chromx)
hold on;
plot(arc_energy(2:end),arc_chromy)