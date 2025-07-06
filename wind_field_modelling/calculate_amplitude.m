function [u_m, v_m, w_m] = calculate_amplitude(alt, gust_width)
    % Input:
    % [alt] = m
    % [gust_width] = m

    % Output:
    % [u_m] = m/s
    % [v_m] = m/s
    % [w_m] = m/s

    if alt < 10
        sigma_1 = 2.31;  % m/s
        sigma_2 = 1.67;  % m/s
        sigma_3 = 1.15;  % m/s
        L_1 = 21;  % m
        L_2 = 11;  % m
        L_3 = 5;  % m
    elseif alt < 20
        sigma_1 = 2.58;
        sigma_2 = 1.98;
        sigma_3 = 1.46;
        L_1 = 33;
        L_2 = 19;
        L_3 = 11;
    elseif alt < 30
        sigma_1 = 2.75;
        sigma_2 = 2.20;
        sigma_3 = 1.71;
        L_1 = 43;
        L_2 = 28;
        L_3 = 17;
    elseif alt < 40
        sigma_1 = 2.88;
        sigma_2 = 2.36;
        sigma_3 = 1.89;
        L_1 = 52;
        L_2 = 35;
        L_3 = 23;
    elseif alt < 50
        sigma_1 = 2.98;
        sigma_2 = 2.49;
        sigma_3 = 2.05;
        L_1 = 61;
        L_2 = 42;
        L_3 = 29;
    elseif alt < 60
        sigma_1 = 3.07;
        sigma_2 = 2.61;
        sigma_3 = 2.19;
        L_1 = 68;
        L_2 = 49;
        L_3 = 35;
    elseif alt < 70
        sigma_1 = 3.15;
        sigma_2 = 2.71;
        sigma_3 = 2.32;
        L_1 = 75;
        L_2 = 56;
        L_3 = 41;
    elseif alt < 80
        sigma_1 = 3.22;
        sigma_2 = 2.81;
        sigma_3 = 2.43;
        L_1 = 82;
        L_2 = 63;
        L_3 = 47;
    elseif alt < 90
        sigma_1 = 3.28;
        sigma_2 = 2.89;
        sigma_3 = 2.54;
        L_1 = 89;
        L_2 = 69;
        L_3 = 53;
    elseif alt < 100
        sigma_1 = 3.33;
        sigma_2 = 2.97;
        sigma_3 = 2.64;
        L_1 = 95;
        L_2 = 75;
        L_3 = 59;
    elseif alt < 200
        sigma_1 = 3.72;
        sigma_2 = 3.53;
        sigma_3 = 3.38;
        L_1 = 149;
        L_2 = 134;
        L_3 = 123;
    elseif alt < 304.8
        sigma_1 = 3.95;
        sigma_2 = 3.95;
        sigma_3 = 3.95;
        L_1 = 196;
        L_2 = 190;
        L_3 = 192;
    elseif alt < 400
        sigma_1 = 4.39;
        sigma_2 = 4.39;
        sigma_3 = 4.39;
        L_1 = 300;
        L_2 = 300;
        L_3 = 300;
    elseif alt < 500
        sigma_1 = 4.39;
        sigma_2 = 4.39;
        sigma_3 = 4.39;
        L_1 = 300;
        L_2 = 300;
        L_3 = 300;
    elseif alt < 600
        sigma_1 = 4.39;
        sigma_2 = 4.39;
        sigma_3 = 4.39;
        L_1 = 300;
        L_2 = 300;
        L_3 = 300;
    elseif alt < 700
        sigma_1 = 4.39;
        sigma_2 = 4.39;
        sigma_3 = 4.39;
        L_1 = 300;
        L_2 = 300;
        L_3 = 300;
    elseif alt < 762
        sigma_1 = 4.39;
        sigma_2 = 4.39;
        sigma_3 = 4.39;
        L_1 = 300;
        L_2 = 300;
        L_3 = 300;
    elseif alt < 800
        sigma_1 = 5.70;
        sigma_2 = 5.70;
        sigma_3 = 5.70;
        L_1 = 533;
        L_2 = 533;
        L_3 = 533;
    elseif alt < 900
        sigma_1 = 5.70;
        sigma_2 = 5.70;
        sigma_3 = 5.70;
        L_1 = 533;  % m
        L_2 = 533;  % m
        L_3 = 533;  % m
    elseif alt < 1000
        light_turbulence = 0.776;
        moderate_turbulence = 0.199;
        severe_turbulence = 0.025;
        probability = rand;
        if probability <= light_turbulence
            sigma_1 = 0.17;
            sigma_2 = 0.17;
            sigma_3 = 0.14;
        elseif probability <= light_turbulence + moderate_turbulence
            sigma_1 = 1.65;
            sigma_2 = 1.65;
            sigma_3 = 1.36;
        else  % severe turbulence
            sigma_1 = 5.70;
            sigma_2 = 5.70;
            sigma_3 = 4.67;
        end
        L_1 = 832;  % m
        L_2 = 832;  % m
        L_3 = 624;  % m
    elseif alt < 2000
        light_turbulence = 0.8910;
        moderate_turbulence = 0.0979;
        severe_turbulence = 0.0111;
        probability = rand;
        if probability <= light_turbulence
            sigma_1 = 0.17;
            sigma_2 = 0.17;
            sigma_3 = 0.14;
        elseif probability <= light_turbulence + moderate_turbulence
            sigma_1 = 1.65;
            sigma_2 = 1.65;
            sigma_3 = 1.43;
        else  % severe turbulence
            sigma_1 = 5.80;
            sigma_2 = 5.80;
            sigma_3 = 4.75;
        end
        L_1 = 902;  % m
        L_2 = 902;  % m
        L_3 = 831;  % m
    else  % < 4000
        light_turbulence = 0.9199;
        moderate_turbulence = 0.0738;
        severe_turbulence = 0.0063;
        probability = rand;
        if probability <= light_turbulence
            sigma_1 = 0.20;
            sigma_2 = 0.20;
            sigma_3 = 0.17;
        elseif probability <= light_turbulence + moderate_turbulence
            sigma_1 = 2.04;
            sigma_2 = 2.04;
            sigma_3 = 1.68;
        else  % severe turbulence
            sigma_1 = 6.24;
            sigma_2 = 6.24;
            sigma_3 = 5.13;
        end
        L_1 = 1040;  % m
        L_2 = 1040;  % m
        L_3 = 972;  % m
    end

    c_0 = 2.473886;
    c_1 = 0.9290348;
    c_2 = -0.54107229;
    c_3 = -0.18495605;
    c_4 = 0.0300112814;

    x_u_wolog = gust_width / L_1;
    if 0.01 <= x_u_wolog && x_u_wolog < 5
        x_u = log10(x_u_wolog);
        u_m = sigma_1 * (c_0 + c_1*x_u + c_2*x_u^2 + c_3*x_u^3 + c_4*x_u^4);
    else  % 5 <= d_m/L <= 10
        u_m = sigma_1 * 2.80247;
    end

    x_v_wolog = gust_width / L_2;
    if 0.01 <= x_v_wolog && x_v_wolog < 5
        x_v = log10(x_v_wolog);
        v_m = sigma_2 * (c_0 + c_1*x_v + c_2*x_v^2 + c_3*x_v^3 + c_4*x_v^4);
    else  % 5 <= d_m/L <= 10
        v_m = sigma_2 * 2.80247;
    end

    x_w_wolog = gust_width / L_3;
    if 0.01 <= x_w_wolog && x_w_wolog < 5
        x_w = log10(x_w_wolog);
        w_m = sigma_3 * (c_0 + c_1*x_w + c_2*x_w^2 + c_3*x_w^3 + c_4*x_w^4);
    else  % 5 <= d_m/L <= 10
        w_m = sigma_3 * 2.80247;
    end
end
