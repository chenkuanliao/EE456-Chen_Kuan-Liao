% loading the data
load('Two_moons_no_overlap.mat');

% I will set the weight to 0 initially
weights = [0 0];

% I will set the bias to 0 initially 
bias = 0;

% I will set the learning rate to 0.01 initially
learning_rate = 0.01;

% initialize error flag
error_flag = true;

% keep updating the weights and bias while there is an error
while error_flag == true
    error_flag = false;
    % for each training vector and target output
    for i = 1:1000
        % calcuate the weight sum
        weight_sum = weights(1) * X(i, 1) + weights(2) * X(i, 2);

        % apply the activation function
        output = my_activation(weight_sum);
    
        % update weights and bias
        if output ~= Y(i)
            error_flag = true;
            weights(1) = weights(1) + learning_rate*Y(i)*X(i, 1);
            weights(2) = weights(2) + learning_rate*Y(i)*X(i, 2);
            bias = bias + learning_rate*Y(i);
        end
    end
end


% Plotting the two moons
figure;
hold on;
scatter(X(Y == 1, 1), X(Y == 1, 2), 'blue', 'Marker', 'o');
scatter(X(Y == -1, 1), X(Y == -1, 2), 'red', 'Marker', 'o');

% Plotting the decision boundary
x = linspace(-15, 25, 100);
y = -((x*weights(1))/weights(2));

%plot(x_boundary, y_boundary, 'g', 'LineWidth', 2, 'DisplayName', 'Decision Boundary');
plot(x, y, 'green', 'LineWidth', 2);

% Display the final weights and bias
fprintf('Final weights: w1 = %.4f, w2 = %.4f\n', weights(1), weights(2));
fprintf('Final bias: b = %.4f\n', bias);

title('Perceptron Decision Boundary');
grid on;
hold off


function activation_output = my_activation(x)
    % I will set the threshold to 5 
    threshold = 5;

    if x > threshold
        activation_output = 1;
    else
        activation_output = -1;
    end
end

    













