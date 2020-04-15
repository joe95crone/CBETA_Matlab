qxfunction chrom_data = chrom_measure02(npts,max_change,mpass,section)
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
    % 1% change in energy
    mpass = 1;
    section = 'all';
end


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
chrom_data.change_point = change_point;

% Getting cavity 1 phase data
holder = get_data_from_name('RD1CAV01',1,0.01,true,false); % Get cavity data
cav_volt = holder.voltage_cmd;


try
    
    for i=1:npts
        disp(['Now taking measurement ' num2str(i) ' of ' num2str(npts) ' ...']);
        volt_change = (1-change_point(i))*cav_volt;
        set_cmd_from_name('RD1CAV01',volt_change,'cmd_name','voltage_cmd');
        % sets the voltage lower
        
        % pause to allow cavity to set
        pause(3);
        
        % take tune measurement
        chrom_data.tune_vals(i,:,:) = get_all_tunes(mpass);
    end
    
    % Lines of best fit
    qx = polyfit(change_point,transpose(chrom_data.tune_vals(:,1,ndat+1),1));
    % needs order of polynomial argument
    fx = polyval(qx,change_point);
    qy = polyfit(change_point,transpose(chrom_data.tune_vals(:,1,ndat+2),1));
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
    set_cmd_from_name('RD1CAV01',cav_volt,'cmd_name','voltage_cmd');
    rethrow(ex);
end

set_cmd_from_name('RD1CAV01',cav_volt,'cmd_name','voltage_cmd');

end

function setup_utilities()

mfile_dir = fileparts(mfilename('fullpath'));
addpath(genpath(fullfile(mfile_dir, '..', '..', 'utilities')));
addpath(genpath(fullfile(mfile_dir, '..', '..', 'get_all_tunes')));

end