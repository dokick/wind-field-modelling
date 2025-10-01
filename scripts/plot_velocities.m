%% Vertikale Geschwindigkeit

close all;

hold on;

clear V_K_w V_W_w;
V_K_w(:, 1) = sim_logs{2}.Values.RigidBody_States.Translation_States.VEL_K_G_e_b.w_K_G_e_b.Time;
V_K_w(:, 2) = sim_logs{2}.Values.RigidBody_States.Translation_States.VEL_K_G_e_b.w_K_G_e_b.Data;
V_K_w = V_K_w(1:2:end, :);  % sample time of V_K is 0.004

V_W_w(:, 1) = sim_logs.getElement('<r4VW_w_g>').Values.Time;
V_W_w(:, 2) = sim_logs.getElement('<r4VW_w_g>').Values.Data;

ax = gca;

yyaxis left;
ylabel("Windgeschwindigkeit (w_g) [m/s]", "FontSize", 15);
ax.YAxis(1).Color = "black";
plot(V_W_w(:, 1), V_W_w(:, 2), "-.k", "DisplayName", "Windgeschwindigkeit [m/s]");

yyaxis right;
ylabel("Bahngeschwindigkeit (V_{K_w}) [m/s]", "FontSize", 15);
ax.YAxis(2).Color = "black";
plot(V_K_w(:, 1), V_K_w(:, 2), "k", "DisplayName", "Bahngeschwindigkeit [m/s]");

title("vertikaler Geschwindigkeitsverlauf des Testfluges", "FontSize", 15);
xlabel("Zeit [s]", "FontSize", 15)
legend();
grid on;

hold off;

%% Longitudinale Geschwindigkeit
close all;

hold on;

clear V_K_u V_W_u;
V_K_u(:, 1) = sim_logs{2}.Values.RigidBody_States.Translation_States.VEL_K_G_e_b.u_K_G_e_b.Time;
V_K_u(:, 2) = sim_logs{2}.Values.RigidBody_States.Translation_States.VEL_K_G_e_b.u_K_G_e_b.Data;
V_K_u = V_K_u(1:2:end, :);  % sample time of V_K is 0.004

V_W_u(:, 1) = sim_logs.getElement('<r4VW_u_g>').Values.Time;
V_W_u(:, 2) = sim_logs.getElement('<r4VW_u_g>').Values.Data;

ax = gca;

yyaxis left;
ylabel("Windgeschwindigkeit (u_g) [m/s]", "FontSize", 15);
ax.YAxis(1).Color = "black";
plot(V_W_u(:, 1), V_W_u(:, 2), "-.k", "DisplayName", "Windgeschwindigkeit [m/s]");

yyaxis right;
ylabel("Bahngeschwindigkeit (V_{K_u}) [m/s]", "FontSize", 15);
ax.YAxis(2).Color = "black";
plot(V_K_u(:, 1), V_K_u(:, 2), "k", "DisplayName", "Bahngeschwindigkeit [m/s]");

title("longitudinaler Geschwindigkeitsverlauf des Testfluges", "FontSize", 15);
xlabel("Zeit [s]", "FontSize", 15)
legend();
grid on;

hold off;

%% Vertikale Windgeschwindigkeit + Höhe

hold on;

clear HBar V_W_u;
HBar(:, 1) = sim_logs.getElement("HBar_in_m").Values.Time;
HBar(:, 2) = sim_logs.getElement("HBar_in_m").Values.Data;

V_W_u(:, 1) = sim_logs.getElement('<r4VW_u_g>').Values.Time;
V_W_u(:, 2) = sim_logs.getElement('<r4VW_u_g>').Values.Data;

ax = gca;

yyaxis left;
ylabel("Windgeschwindigkeit (u_g) [m/s]", "FontSize", 15);
ax.YAxis(1).Color = "black";
plot(V_W_u(:, 1), V_W_u(:, 2), "-.k", "DisplayName", "Windgeschwindigkeit [m/s]");

yyaxis right;
ylabel("Höhe (H) [m]", "FontSize", 15);
ax.YAxis(2).Color = "black";
plot(HBar(:, 1), HBar(:, 2), "k", "DisplayName", "Höhe [m]");

title("vertikale Geschwindigkeit mit Höhe", "FontSize", 15);
xlabel("Zeit [s]", "FontSize", 15)
legend();
grid on;

hold off;
