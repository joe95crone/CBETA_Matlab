% Analysis of chromaticity data + fieldmap data chromaticity

load('last_day.mat');

% Arrays for chrom vals 
q = zeros(2,2,4);
qFA = zeros(2,2,4);
qZX = zeros(2,2,4);
qFB = zeros(2,2,4);

errFA = zeros(4,2,4);

% Array of beam energies for plotting measured chromaticities
energies = 6 + 36*[1,2,3,4];

nval=1;
nfig=1;
npts=30;
formatSpec = 'Q''%s = %f';

for npass=1:4
    % PLOTS OF MEASURED TUNE FOR FULL FFA
%     for xy=1:2
%         if mod(xy,2)==0
%             xytitle = 'y';
%         else
%             xytitle = 'x';
%         end
%         figure(nfig);
%         checkpoint = abs(shiftdim(shiftdim(chrom_data.tune_std(:,npass,xy),1)) ) < 1e-3 & abs(shiftdim(shiftdim(chrom_data.tune_vals(:,npass,xy),1))) > max(chrom_data.tune_vals(:,npass,xy))/4; 
%         % creates a logical array of all of the bad/good points, evaluates the conditions 
%         scatter(chrom_data.voltage_delta(checkpoint)*npass/chrom_data.energy(npass),chrom_data.tune_vals(checkpoint,npass,xy));
%         xlabel('Fractional Energy Change');
%         ylabel('Tune Value');
%         hold on;
%         errorbar(chrom_data.voltage_delta(checkpoint)*npass/chrom_data.energy(npass),chrom_data.tune_vals(checkpoint,npass,xy),chrom_data.tune_std(checkpoint,npass,xy),'LineStyle','none');
%         q(:,xy,npass) = polyfit(chrom_data.voltage_delta(checkpoint)*npass/chrom_data.energy(npass),chrom_data.tune_vals(checkpoint,npass,xy)',1);
%         f = polyval(q(:,xy,npass),chrom_data.voltage_delta(checkpoint)*npass/chrom_data.energy(npass));
%         hold on;
%         plot(chrom_data.voltage_delta(checkpoint)*npass/chrom_data.energy(npass),f);
%         legend({'machine data','machine error','fit'},'Location','best');
%         title(sprintf('Pass %d Q''%s = %f',npass,xytitle,q(1,xy,npass)));
%         
%         nfig = nfig +1;
%     end
    % FA Chrom vals
    for xy = 3:4
         if mod(xy,2)==0
            xytitle = 'y';
        else
            xytitle = 'x';
        end
       checkpointFA = abs(shiftdim(shiftdim(chrom_data.tune_std(:,npass,xy),1)) ) < 1e-3 & abs(shiftdim(shiftdim(chrom_data.tune_vals(:,npass,xy),1)))> max(chrom_data.tune_vals(:,npass,xy))/4;
%        [q1, error1] = polyfit(chrom_data.voltage_delta(checkpointFA)*npass/chrom_data.energy(npass),chrom_data.tune_vals(checkpointFA,npass,xy)',1);
%        [q3, error3] = polyfit(chrom_data.voltage_delta(checkpointFA)*npass/chrom_data.energy(npass),chrom_data.tune_vals(checkpointFA,npass,xy)',3);
%        while error1.normr < error3.normr && error1.normr < 1e-6
%            [q1, error1] = polyfit(chrom_data.voltage_delta(checkpointFA((1+nval):(end-nval)))*npass/chrom_data.energy(npass),chrom_data.tune_vals(checkpointFA((1+nval):(end-nval)),npass,xy)',1);
%            [q3, error3] = polyfit(chrom_data.voltage_delta(checkpointFA((1+nval):(end-nval)))*npass/chrom_data.energy(npass),chrom_data.tune_vals(checkpointFA((1+nval):(end-nval)),npass,xy)',3);
%            % takes a point off each side of the data set until it is linear
%            nval= nval+1;
%        end
% MIGHT FUCKING WORK (EVALUATING UNTIL MORE LINEAR THAN QUATERNIC + ARBITRARY LINEARITY)        
%        while error.normr > 1e-2
%            [q, error] = polyfit(chrom_data.voltage_delta(checkpointFA((1+nval):(end-nval)))*npass/chrom_data.energy(npass),chrom_data.tune_vals(checkpointFA((1+nval):(end-nval)),npass,xy)',1);
%            % takes a point off each side of the data set until it is linear
%            nval= nval+1;
%        end
% DOESN'T FUCKING WORK (EVALUATING UNTIL DATA BECOMES ARBITRARILY LINEAR)
       
       qFA(:,xy-2,npass) = q1;
       errFA(xy-2,npass) = error1.normr;
       figure(nfig)
       scatter(chrom_data.voltage_delta(checkpointFA)*npass/chrom_data.energy(npass),chrom_data.tune_vals(checkpointFA,npass,xy));
       xlabel('Fractional Energy Change');
       ylabel('Tune Value');
       hold on;
       errorbar(chrom_data.voltage_delta(checkpointFA)*npass/chrom_data.energy(npass),chrom_data.tune_vals(checkpointFA,npass,xy),chrom_data.tune_std(checkpointFA,npass,xy),'LineStyle','none');
       fFA = polyval(qFA(:,xy-2,npass),chrom_data.voltage_delta(checkpointFA)*npass/chrom_data.energy(npass));
       hold on;
       plot(chrom_data.voltage_delta(checkpointFA)*npass/chrom_data.energy(npass),fFA);
       legend({'machine data','machine error','fit'},'Location','best');
       title(sprintf('FA Pass %d Q''%s = %f',npass,xytitle,qFA(1,xy-2,npass)));
       
       nfig = nfig+1;
    end
    % ZX Chrom Vals
%     for xy = 7:8
%          if mod(xy,2)==0
%             xytitle = 'y';
%         else
%             xytitle = 'x';
%         end
%         checkpointZX = abs(shiftdim(shiftdim(chrom_data.tune_std(:,npass,xy),1)) ) < 1e-3 & abs(shiftdim(shiftdim(chrom_data.tune_vals(:,npass,xy),1))) > max(chrom_data.tune_vals(:,npass,xy))/4;
%         qZX(:,xy-6,npass) = polyfit(chrom_data.voltage_delta(checkpointZX)*npass/chrom_data.energy(npass),chrom_data.tune_vals(checkpointZX,npass,xy)',1);
%         
%         figure(nfig)
%         scatter(chrom_data.voltage_delta(checkpointZX)*npass/chrom_data.energy(npass),chrom_data.tune_vals(checkpointZX,npass,xy));
%         xlabel('Fractional Energy Change');
%         ylabel('Tune Value');
%         hold on;
%         errorbar(chrom_data.voltage_delta(checkpointZX)*npass/chrom_data.energy(npass),chrom_data.tune_vals(checkpointZX,npass,xy),chrom_data.tune_std(checkpointZX,npass,xy),'LineStyle','none');
%         fZX = polyval(qZX(:,xy-6,npass),chrom_data.voltage_delta(checkpointZX)*npass/chrom_data.energy(npass));
%         hold on;
%         plot(chrom_data.voltage_delta(checkpointZX)*npass/chrom_data.energy(npass),fZX);
%         legend({'machine data','machine error','fit'},'Location','best');
%         title(sprintf('ZX Pass %d Q''%s = %f',npass,xytitle,qZX(1,xy-6,npass)));
%        
%         nfig = nfig+1;
%     end
    % FB Chrom Vals
%     for xy = 11:12
%          if mod(xy,2)==0
%             xytitle = 'y';
%         else
%             xytitle = 'x';
%         end
%         checkpointFB = abs(shiftdim(shiftdim(chrom_data.tune_std(:,npass,xy),1)) ) < 1e-3 & abs(shiftdim(shiftdim(chrom_data.tune_vals(:,npass,xy),1))) > max(chrom_data.tune_vals(:,npass,xy))/4;
%         qFB(:,xy-10,npass) = polyfit(chrom_data.voltage_delta(checkpointFB)*npass/chrom_data.energy(npass),chrom_data.tune_vals(checkpointFB,npass,xy)',1);
%         
%         figure(nfig)
%         scatter(chrom_data.voltage_delta(checkpointFB)*npass/chrom_data.energy(npass),chrom_data.tune_vals(checkpointFB,npass,xy));
%         xlabel('Fractional Energy Change');
%         ylabel('Tune Value');
%         hold on;
%         errorbar(chrom_data.voltage_delta(checkpointFB)*npass/chrom_data.energy(npass),chrom_data.tune_vals(checkpointFB,npass,xy),chrom_data.tune_std(checkpointFB,npass,xy),'LineStyle','none');
%         fFB = polyval(qFB(:,xy-10,npass),chrom_data.voltage_delta(checkpointFB)*npass/chrom_data.energy(npass));
%         hold on;
%         plot(chrom_data.voltage_delta(checkpointFB)*npass/chrom_data.energy(npass),fFB);
%         legend({'machine data','machine error','fit'},'Location','best');
%         title(sprintf('FA Pass %d Q''%s = %f',npass,xytitle,qFB(1,xy-10,npass)));
%        
%         nfig = nfig+1;
%     end
    % Get a warning out for the polyfit as Q'y produces no good points for pass 4 currently
end

%errorbar(chrom_data.voltage_delta(checkpoint_2)*2/chrom_data.energy(2),(shiftdim(shiftdim(chrom_data.tune_vals(checkpoint_2,2,3),1))),shiftdim(shiftdim(chrom_data.tune_std(checkpoint_2,2,3),1)),'o')
%checkpoint_2 = abs(shiftdim(shiftdim(chrom_data.tune_std(:,2,3),1)) ) < 1e-3
%plot(chrom_data.voltage_delta*2/chrom_data.energy(2),mean(shiftdim(shiftdim(chrom_data.bpm_I(:,2,:),1))./max(shiftdim(shiftdim(chrom_data.bpm_I(:,2,:),1)),[],2)))

% FIELDMAP DATA
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

straight_chromx = (diff(straight_nu_x)./diff(straight_energy)).*straight_energy(2:end);
straight_chromy = (diff(straight_nu_y)./diff(straight_energy)).*straight_energy(2:end);

arc_chromx = (diff(arc_nu_x)./diff(arc_energy)).*arc_energy(2:end);
arc_chromy = (diff(arc_nu_y)./diff(arc_energy)).*arc_energy(2:end);

% GET MEASURED POINTS

% FA Plot
figure(nfig+1)
plot(arc_energy(21:1221),arc_chromx(20:1220))
% 40MeV up to 160MeV
hold on;
plot(arc_energy(21:1221),arc_chromy(20:1220))
hold on;
scatter(energies,qFA(1,1,:))
% x chrom
hold on;
scatter(energies,qFA(1,2,:))
% y chrom
legend({'fieldmap Q''x','fieldmap Q''y','measured Q''x','measured Q''y'},'Location','best');
title('FA Chromaticity Plot')
xlabel('Beam Energy (MeV)')
ylabel('Chromaticity')

% % ZX Plot
% figure(nfig+2)
% plot(straight_energy(18:1218),straight_chromx(17:1217))
% % 40MeV up to 160MeV
% hold on;
% plot(straight_energy(18:1218),straight_chromy(17:1217))
% hold on;
% scatter(energies,qZX(1,1,:))
% % x chrom
% hold on;
% scatter(energies,qZX(1,2,:))
% % y chrom
% legend({'fieldmap Q''x','fieldmap Q''y','measured Q''x','measured Q''y'},'Location','best');
% title('ZX Chromaticity Plot')
% xlabel('Beam Energy (MeV)')
% ylabel('Chromaticity')

% % FB Plot
% figure(nfig+3)
% plot(arc_energy(21:1221),arc_chromx(20:1220))
% % 40MeV up to 160MeV
% hold on;
% plot(arc_energy(21:1221),arc_chromy(20:1220))
% hold on;
% scatter(energies,qFB(1,1,:))
% % x chrom
% hold on;
% scatter(energies,qFB(1,2,:))
% % y chrom
% legend({'fieldmap Q''x','fieldmap Q''y','measured Q''x','measured Q''y'},'Location','best');
% title('FB Chromaticity Plot')
% xlabel('Beam Energy (MeV)')
% ylabel('Chromaticity')