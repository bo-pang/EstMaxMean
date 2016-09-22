# EstMaxMean
Experiment codes about different estimators of Max Mean

1. WEandME.m: Implementation of Weighted Estimator in the ICML paper and Max Estimator.
2. CAI.m: Implementation Cai's method to estimate |\mu|.
3. AbsEst.m: Call CAI.m to estimate (\mu_1+\mu_2+|\mu_1-\mu_2|)/2, i.e, so called Absolute Estimator (AE). 
3. MSE_CP.m: Call WEandME.m and AbsEst.m to compare approximate MSE of AE,ME,WE.
4. test_CAI.m: Call CAI.m to calculate MSE of estimating |\mu|.
5. test_Hermite.m: Test the performance of Hermite Polunomial's estimation for higher moments
6. MeanOfAbsMean.m: Test the performance of the optimal estimator in Cai's settings, i.e., estimate 1/n\sum_{i}^{n}|\mu_i|.
7. tmp.m: Calculate values of Term 1 and Term 2 in equation (38) of Cai's paper.
8. ChebyshevPolyCoeff.mat/HermitePolyCoeff.mat: Coefficients of corresponding polynomials are pre-calcualted and stored here. 
9. BayesianEst.m: Imlementation of Bayesian Estimator with prior N(0,a^2).
10. ExpMaxEst.m: Csaba's estimator that calcualtes expectation of the max.
11. Teststh.m: Call other functions to organise some experiments here.
