% Intrinsic and Extrinsic Camera Parameters
%
% This script file can be directly executed under Matlab to recover the camera intrinsic and extrinsic parameters.
% IMPORTANT: This file contains neither the structure of the calibration objects nor the image coordinates of the calibration points.
%            All those complementary variables are saved in the complete matlab data file Calib_Results.mat.
% For more information regarding the calibration model visit http://www.vision.caltech.edu/bouguetj/calib_doc/


%-- Focal length:
fc = [ 826.900855083050150 ; 830.258761481743930 ];

%-- Principal point:
cc = [ 315.680282670517840 ; 199.065316401087220 ];

%-- Skew coefficient:
alpha_c = 0.000000000000000;

%-- Distortion coefficients:
kc = [ -0.044951219356957 ; -0.011501362964221 ; -0.025426635662350 ; -0.000528580027275 ; 0.000000000000000 ];

%-- Focal length uncertainty:
fc_error = [ 12.105485909886273 ; 10.496269836239296 ];

%-- Principal point uncertainty:
cc_error = [ 7.356595111248702 ; 13.173776202996125 ];

%-- Skew coefficient uncertainty:
alpha_c_error = 0.000000000000000;

%-- Distortion coefficients uncertainty:
kc_error = [ 0.055204443219570 ; 0.453152739087036 ; 0.004404880597078 ; 0.003634612010030 ; 0.000000000000000 ];

%-- Image size:
nx = 640;
ny = 480;


%-- Various other variables (may be ignored if you do not use the Matlab Calibration Toolbox):
%-- Those variables are used to control which intrinsic parameters should be optimized

n_ima = 18;						% Number of calibration images
est_fc = [ 1 ; 1 ];					% Estimation indicator of the two focal variables
est_aspect_ratio = 1;				% Estimation indicator of the aspect ratio fc(2)/fc(1)
center_optim = 1;					% Estimation indicator of the principal point
est_alpha = 0;						% Estimation indicator of the skew coefficient
est_dist = [ 1 ; 1 ; 1 ; 1 ; 0 ];	% Estimation indicator of the distortion coefficients


%-- Extrinsic parameters:
%-- The rotation (omc_kk) and the translation (Tc_kk) vectors for every calibration image and their uncertainties

%-- Image #1:
omc_1 = [ -2.976897e+00 ; 1.146735e-01 ; -7.498294e-02 ];
Tc_1  = [ -6.558501e+02 ; 1.053923e+03 ; 5.343541e+03 ];
omc_error_1 = [ 1.834036e-02 ; 3.176362e-03 ; 2.657158e-02 ];
Tc_error_1  = [ 4.818875e+01 ; 8.410343e+01 ; 7.963376e+01 ];

%-- Image #2:
omc_2 = [ -2.933862e+00 ; 1.743402e-01 ; 3.914936e-01 ];
Tc_2  = [ -3.406236e+02 ; 1.018090e+03 ; 5.090015e+03 ];
omc_error_2 = [ 1.647665e-02 ; 4.119399e-03 ; 2.314195e-02 ];
Tc_error_2  = [ 4.646548e+01 ; 8.002304e+01 ; 7.363308e+01 ];

%-- Image #3:
omc_3 = [ -2.824105e+00 ; 2.823904e-02 ; -5.359861e-01 ];
Tc_3  = [ -1.011828e+03 ; 1.044772e+03 ; 5.297642e+03 ];
omc_error_3 = [ 1.602879e-02 ; 5.292245e-03 ; 1.824465e-02 ];
Tc_error_3  = [ 4.812606e+01 ; 8.404428e+01 ; 7.961290e+01 ];

%-- Image #4:
omc_4 = [ -2.756075e+00 ; -3.354083e-02 ; -8.620865e-01 ];
Tc_4  = [ -7.916692e+02 ; 1.016652e+03 ; 5.061459e+03 ];
omc_error_4 = [ 1.577859e-02 ; 7.889289e-03 ; 1.498757e-02 ];
Tc_error_4  = [ 4.619421e+01 ; 8.030389e+01 ; 7.680535e+01 ];

%-- Image #5:
omc_5 = [ -2.850398e+00 ; 5.473382e-02 ; -3.885274e-01 ];
Tc_5  = [ -9.131836e+02 ; 1.040449e+03 ; 5.277874e+03 ];
omc_error_5 = [ 1.601382e-02 ; 4.472432e-03 ; 1.982375e-02 ];
Tc_error_5  = [ 4.775016e+01 ; 8.343426e+01 ; 7.914100e+01 ];

%-- Image #6:
omc_6 = [ -2.861142e+00 ; 7.713107e-02 ; -2.758965e-01 ];
Tc_6  = [ -5.857437e+02 ; 9.487088e+02 ; 3.953048e+03 ];
omc_error_6 = [ 1.486967e-02 ; 3.666965e-03 ; 1.818974e-02 ];
Tc_error_6  = [ 3.583892e+01 ; 6.217297e+01 ; 5.900649e+01 ];

%-- Image #7:
omc_7 = [ -2.850132e+00 ; 1.714032e-01 ; 2.560940e-01 ];
Tc_7  = [ -4.299002e+02 ; 9.415278e+02 ; 4.065011e+03 ];
omc_error_7 = [ 1.464318e-02 ; 3.310877e-03 ; 1.933848e-02 ];
Tc_error_7  = [ 3.712055e+01 ; 6.363157e+01 ; 5.979026e+01 ];

%-- Image #8:
omc_8 = [ -2.827805e+00 ; 5.704885e-02 ; -4.579073e-01 ];
Tc_8  = [ -1.663636e+03 ; 1.094977e+03 ; 5.505656e+03 ];
omc_error_8 = [ 1.688292e-02 ; 4.810556e-03 ; 2.180010e-02 ];
Tc_error_8  = [ 5.012068e+01 ; 8.840511e+01 ; 8.519288e+01 ];

%-- Image #9:
omc_9 = [ -2.852083e+00 ; 1.401881e-01 ; 5.442277e-02 ];
Tc_9  = [ -5.479568e+02 ; 1.193199e+03 ; 5.462473e+03 ];
omc_error_9 = [ 1.634364e-02 ; 3.606462e-03 ; 2.154778e-02 ];
Tc_error_9  = [ 4.974027e+01 ; 8.549956e+01 ; 8.261551e+01 ];

%-- Image #10:
omc_10 = [ -2.838667e+00 ; 3.844088e-02 ; -4.815201e-01 ];
Tc_10  = [ -3.963329e+02 ; 9.203258e+02 ; 3.636261e+03 ];
omc_error_10 = [ 1.532722e-02 ; 5.302531e-03 ; 1.665782e-02 ];
Tc_error_10  = [ 3.311221e+01 ; 5.724403e+01 ; 5.427928e+01 ];

%-- Image #11:
omc_11 = [ -3.068939e+00 ; 7.584840e-02 ; -2.239008e-01 ];
Tc_11  = [ -8.852841e+02 ; 1.198506e+03 ; 4.933048e+03 ];
omc_error_11 = [ 1.891394e-02 ; 3.384832e-03 ; 2.904623e-02 ];
Tc_error_11  = [ 4.501399e+01 ; 7.847990e+01 ; 7.287073e+01 ];

%-- Image #12:
omc_12 = [ -2.672941e+00 ; 3.563924e-01 ; 7.761316e-01 ];
Tc_12  = [ -3.985903e+02 ; 9.870392e+02 ; 5.976801e+03 ];
omc_error_12 = [ 1.583417e-02 ; 8.112291e-03 ; 1.628877e-02 ];
Tc_error_12  = [ 5.437614e+01 ; 9.455551e+01 ; 8.137764e+01 ];

%-- Image #13:
omc_13 = [ -2.931549e+00 ; 4.395326e-02 ; -3.398272e-01 ];
Tc_13  = [ -7.144645e+02 ; 1.214942e+03 ; 5.244373e+03 ];
omc_error_13 = [ 1.679626e-02 ; 4.296149e-03 ; 2.202327e-02 ];
Tc_error_13  = [ 4.772533e+01 ; 8.277896e+01 ; 7.837695e+01 ];

%-- Image #14:
omc_14 = [ -2.746917e+00 ; 3.607367e-01 ; 1.172297e+00 ];
Tc_14  = [ -2.566531e+02 ; 1.067914e+03 ; 5.985997e+03 ];
omc_error_14 = [ 1.632483e-02 ; 1.123044e-02 ; 1.495455e-02 ];
Tc_error_14  = [ 5.449601e+01 ; 9.498318e+01 ; 7.927981e+01 ];

%-- Image #15:
omc_15 = [ -2.858263e+00 ; 3.050652e-01 ; 8.906071e-01 ];
Tc_15  = [ -3.817285e+02 ; 1.069522e+03 ; 5.933478e+03 ];
omc_error_15 = [ 1.691769e-02 ; 8.777296e-03 ; 1.738834e-02 ];
Tc_error_15  = [ 5.412168e+01 ; 9.407938e+01 ; 8.058595e+01 ];

%-- Image #16:
omc_16 = [ -2.815120e+00 ; -1.217234e-01 ; -1.136571e+00 ];
Tc_16  = [ -1.524932e+02 ; 8.892336e+02 ; 4.854264e+03 ];
omc_error_16 = [ 1.546821e-02 ; 1.106563e-02 ; 1.477424e-02 ];
Tc_error_16  = [ 4.406314e+01 ; 7.675618e+01 ; 7.442595e+01 ];

%-- Image #17:
omc_17 = [ -2.827973e+00 ; -1.122872e-01 ; -1.111105e+00 ];
Tc_17  = [ -1.114926e+02 ; 7.752688e+02 ; 4.119619e+03 ];
omc_error_17 = [ 1.529974e-02 ; 1.084952e-02 ; 1.469749e-02 ];
Tc_error_17  = [ 3.736817e+01 ; 6.508771e+01 ; 6.376609e+01 ];

%-- Image #18:
omc_18 = [ -2.639243e+00 ; 4.149508e-01 ; 1.100678e+00 ];
Tc_18  = [ -2.454987e+02 ; 1.027756e+03 ; 6.014956e+03 ];
omc_error_18 = [ 1.581851e-02 ; 1.085259e-02 ; 1.471637e-02 ];
Tc_error_18  = [ 5.468786e+01 ; 9.535542e+01 ; 7.952533e+01 ];

