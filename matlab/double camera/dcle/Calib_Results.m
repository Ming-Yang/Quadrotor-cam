% Intrinsic and Extrinsic Camera Parameters
%
% This script file can be directly executed under Matlab to recover the camera intrinsic and extrinsic parameters.
% IMPORTANT: This file contains neither the structure of the calibration objects nor the image coordinates of the calibration points.
%            All those complementary variables are saved in the complete matlab data file Calib_Results.mat.
% For more information regarding the calibration model visit http://www.vision.caltech.edu/bouguetj/calib_doc/


%-- Focal length:
fc = [ 817.555583878962920 ; 822.098979948259630 ];

%-- Principal point:
cc = [ 323.743228619032950 ; 199.422403095286200 ];

%-- Skew coefficient:
alpha_c = 0.000000000000000;

%-- Distortion coefficients:
kc = [ -0.035041044194725 ; -0.248501970320815 ; -0.023944348737264 ; 0.000607543939864 ; 0.000000000000000 ];

%-- Focal length uncertainty:
fc_error = [ 12.782812638766558 ; 11.101001592083115 ];

%-- Principal point uncertainty:
cc_error = [ 8.439411547070622 ; 13.339551582638672 ];

%-- Skew coefficient uncertainty:
alpha_c_error = 0.000000000000000;

%-- Distortion coefficients uncertainty:
kc_error = [ 0.044275211198864 ; 0.247356226156283 ; 0.004250011873763 ; 0.003925079527767 ; 0.000000000000000 ];

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
omc_1 = [ -2.972406e+00 ; 1.120431e-01 ; -7.759122e-02 ];
Tc_1  = [ -2.834520e+02 ; 1.046482e+03 ; 5.310621e+03 ];
omc_error_1 = [ 1.835024e-02 ; 3.458927e-03 ; 2.688431e-02 ];
Tc_error_1  = [ 5.548795e+01 ; 8.517211e+01 ; 8.329694e+01 ];

%-- Image #2:
omc_2 = [ -2.931539e+00 ; 1.719009e-01 ; 3.957973e-01 ];
Tc_2  = [ 3.397291e+01 ; 1.011496e+03 ; 5.060111e+03 ];
omc_error_2 = [ 1.744733e-02 ; 3.894045e-03 ; 2.644177e-02 ];
Tc_error_2  = [ 5.327949e+01 ; 8.097694e+01 ; 7.864823e+01 ];

%-- Image #3:
omc_3 = [ -2.825070e+00 ; 2.631508e-02 ; -5.348452e-01 ];
Tc_3  = [ -6.405406e+02 ; 1.036969e+03 ; 5.267554e+03 ];
omc_error_3 = [ 1.596052e-02 ; 6.132543e-03 ; 1.914667e-02 ];
Tc_error_3  = [ 5.535661e+01 ; 8.492634e+01 ; 8.380682e+01 ];

%-- Image #4:
omc_4 = [ -2.755309e+00 ; -3.603415e-02 ; -8.646305e-01 ];
Tc_4  = [ -4.187556e+02 ; 1.009057e+03 ; 5.027806e+03 ];
omc_error_4 = [ 1.554859e-02 ; 9.001242e-03 ; 1.656521e-02 ];
Tc_error_4  = [ 5.299965e+01 ; 8.111230e+01 ; 8.104413e+01 ];

%-- Image #5:
omc_5 = [ -2.849032e+00 ; 5.237880e-02 ; -3.900719e-01 ];
Tc_5  = [ -5.408351e+02 ; 1.032601e+03 ; 5.243160e+03 ];
omc_error_5 = [ 1.601724e-02 ; 5.214200e-03 ; 2.040208e-02 ];
Tc_error_5  = [ 5.496116e+01 ; 8.429201e+01 ; 8.312190e+01 ];

%-- Image #6:
omc_6 = [ -2.860450e+00 ; 7.427303e-02 ; -2.712068e-01 ];
Tc_6  = [ -2.060214e+02 ; 9.427196e+02 ; 3.930734e+03 ];
omc_error_6 = [ 1.550989e-02 ; 4.605320e-03 ; 1.932044e-02 ];
Tc_error_6  = [ 4.129471e+01 ; 6.291804e+01 ; 6.198040e+01 ];

%-- Image #7:
omc_7 = [ -2.845578e+00 ; 1.681173e-01 ; 2.694593e-01 ];
Tc_7  = [ -4.814827e+01 ; 9.347074e+02 ; 4.042494e+03 ];
omc_error_7 = [ 1.560611e-02 ; 3.284226e-03 ; 2.106498e-02 ];
Tc_error_7  = [ 4.256920e+01 ; 6.443135e+01 ; 6.300290e+01 ];

%-- Image #8:
omc_8 = [ -2.824046e+00 ; 5.444066e-02 ; -4.552355e-01 ];
Tc_8  = [ -1.294120e+03 ; 1.084595e+03 ; 5.461992e+03 ];
omc_error_8 = [ 1.659624e-02 ; 5.301749e-03 ; 2.232975e-02 ];
Tc_error_8  = [ 5.732957e+01 ; 8.873435e+01 ; 8.955247e+01 ];

%-- Image #9:
omc_9 = [ -2.851254e+00 ; 1.369009e-01 ; 5.275812e-02 ];
Tc_9  = [ -1.766868e+02 ; 1.185559e+03 ; 5.429455e+03 ];
omc_error_9 = [ 1.683740e-02 ; 3.893573e-03 ; 2.305081e-02 ];
Tc_error_9  = [ 5.720013e+01 ; 8.651474e+01 ; 8.716572e+01 ];

%-- Image #10:
omc_10 = [ -2.838916e+00 ; 3.639224e-02 ; -4.736987e-01 ];
Tc_10  = [ -1.557439e+01 ; 9.147806e+02 ; 3.617017e+03 ];
omc_error_10 = [ 1.596296e-02 ; 6.583549e-03 ; 1.821852e-02 ];
Tc_error_10  = [ 3.811869e+01 ; 5.802649e+01 ; 5.742700e+01 ];

%-- Image #11:
omc_11 = [ -3.067773e+00 ; 7.353313e-02 ; -2.226368e-01 ];
Tc_11  = [ -5.121211e+02 ; 1.191212e+03 ; 4.900412e+03 ];
omc_error_11 = [ 1.858252e-02 ; 3.635676e-03 ; 2.825805e-02 ];
Tc_error_11  = [ 5.169517e+01 ; 7.935392e+01 ; 7.603012e+01 ];

%-- Image #12:
omc_12 = [ -2.673327e+00 ; 3.531196e-01 ; 7.708063e-01 ];
Tc_12  = [ -2.980775e+01 ; 9.798242e+02 ; 5.941623e+03 ];
omc_error_12 = [ 1.679043e-02 ; 7.558789e-03 ; 1.870972e-02 ];
Tc_error_12  = [ 6.230640e+01 ; 9.583841e+01 ; 8.586372e+01 ];

%-- Image #13:
omc_13 = [ -2.928907e+00 ; 4.159470e-02 ; -3.408245e-01 ];
Tc_13  = [ -3.426304e+02 ; 1.207271e+03 ; 5.211609e+03 ];
omc_error_13 = [ 1.682977e-02 ; 5.041410e-03 ; 2.240709e-02 ];
Tc_error_13  = [ 5.495536e+01 ; 8.378554e+01 ; 8.229140e+01 ];

%-- Image #14:
omc_14 = [ -2.747906e+00 ; 3.581083e-01 ; 1.167834e+00 ];
Tc_14  = [ 1.124261e+02 ; 1.060589e+03 ; 5.948481e+03 ];
omc_error_14 = [ 1.783279e-02 ; 1.063585e-02 ; 1.717091e-02 ];
Tc_error_14  = [ 6.245558e+01 ; 9.638527e+01 ; 8.348653e+01 ];

%-- Image #15:
omc_15 = [ -2.857642e+00 ; 3.024423e-01 ; 8.870010e-01 ];
Tc_15  = [ -1.248321e+01 ; 1.061568e+03 ; 5.895546e+03 ];
omc_error_15 = [ 1.829369e-02 ; 8.160812e-03 ; 2.019120e-02 ];
Tc_error_15  = [ 6.201955e+01 ; 9.535358e+01 ; 8.502993e+01 ];

%-- Image #16:
omc_16 = [ -2.812696e+00 ; -1.224421e-01 ; -1.140013e+00 ];
Tc_16  = [ 2.212583e+02 ; 8.831615e+02 ; 4.820795e+03 ];
omc_error_16 = [ 1.510495e-02 ; 1.220235e-02 ; 1.702521e-02 ];
Tc_error_16  = [ 5.051968e+01 ; 7.783071e+01 ; 7.912649e+01 ];

%-- Image #17:
omc_17 = [ -2.827050e+00 ; -1.134425e-01 ; -1.111950e+00 ];
Tc_17  = [ 2.660396e+02 ; 7.700650e+02 ; 4.092413e+03 ];
omc_error_17 = [ 1.494185e-02 ; 1.206092e-02 ; 1.715425e-02 ];
Tc_error_17  = [ 4.280363e+01 ; 6.603812e+01 ; 6.800584e+01 ];

%-- Image #18:
omc_18 = [ -2.639474e+00 ; 4.124520e-01 ; 1.096284e+00 ];
Tc_18  = [ 1.237935e+02 ; 1.020078e+03 ; 5.980313e+03 ];
omc_error_18 = [ 1.712925e-02 ; 1.028519e-02 ; 1.688037e-02 ];
Tc_error_18  = [ 6.267514e+01 ; 9.681265e+01 ; 8.368052e+01 ];

