%% Download the 'exp12_C.slx' and 'topcode.m' in the SAME DIRECTORY
%% Reset old simulation results from workspace
clc; clear all; close all;
%% Design Exploration Section
for rc_x = 1:5 % Sweep resistance from 1K to 5K 
    % Load the simulink model into memory 
    load_system('exp12_C.slx'); 
    % Setting parameter value to resistance RC used in the design 'exp12_C.slx'
    % 'R' is the block paramaeter for resistance.
    % 'rc_x' is the sweep variable.
    set_param('exp12_C/RC', 'R', 'rc_x'); 
    
    % Similarly we can set values for transistor beta.
    % 'beta' is the sweep variable.
    % 'hfe' is the block paramaeter for transistor Q0 present in the model 'exp12_C.slx'
    % Uncomment the line below if you want to sweep beta as well. 
    % Before uncommenting declare a loop variable 'beta', similar to 'rc_x'
    % This will be a nested for loop now. Hence you need to handle
    % multidimensional arrays.
%     set_param('exp12_C/Q0', 'hfe', 'beta');  
                                   
    sim('exp12_C');
    y(:,rc_x)=v_out.signals.values(:,1);    
end

%% Display Results
% Exclude the first row of data points due to solver comfiguration.
% Solver starts simulation from a steady state :(  
in=v_in.signals.values(2:1001); % this is tyical way to traverse  through a nested simulation structure
out=y(2:1001,:); % storing output y into out for our readability purpose.
plot(tout,out(:,1),tout,out(:,2),tout,out(:,3),tout,out(:,4),tout,out(:,5)); 
%% Compute Gain
for rc_x = 1:5
    Av(:,rc_x)=max(out(:,rc_x))./max(in);
end
Av_max=max(Av);
