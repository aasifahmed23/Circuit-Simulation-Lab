clc; clear all; close all;
%    Interaction Section
    load_system('thevenin_theorem_v2.slx');            
    set_param('thevenin_theorem_v2/K1', 'Value', '1');
    set_param('thevenin_theorem_v2/K2', 'Value', '1');
    sim('thevenin_theorem_v2');
    I_sc=max(i_sc);
    set_param('thevenin_theorem_v2/K1', 'Value', '-1');
    set_param('thevenin_theorem_v2/K2', 'Value', '-1');
    sim('thevenin_theorem_v2');
    V_oc=max(v_oc);
    Z_th_K=(V_oc/I_sc)/1e3;    %%
    sprintf('The Thevenin equivalent circuit is: \n V_oc= %.2f \n R_TH(in K ohm) =%.2f',V_oc, Z_th_K)
   