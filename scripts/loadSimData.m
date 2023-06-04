simData = load("SimData.mat");

rigidBody = simData.Simulationsdaten_100Sekunden_Flug.States.RigidBody_States;

u = rigidBody.Translation_States.VEL_K_G_e_b.u_K_G_e_b;
v = rigidBody.Translation_States.VEL_K_G_e_b.v_K_G_e_b;
w = rigidBody.Translation_States.VEL_K_G_e_b.w_K_G_e_b;

q0 = rigidBody.Attitude_States.ATT_Quat.q0;
q1 = rigidBody.Attitude_States.ATT_Quat.q1;
q2 = rigidBody.Attitude_States.ATT_Quat.q2;
q3 = rigidBody.Attitude_States.ATT_Quat.q3;

h = rigidBody.Position_States.POS_G_WGS84.h_WGS84;
lambda = rigidBody.Position_States.POS_G_WGS84.lambda_WGS84;
phi = rigidBody.Position_States.POS_G_WGS84.phi_WGS84;

rot_x = rigidBody.Rotation_States.ROT_K_ib_b.ROTx_K_ib_b;
rot_y = rigidBody.Rotation_States.ROT_K_ib_b.ROTy_K_ib_b;
rot_z = rigidBody.Rotation_States.ROT_K_ib_b.ROTz_K_ib_b;
