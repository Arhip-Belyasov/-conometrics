clc, clearvars, close all, format compact

y= [18.58,18.75,18.83,18.61,18.62,18.50,18.32,18.43,18.37,18.67,18.78,18.72,18.66,18.81,18.98,19.15,19.21,19.14,19.17,18.99,18.83,19.00,19.07,18.93];
n=24;
t=1:n; 
[cov,cor,a,Q,a0,h1,gamma,gammaDF,AIK,h2,h_pred]=find_characteristics(n,y);
create_AR_plot(y,h1)
