function [h,p,that] = l2_test(X,Y),
%% Asymptotic two sample test for l2 divergence
  [that lb ub] = confidence_interval(X,Y,0.05, 1, 1);
  if 0 >= lb,
      h = 0;
  else,
      h = 1;
  end;

  p = 0;
