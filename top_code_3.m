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
%% Display Results
in=v_in.signals.values(2:1001);
y_out=y_out(2:1001,:,:); % Exclude the first row of data points
%%
j=2; % plot for differnet values of RC
plot(tout,in,tout,y_out(:,1,j),tout,y_out(:,1,j+1),tout,y_out(:,1,j+2),tout,y_out(:,1,j+3),tout,y_out(:,1,j+4));
% plot(tout,out(:,j),tout,out(:,j+1),tout,out(:,j+2),tout,out(:,j+3),tout,out(:,j+4));
%%
beta_index=1;
rc_index=1;
%% plot for differnet values of beta
plot(tout,y_out(:,beta_index,rc_index),tout,y_out(:,beta_index,1),tout,y_out(:,j+2,1),tout,y_out(:,j+3,1),tout,y_out(:,j+4,1));