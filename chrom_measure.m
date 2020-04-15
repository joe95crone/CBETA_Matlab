function chrom_data = chrom_measure(npts,max_change,mpass,section)
% Tune at altered cavity phases to calc chromaticity of a section (no. points, momentum range, pass no., section)

% --> how do I extend to multipass??? Nee fucking idea

% Setup (will be arguments of function)
%npts = 20; % no. points (ntune_measures)
%max_change = 5*10^-3; % +- change in momentum (max_mom_var)
%mpass selects the pass for the chromaticity measurement - only 1 pass rn
%mpass=1;

% only do negative as phase slippage is > 0 for lepton, so decrease energy

setup_utilities();

if nargin < 1
    npts = 30;
    max_change = 5e-3;
    % changing one cavity 
    mpass = 4;
    section = 'all';
end

ncav = 6;
% 6 cavities, we change 1 cav voltage by 6*max_change to get max_change in
% all energy
change_point = linspace(-max_change,0,npts);


% Select which section to output
ndat = 12;
while ndat == 12
    if all(section == 'all')
        ndat = 0;
    elseif all(section == 'FA')
        ndat = 2;
    elseif all(section == 'TA')
        ndat = 4;
    elseif all(section == 'ZX')
        ndat = 6;
    elseif all(section == 'TB')
        ndat = 8;
    elseif all(section == 'FB')
        ndat = 10;
    else
        disp('Please enter a valid section')
        ndat = 12;
    end
end
% array for tune data
chrom_data = struct;
chrom_data.tune_vals = zeros(npts,mpass,12);
chrom_data.tune_std = zeros(npts,mpass,12);
chrom_data.bpm_I = zeros(npts,mpass,104);
chrom_data.bpm_I_err = zeros(npts,mpass,104);
chrom_data.change_point = change_point;


% Getting cavity 1 phase data
holder = get_data_from_name('RD1CAV01',1,0.01,true,false); % Get cavity data
cav_volt = holder.voltage_cmd*1e-3;

chrom_data.setpoints = (1 + ncav*change_point)*cav_volt;
chrom_data.voltage_delta = chrom_data.setpoints - chrom_data.setpoints(end);
chrom_data.energy = [42, 78, 114, 150]*1e3;

%disp('hang out here');

try
    
    for i=1:npts
        disp(['Now taking measurement ' num2str(i) ' of ' num2str(npts) ' ...']);
        volt_change = (1+ncav*change_point(i))*cav_volt;
        %set_cmd_from_name('RD1CAV01',volt_change,'cmd_name','voltage_cmd');
        set_and_wait_cavity('RD1CAV01', volt_change);
        % sets the voltage lower
        
        % take tune measurement
        [a, b, c, d] = get_all_tunes_kirsten(mpass);
        chrom_data.tune_vals(i,:,:) = a;
        chrom_data.tune_std(i,:,:) = b;
        chrom_data.bpm_I(i,:,:) = c;
        chrom_data.bpm_I_err(i,:,:) = d;
        
    end
    
    % Lines of best fit
    qx = polyfit(change_point,transpose(chrom_data.tune_vals(:,1,ndat+1)),1);
    % needs order of polynomial argument
    fx = polyval(qx,change_point);
    qy = polyfit(change_point,transpose(chrom_data.tune_vals(:,1,ndat+2)),1);
    fy = polyval(qy,change_point);
    
    chrom_data.qx = qx;
    chrom_data.fx = fx;
    chrom_data.qy = qy;
    chrom_data.fy = fy;
    
    % Plotting of the data (just taking the full 1 pass for now)
    % Proved this works
    figure;
    scatter(change_point,chrom_data.tune_vals(:,1,ndat+1));
    hold on;
    plot(change_point,fx);
    xlabel('Momentum Change (%)'), ylabel('Qx Tune Value');
    title('Horizontal Chromaticity Plot');
    
    figure;
    scatter(change_point,chrom_data.tune_vals(:,1,ndat+2));
    hold on;
    plot(change_point,fy);
    xlabel('Momentum Change (%)'), ylabel('Qy Tune Value');
    title('Vertical Chromaticity Plot');
    
catch ex
    assignin('base','chrom_data',chrom_data);
    set_and_wait_cavity('RD1CAV01', cav_volt);
    rethrow(ex);
end

set_and_wait_cavity('RD1CAV01', cav_volt);

end

function setup_utilities()

mfile_dir = fileparts(mfilename('fullpath'));
addpath(genpath(fullfile(mfile_dir, '..', '..', 'utilities')));
addpath(genpath(fullfile(mfile_dir, '..', '..', 'get_all_tunes')));

end