function [l2] = kernel_l2(X,Y,varargin)
% Returns the l2 squared distance estimator for the two samples X,Y
% Trains a KDE on the first sample to do bandwidth selection and
% then rescales the bandwidth.
% Then uses the bi-variate kernel evaluations as the estimator.

   p = inputParser;
   p.addParamValue('beta', 2, @isscalar);
   p.addParamValue('debug',0, @isscalar);
   p.parse(varargin{:});
   Prms = p.Results;

   n1 = size(X,2);
   n2 = size(Y,2);
   d = size(X,1);

   %% First cross-validate the density estimate to find "optimal
   %% bandwidth for density estimation. 
   [est_probs, f, h_old] = kde(X');


   %% We're going to throw everything away but we'll rescale the
   %% bandwidth for our problem. 
   %% This is still a hack since we don't actually know beta. 
   %% But we're trying to estimate the constant. 
   h = h_old*n1^(-2/(4*Prms.beta+d) + 1/(2*Prms.beta+d));
   if Prms.debug == 1,
       fprintf('h_old=%0.2f h_new=%0.2f\n', h_old, h);
   end;


   T1 = GaussKernel(h, X');
   T2 = GaussKernel(h, Y');
   T3 = GaussKernel(h, X', Y');
   
   T1 = 1/(n1*(n1-1)) * sum(sum(T1 - diag(diag(T1))));
   %% fprintf('T1=%0.3f\n', T1);
   T2 = 1/(n2*(n2-1)) * sum(sum(T2 - diag(diag(T2))));
   T3 = 2/(n1*n2) * sum(sum(T3));
   if Prms.debug == 1,
       fprintf('T1=%0.3f T2=%0.3f T3=%0.3f\n', T1, T2, T3);
   end;
   l2 = T1 + T2 - T3;
