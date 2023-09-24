% loading the data
load('Two_moons_overlap3.mat');

% I will set the hidden weights to very small values
w_hidden = randi([100, 999], 2, 3) * 0.0000001;

% I will set the hidden bias to 1 initially
b_hidden = randi([100, 999], 3, 1) * 0.0000001;

% I will set the learning rate to 0.05
learning_rate = 0.005;

% I will run the training for 100 rounds
rounds = 10;

% variables for error plotting
iteration = [];
error_value = 0;
error = [];

for round = 1:rounds
    iteration(round) = round;
    error_value = 0;
    for i = 1:1000
        % sum up the inputs for each hidden neurons (z)
        z1in = w_hidden(1, 1) * X(i, 1) + w_hidden(2, 1) * X(i, 2) + b_hidden(1);
        z2in = w_hidden(1, 2) * X(i, 1) + w_hidden(2, 2) * X(i, 2) + b_hidden(2);
        z3in = w_hidden(1, 3) * X(i, 1) + w_hidden(2, 3) * X(i, 2) + b_hidden(3);

        % calculate the output for each hidden neurons (z)
        z1out = my_activation(z1in);
        z2out = my_activation(z2in);
        z3out = my_activation(z3in);
    
        % get the majority value => if 1 then is class 1
        y1out = my_majority(z1out, z2out, z3out);

        % use the and logic gate => if 1 then is class 2
        y2out = my_and(z1out, z2out, z3out);

        % interpret the output
        if y1out == 1 && y2out == 0
            yout = 1;
        elseif y1out == 0 && y2out == 1
            yout = -1;
        else
            yout = 0;
        end

        % update the weights and bias if needed
        if yout ~= Y(i)
            error_value = error_value + 1;
            if Y(i) == 1
                % decide which weight and bias to update
                target1 = false;
                target2 = false;
                target3 = false;

                abs1 = abs(z1in);
                abs2 = abs(z2in);
                abs3 = abs(z3in);
       
                minimum = my_min(abs1, abs2, abs3);

                if abs1 == minimum
                    target1 = true;
                end
                if abs2 == minimum
                    target2 = true;
                end
                if abs3 == minimum
                    target3 = true;
                end

                % update
                if target1 == true
                    w_hidden(1, 1) = w_hidden(1, 1) + learning_rate*(Y(i)-z1in)*X(i, 1);
                    w_hidden(2, 1) = w_hidden(2, 1) + learning_rate*(Y(i)-z1in)*X(i, 2);
                    b_hidden(1) = b_hidden(1) + learning_rate*(Y(i)-z1in);
                end
                if target2 == true
                    w_hidden(1, 2) = w_hidden(1, 2) + learning_rate*(Y(i)-z2in)*X(i, 1);
                    w_hidden(2, 2) = w_hidden(2, 2) + learning_rate*(Y(i)-z2in)*X(i, 2);
                    b_hidden(2) = b_hidden(2) + learning_rate*(Y(i)-z2in);
                end
                if target3 == true
                    w_hidden(1, 3) = w_hidden(1, 3) + learning_rate*(Y(i)-z3in)*X(i, 1);
                    w_hidden(2, 3) = w_hidden(2, 3) + learning_rate*(Y(i)-z3in)*X(i, 2);
                    b_hidden(3) = b_hidden(3) + learning_rate*(Y(i)-z3in);
                end

            else
                % decide which weight and bias to update
                target1 = false;
                target2 = false;
                target3 = false;

                if z1in > 0
                    target1 = true;
                end
                if z2in > 0
                    target2 = true;
                end
                if z3in > 0
                    target3 = true;
                end

                % update
                if target1 == true
                    w_hidden(1, 1) = w_hidden(1, 1) + learning_rate*(Y(i)-z1in)*X(i, 1);
                    w_hidden(2, 1) = w_hidden(2, 1) + learning_rate*(Y(i)-z1in)*X(i, 2);
                    b_hidden(1) = b_hidden(1) + learning_rate*(Y(i)-z1in);
                end
                if target2 == true
                    w_hidden(1, 2) = w_hidden(1, 2) + learning_rate*(Y(i)-z2in)*X(i, 1);
                    w_hidden(2, 2) = w_hidden(2, 2) + learning_rate*(Y(i)-z2in)*X(i, 2);
                    b_hidden(2) = b_hidden(2) + learning_rate*(Y(i)-z2in);
                end
                if target3 == true
                    w_hidden(1, 3) = w_hidden(1, 3) + learning_rate*(Y(i)-z3in)*X(i, 1);
                    w_hidden(2, 3) = w_hidden(2, 3) + learning_rate*(Y(i)-z3in)*X(i, 2);
                    b_hidden(3) = b_hidden(3) + learning_rate*(Y(i)-z3in);
                end
            end
        end
    end
    error(round) = error_value;
end

% Create the plot for error
plot(iteration, error);

% Add labels to the axes
xlabel('Iteration');
ylabel('Error');

% Add a title to the plot
title('Error vs. Iteration');

% Plotting the decision boundary for z1
figure;
hold on;
scatter(X(Y == 1, 1), X(Y == 1, 2), 'blue', 'Marker', 'o');
scatter(X(Y == -1, 1), X(Y == -1, 2), 'red', 'Marker', 'o');

x1 = linspace(-15, 25, 100);
y1 = ((-x1*w_hidden(1, 1))/w_hidden(2, 1));
plot(x1, y1, 'green', 'LineWidth', 2);

x2 = linspace(-15, 25, 100);
y2 = ((-x2*w_hidden(1, 2))/w_hidden(2, 2));
plot(x2, y2, 'red', 'LineWidth', 2);

x3 = linspace(-15, 25, 100);
y3 = ((-x3*w_hidden(1, 3))/w_hidden(2, 3));
plot(x3, y3, 'blue', 'LineWidth', 2);

xlim([-20, 30]);
ylim([-15, 15]);
title('Perceptron Decision Boundary');
grid on;



function activation_output = my_activation(x)
    % I will set the threshold to 1
    threshold = 1;

    if x > threshold
        activation_output = 1;
    else
        activation_output = -1;
    end
end

function minout = my_min(x, y, z)
    minout = x;
    if y < minout
        minout = y;
    end
    if z < minout
        minout = z;
    end
end

function majority = my_majority(x, y, z)
    one = 0;
    n_one = 0;

    if x == 1
        one = one + 1;
    else
        n_one = n_one + 1;
    end
    if y == 1
        one = one + 1;
    else
        n_one = n_one + 1;
    end
    if z == 1
        one = one + 1;
    else
        n_one = n_one + 1;
    end

    if one > n_one
        majority = 1;
    else
        majority = 0;
    end
end

function out_and = my_and(x, y, z)
    if x == -1 && y == -1 && z == -1
        out_and = 1;
    else
        out_and = 0;
    end
end






