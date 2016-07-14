%close all;
%clear all;

algorithm = 'q-learning';

%%
%defining the gridword and wind characteriascs
rowsNumber = 7;
columnsNumber = 10;

wind = [0 0 0 1 1 1 2 2 1 0];

%%
%defining the inicial and the terminal states
inicialState = [4 1];
terminalState = [4 8];

%plotting the gridword with wind interference
W = repmat( wind, [rowsNumber,1] ); 
figure;
imagesc(1:columnsNumber, 1:rowsNumber, W);
colormap(jet(length(unique(wind'))));
colorbar;
hold on;
plot(inicialState(2), inicialState(1), 'o', 'MarkerSize', 10, 'MarkerFaceColor', 'k');
plot(terminalState(2), terminalState(1), 'x', 'MarkerSize', 10, 'MarkerFaceColor', 'k');

%%
%defining the maximum number of EPISODEs
MAX_EPISODE = 10e3;

%defining the constant step-size parameter
alpha = 0.1;

%%
%choosing the learning algorithm
if(strcmp(algorithm,'sarsa')) 
    %applying Sarsa algorithm
    [Q, ets, numberOfStaps4Episode, actions10e3] = sarsa_algorithm(alpha, rowsNumber, columnsNumber, inicialState, terminalState, wind, MAX_EPISODE);
else
    if(strcmp(algorithm,'q-learning'))
        %aplying Q-learning algorithm
        [Q, ets, numberOfStaps4Episode, actions10e3] = q_learning_algorithm(alpha, rowsNumber, columnsNumber, inicialState, terminalState, wind, MAX_EPISODE);
    end
end
%%
pol_pi = zeros(rowsNumber, columnsNumber);
V = zeros(rowsNumber,columnsNumber); 
for row = 1:rowsNumber
  for column = 1:columnsNumber
    as = sub2ind([rowsNumber, columnsNumber], row, column); 
    [V(row,column),pol_pi(row,column)] = max(Q(as,:)); 
  end
end

plot_policy_in_gridworld(pol_pi, rowsNumber, columnsNumber, inicialState, terminalState, wind);
title( 'policy (1=>up,2=>down,3=>right,4=>left,5=>NW,6=>NE,7=>SE,8=>SW)' ); 
sprintf('wgw_w_kings_policy_nE_%d',MAX_EPISODE);

figure; imagesc( V ); colorbar; 
title( 'state value function' ); 
sprintf('wgw_w_kings_state_value_fn_nE_%d',MAX_EPISODE);

figure; plot( 1:length(ets), ets, '-x' ); wgw_w_kings_ets = ets;