function [reward, nextState] = next_state_and_reward(actualState, action, wind, rowsNumber, columnsNumber, terminalState)

    row = actualState(1);
    column = actualState(2);
    windInTheColumn = wind(column);

    switch action
        case 1, %up/north
            nextState = [row - 1 - windInTheColumn, column];
        case 2, %down/south
            nextState = [row + 1 - windInTheColumn, column];
        case 3, %right/east
            nextState = [row - windInTheColumn, column + 1];
        case 4, %left/west
            nextState = [row - windInTheColumn, column - 1];
        case 5, %up and left/nw
            nextState = [row - 1 - windInTheColumn, column - 1];
        case 6, %up and rigth/ne
            nextState = [row - 1 - windInTheColumn, column + 1];
        case 7, %down and rigth/se
            nextState = [row + 1 - windInTheColumn, column + 1];
        case 8, %down and left/sw
            nextState = [row + 1- windInTheColumn, column - 1];
    end
    
    %adjusting the state, if it is outside f the grid
    if(nextState(1) < 1)
        nextState(1) = 1;
    else
        if(nextState(1) > rowsNumber)
        nextState(1) = rowsNumber;
        end
    end
    if(nextState(2) < 1)
        nextState(2) = 1;
    else
        if(nextState(2) > columnsNumber)
        nextState(2) = columnsNumber;
        end
    end
    
    %getting the reward for this state changing
    if(row == terminalState(1) && column == terminalState(2))
        reward = 0;
    else
        reward = -1;
    end
    
end

