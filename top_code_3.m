%% Interaction Section
clc; clear all; close all;
%%
beta_index=1;
for beta = 100:50:300
    load_system('exp12_E.slx');
    set_param('exp12_E/Q0', 'hfe', 'beta');
    rc_index=1;
    for rc= 1:5        
        set_param('exp12_E/RC', 'R', 'rc');        
        sim('exp12_E');
%         y_out(:,beta_index,rc_index)=v_out.signals.values(:,1);
        y_out{beta_index,rc_index}=v_out.signals.values(:,1);
        rc_index=rc_index+1;        
    end
    beta_index=beta_index+1;
end

%% Data Cleaning
in=v_in.signals.values(2:1001);
for i=1:5
    for j=1:5 
        y_out{i,j}=y_out{i,j}(2:1001,:); % Exclude the first row of data points
    end
end
%% Display Results
i=1;
j=1; 

% plot for differnet values of RC
figure('color',[0.97,0.97,0.97]);
colormap('jet');
plot(tout,in,tout,y_out{i,j},tout,y_out{i,j+1},tout,y_out{i,j+2},tout,y_out{i,j+3},tout,y_out{i,j+4});

% Create title
title('Transient plot for differnet values of RC');

% plot for differnet values of beta
figure('color',[0.97,0.97,0.97]);
colormap('jet');
plot(tout,in,tout,y_out{i,j},tout,y_out{i+1,j},tout,y_out{i+2,j},tout,y_out{i+3,j},tout,y_out{i+4,j});
title('Transient plot for differnet values of beta');
%% Compute Gain
% each cell of y_out holds the outputs for each sweep
% Each Row of y_out cell have constant beta 
% Each cloumn of y_out cell have constant RC
% First calculate swings of each cell and store it in a cell called Av
for i= 1:5
    for j=1:5
        vout_amp=max(y_out{i,j})-min(y_out{i,j});
        vin_amp=max(in)-min(in);
        Av(i,j)=vout_amp/vin_amp;
    end
end
%% Design Visualization 
% Create figure
figure1 = figure;

% Create axes
axes1 = axes('Parent',figure1);
view(axes1,[-37.5 30]);
grid(axes1,'on');
hold(axes1,'on');

% Create surf
surf(Av,'Parent',axes1);

% Create xlabel
xlabel('Rc(in Kilo Ohms)');

% Create ylabel
ylabel('Current Gain(beta)');

% Create title
title('Amplifier Gain Plot');
