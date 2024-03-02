clc, clearvars, close all, format compact

y_1 = [251,249,248,246,242,239,235,230,228,225];
y_2 = [4087, 4737, 5768, 6005, 5639, 6745, 6311, 7107, 5741, 7087, 7310, 8600, 6975, 6891, 7527, 7971, 5875, 6140, 6248, 6041, 4626, 6501, 6284, 6707];
n_1 = length(y_1);
n_2 = length(y_2);
t_1 = 1:n_1;
t_2 = 1:n_2;
m = 2;

X_1 = horzcat(ones(n_1, 1), transpose(t_1));
X_2 = horzcat(ones(n_2, 1), transpose(t_2),transpose(t_2.^2),transpose(t_2.^3));
theta_1 = find_parametrs(X_1, y_1);

create_regression_model(t_1, y_1, theta_1, 1);

[disp, c, r, gamma] = find_characteristics(n_1, y_1, t_1, theta_1);

y_pred = predict(y_1);

create_plot(y_2);

theta_2 = find_parametrs(X_2, y_2);

create_regression_model(t_2, y_2, theta_2, 0);