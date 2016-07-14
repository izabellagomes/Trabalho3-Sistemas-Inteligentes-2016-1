function plot_policy_in_gridworld(pol_pi, rowsNumber, columnsNumber, inicialState, terminalState, wind)
%%
    %function based on code avaliable on: <http://waxworksmath.com/Authors/N_Z/Sutton/Code/Chapter_6/plot_gw_policy.m>
    %acessed in june 26th, 2016.
%%
%plotting the wind
W = repmat(wind, [rowsNumber, 1]);
figure;
imagesc(columnsNumber, rowsNumber, W);
colormap(jet(length(unique(wind))));
colorbar;
hold on;

%plotting the inicial and terminal states
plot(inicialState(2), inicialState(1), 'o', 'MarkerSize', 10, 'MarkerFaceColor', 'k');
plot(terminalState(2), terminalState(1), 'x', 'MarkerSize', 10, 'MarkerFaceColor', 'k');

%fill the vectors
px = zeros(size(pol_pi));
py = zeros(size(pol_pi));
for row = 1:rowsNumber
    for column = 1:columnsNumber
        switch pol_pi(row, column)
            case 1, %up/north
                px(row,column) = 0;
                py(row,column) = 0.5; 
            case 2, %down/south
                px(row,column) = 0;
                py(row,column) = -0.5;
            case 3, %right/east
                px(row,column) = 0.5;
                py(row,column) = 0;
            case 4, %left/west
                px(row,column) = -0.5; 
                py(row,column) = 0;
            case 5, %up and left/nw
                px(row,column) = -0.5; 
                py(row,column) = +0.5;
            case 6, %up and rigth/ne
                px(row,column) = +0.5; 
                py(row,column) = +0.5; 
            case 7, %down and rigth/se
                px(row,column) = +0.5; 
                py(row,column) = -0.5;
            case 8, %down and left/sw
                px(row,column) = -0.5; 
                py(row,column) = -0.5;
        end
    end
end

[columnArows,rowArows] = meshgrid(1:columnsNumber,1:rowsNumber);

figure;
quiver(columnArows,rowArows,px,-py);

end