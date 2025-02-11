function plot_generator_data(mpc, delta_store, omega_store, Pe_store)
    %% Relative swing angle
    Relative_delta = delta_store(2,:) - delta_store(1,:);

    % Plot figure
    figure;

    if size(mpc.gen, 1) == 2
        % Subplot 1: Delta values
        subplot(2,2,1);
        plot(delta_store(1,:), 'DisplayName', '\delta_1');
        hold on;
        plot(delta_store(2,:), 'DisplayName', '\delta_2');
        hold off;
        xlabel('Time Steps');
        ylabel('Delta (\delta)');
        title('Delta Values');
        legend('show');
        grid on;

        % Subplot 2: Omega values
        subplot(2,2,2);
        plot(omega_store(1,:), 'DisplayName', '\omega_1');
        hold on;
        plot(omega_store(2,:), 'DisplayName', '\omega_2');
        hold off;
        xlabel('Time Steps');
        ylabel('Omega (\omega)');
        title('Omega Values');
        legend('show');
        grid on;

        % Subplot 3: Relative swing angle
        subplot(2,2,3);
        plot(Relative_delta, 'DisplayName', 'Relative \Delta (\delta_2 - \delta_1)');
        xlabel('Time Steps');
        ylabel('Relative Delta (\delta)');
        title('Relative Swing Angle');
        legend('show');
        grid on;

        % Subplot 4: Pe values
        subplot(2,2,4);
        plot(Pe_store(1,:), 'DisplayName', 'Pe_1');
        hold on;
        plot(Pe_store(2,:), 'DisplayName', 'Pe_2');
        hold off;
        xlabel('Time Steps');
        ylabel('Pe');
        title('Pe Values');
        legend('show');
        grid on;

    elseif size(mpc.gen, 1) == 3
        % Subplot 1: Delta values
        subplot(2,2,1);
        plot(delta_store(1,:), 'DisplayName', '\delta_1');
        hold on;
        plot(delta_store(2,:), 'DisplayName', '\delta_2');
        plot(delta_store(3,:), 'DisplayName', '\delta_3');
        hold off;
        xlabel('Time Steps');
        ylabel('Delta (\delta)');
        title('Delta Values');
        legend('show');
        grid on;

        % Subplot 2: Omega values
        subplot(2,2,2);
        plot(omega_store(1,:), 'DisplayName', '\omega_1');
        hold on;
        plot(omega_store(2,:), 'DisplayName', '\omega_2');
        plot(omega_store(3,:), 'DisplayName', '\omega_3');
        hold off;
        xlabel('Time Steps');
        ylabel('Omega (\omega)');
        title('Omega Values');
        legend('show');
        grid on;

        % Subplot 3: Relative swing angle
        subplot(2,2,3);
        plot(Relative_delta, 'DisplayName', 'Relative \Delta (\delta_2 - \delta_1)');
        xlabel('Time Steps');
        ylabel('Relative Delta (\delta)');
        title('Relative Swing Angle');
        legend('show');
        grid on;

        % Subplot 4: Pe values
        subplot(2,2,4);
        plot(Pe_store(1,:), 'DisplayName', 'Pe_1');
        hold on;
        plot(Pe_store(2,:), 'DisplayName', 'Pe_2');
        plot(Pe_store(3,:), 'DisplayName', 'Pe_3');
        hold off;
        xlabel('Time Steps');
        ylabel('Pe');
        title('Pe Values');
        legend('show');
        grid on;
    else
        disp('This function supports only systems with 2 or 3 generators.');
    end
end
