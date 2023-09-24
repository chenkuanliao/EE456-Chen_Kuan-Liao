% loading the data
load('Two_moons_overlap.mat');

% I will set the weight to small values
weights = randi([100, 999], 1, 2) * 0.00001;

% I will set the bias to 0 initially 
bias = 0;

% I will set the learning rate to 0.001 initially
learning_rate = 0.001;

% initialize error flag
error_flag = true;

% figure for plotting erros
figure;
hold on;

% variables for error plotting
iteration = [];
iteration_count = 0;
error_value = 0;
error = [];

count = 0;

% keep updating the weights and bias while there is an error
while error_flag == true
    count = count + 1;
    iteration_count = iteration_count + 1;
    iteration(iteration_count) = iteration_count;
    error_value = 0;
    error_flag = false;
    % for each training vector and target output
    for i = 1:1000
        % calcuate the weight sum
        weight_sum = weights(1) * X(i, 1) + weights(2) * X(i, 2) + bias;

        % apply the activation function
        output = my_activation(weight_sum);
    
        % update weights and bias
        if output ~= Y(i)
            error_flag = true;
            weights(1) = weights(1) + learning_rate*(Y(i)-output)*X(i, 1);
            weights(2) = weights(2) + learning_rate*(Y(i)-output)*X(i, 2);
            bias = bias + learning_rate*(Y(i)-output);

            error_value= error_value + abs(Y(i)-output);
        end
    end
    error(iteration_count) = error_value;

    % Setting the limit to 1000 rounds of training
    if count == 1000
        break;
    end
end

% Create the plot for error
plot(iteration, error);

% Add labels to the axes
xlabel('Iteration');
ylabel('Error');

% Add a title to the plot
title('Error vs. Iteration');

% Plotting the two moons
figure;
hold on;
scatter(X(Y == 1, 1), X(Y == 1, 2), 'blue', 'Marker', 'o');
scatter(X(Y == -1, 1), X(Y == -1, 2), 'red', 'Marker', 'o');

% Plotting the decision boundary
x = linspace(-15, 25, 100);
y = ((-x*weights(1))/weights(2));

%plot(x_boundary, y_boundary, 'g', 'LineWidth', 2, 'DisplayName', 'Decision Boundary');
plot(x, y, 'green', 'LineWidth', 2);

title('Perceptron Decision Boundary');
grid on;
hold off


function activation_output = my_activation(x)
    % I will set the threshold to 1
    threshold = 1;

    if x > threshold
        activation_output = 1;
    else
        activation_output = -1;
    end
end

