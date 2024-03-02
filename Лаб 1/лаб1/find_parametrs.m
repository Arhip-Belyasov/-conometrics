function params = find_parametrs(X, y)
    params = inv(transpose(X) * X) * transpose(X) * transpose(y);