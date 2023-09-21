% loading the data
load('Two_moons_overlap3.mat');

% I will set the hidden weights to 1 initially
% w_hidden = [1 1 1; 1 1 1];
w_hidden = [2 2 2; 2 2 2];

% I will set the hidden bias to 1 initially
b_hidden = [1; 1; 1];

% I will set the output weights to 1 initially
w_output = [1 1; 1 1; 1 1];

% I will set the output bias to 1 initially
b_output = [1; 1];

% I will set the learning rate to 0.01
learning_rate = 0.01;

% I will run the training for 100 rounds
rounds = 10000;

for round = 1:rounds
    for i = 1:1000
        % sum up the inputs for each hidden neurons (z)
        z1in = w_hidden(1, 1) * X(i, 1) + w_hidden(2, 1) * X(i, 2) + b_hidden(1);
        z2in = w_hidden(1, 2) * X(i, 1) + w_hidden(2, 2) * X(i, 2) + b_hidden(2);
        z3in = w_hidden(1, 3) * X(i, 1) + w_hidden(2, 3) * X(i, 2) + b_hidden(3);

        % calculate the output for each hidden neurons (z)
        z1out = my_activation(z1in);
        z2out = my_activation(z2in);
        z3out = my_activation(z3in);

        % sum up the inputs for each of the output neurons (y)
        y1in = w_output(1, 1) * z1out + w_output(2, 1) * z2out + w_output(3, 1) * z3out + b_output(1);
        y2in = w_output(1, 2) * z1out + w_output(2, 2) * z2out + w_output(3, 2) * z3out + b_output(2);

        %calculate the output for each of the output neurons (y)
        y1out = my_activation(y1in);
        y2out = my_activation(y2in);

        % use the AND gate to classify the class
        final_output = my_and(y1out, y2out);

        % update the weights and bias if needed
        if final_output ~= Y(i)
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
                elseif abs2 == minimum
                    target2 = true;
                elseif abs3 == minimum
                    target3 = true;
                end

                % update
                if target1 == true
                    w_hidden(1, 1) = w_hidden(1, 1) + learning_rate*(Y(i)-z1in)*X(i, 1);
                    w_hidden(2, 1) = w_hidden(2, 1) + learning_rate*(Y(i)-z1in)*X(i, 2);
                    b_hidden(1) = b_hidden(1) + learning_rate*(Y(i)-z1in);
                elseif target2 == true
                    w_hidden(1, 2) = w_hidden(1, 2) + learning_rate*(Y(i)-z2in)*X(i, 1);
                    w_hidden(2, 2) = w_hidden(2, 2) + learning_rate*(Y(i)-z2in)*X(i, 2);
                    b_hidden(2) = b_hidden(2) + learning_rate*(Y(i)-z2in);
                elseif target3 == true
                    w_hidden(1, 3) = w_hidden(1, 3) + learning_rate*(Y(i)-z3in)*X(i, 1);
                    w_hidden(2, 3) = w_hidden(2, 3) + learning_rate*(Y(i)-z3in)*X(i, 2);
                    b_hidden(3) = b_hidden(3) + learning_rate*(Y(i)-z3in);
                end

            else
                % decide which weight and bias to update
                target1 = false;
                target2 = false;
                target3 = false;

                if zin1 > 0
                    target1 = true;
                elseif zin2 > 0
                    target2 = true;
                elseif zin3 > 0
                    target3 = true;
                end

                % update
                if target1 == true
                    w_hidden(1, 1) = w_hidden(1, 1) + learning_rate*(Y(i)-z1in)*X(i, 1);
                    w_hidden(2, 1) = w_hidden(2, 1) + learning_rate*(Y(i)-z1in)*X(i, 2);
                    b_hidden(1) = b_hidden(1) + learning_rate*(Y(i)-z1in);
                elseif taret2 == true
                    w_hidden(1, 2) = w_hidden(1, 2) + learning_rate*(Y(i)-z2in)*X(i, 1);
                    w_hidden(2, 2) = w_hidden(2, 2) + learning_rate*(Y(i)-z2in)*X(i, 2);
                    b_hidden(2) = b_hidden(2) + learning_rate*(Y(i)-z2in);
                elseif target3 == true
                    w_hidden(1, 3) = w_hidden(1, 3) + learning_rate*(Y(i)-z3in)*X(i, 1);
                    w_hidden(2, 3) = w_hidden(2, 3) + learning_rate*(Y(i)-z3in)*X(i, 2);
                    b_hidden(3) = b_hidden(3) + learning_rate*(Y(i)-z3in);
                end

            end
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
y = (-x*(w_hidden(1, 1)+w_hidden(1, 2)+w_hidden(1, 3))-b_hidden(1)-b_hidden(2)-b_hidden(3)+2.5)/(w_hidden(2, 1)+w_hidden(2, 2)+w_hidden(2, 3));

%plot(x_boundary, y_boundary, 'g', 'LineWidth', 2, 'DisplayName', 'Decision Boundary');
plot(x, y, 'green', 'LineWidth', 2);

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

function minout = my_min(x, y, z)
    minout = x;
    if y < minout
        minout = y;
    end
    if z < minout
        minout = z;
    end
end

function and_out = my_and(x, y)
    if x == -1 && y == -1
        and_out = -1;
    elseif x == 1 && y == 1
        and_out = 1;
    else
        and_out = 0;
    end
end





