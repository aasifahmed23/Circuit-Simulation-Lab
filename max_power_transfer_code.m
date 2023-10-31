clc; clear all; close all;
%% Interaction Section
rl_index=1;
for rl= 2:40
    load_system('max_power_transfer.slx');            
    set_param('max_power_transfer/RL', 'R', 'rl');        
    sim('max_power_transfer');
    voltage(:,rl_index)=v_out.signals.values(:,1);
    current(:,rl_index)=i_out.signals.values(:,1);
    rl_index=rl_index+1;   
end

%% Compute power
power= voltage(1,:).*current(1,:);
%% Display Results
% plot for differnet values of RL;
figure('color',[0.97,0.97,0.97]);
colormap('jet');
rl= 2:40;
plot(rl,power);

% Create xlabel
xlabel('RL(in Kilo Ohms)');

% Create ylabel
ylabel('Power (Watts)');

% Create title
title('Power Plot');