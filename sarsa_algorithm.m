function [Q, ets, numberOfStaps4Episode, actions10e3] = sarsa_algorithm(alpha, rowsNumber, columnsNumber, inicialState, terminalState, wind, MAX_EPISODE)

%%
%defining that there is no discount in the reward
gamma = 1;

%defining the epsilon of the greedy policy
epsilon = 0.1;

%defining the number of states
statesNumber = rowsNumber * columnsNumber;

%defining the number of actions in each state
actionsNumber = 4;
%[1,2,3,4]=[up,down,right,left]

%Q contains the action-value function values
Q = zeros(statesNumber,actionsNumber);

%plotting configuration of inicial Q
figure;
imagesc(zeros(rowsNumber, columnsNumber));
colorbar;
hold on;
plot(inicialState(2), inicialState(1), 'o', 'MarkerSize', 10, 'MarkerFaceColor', 'k');
plot(terminalState(2), terminalState(1), 'x', 'MarkerSize', 10, 'MarkerFaceColor', 'k');

pause;

%to count how many timesteps are taken per episode
ets = zeros(MAX_EPISODE, 1);
ts = 0;

numberOfStaps4Episode = zeros(MAX_EPISODE, 1);

actions10e3 = [];
%%
    for episode = 1:MAX_EPISODE
        fprintf('\nepisode = %d\n',episode);
        ets(episode) = ts + 1;
        
        %initializing the actual state
        actualState = inicialState;
        as = sub2ind([rowsNumber, columnsNumber], inicialState(1), inicialState(2));
        
        %choosing an action using greedy policy
        [aux, action] = max(Q(as,:));
        %changing the action in a random way
        if(rand < epsilon)
            actions = randperm(actionsNumber);
            action = actions(1);
        end
        
        %begining of the actual episode     
        while(~(actualState(1) == terminalState(1) && actualState(2) == terminalState(2)))
            ts = ts + 1;
            numberOfStaps4Episode(episode) = numberOfStaps4Episode(episode) + 1;
            [reward, nextState] = next_state_and_reward(actualState, action, wind, rowsNumber, columnsNumber, terminalState);
            ns = sub2ind([rowsNumber columnsNumber], nextState(1), nextState(2));
            %choosing an action using greedy policy
            [aux, nextAction] = max(Q(ns,:));
            %changing the action in a random way
            if(rand < epsilon)
                actions = randperm(actionsNumber);
                nextAction = actions(1);
            end
            %sarsa update
            if(~(nextState(1) == terminalState(1) && nextState(2) == terminalState(2))) %if it is not the terminal state
                Q(as,action) = Q(as,action) + alpha*( reward + gamma * Q(ns,nextAction) - Q(as,action));
            else %if it is the terminal state
                Q(as,action) = Q(as,action) + alpha*( reward + gamma - Q(as,action));
            end        
            
            if(episode == MAX_EPISODE)
                actions10e3 = [actions10e3 action];
            end
            
            %updating state-action pair
            actualState = nextState;
            as = ns;
            action = nextAction;
        end
        %end of the policy while
        
        num2act = { 'UP', 'DOWN', 'RIGHT', 'LEFT', 'NW', 'NE', 'SE', 'SW'}; 
        plot( actualState(2), actualState(1), 'o', 'MarkerFaceColor', 'g' );
        title( ['action = ',num2act(nextAction)]); 
        plot( nextState(2), nextState(1), 'o', 'MarkerFaceColor', 'k' ); drawnow;
        
    end
    %end of episode loop
end

