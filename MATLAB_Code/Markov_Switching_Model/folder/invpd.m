
function  [xinv,flag] = invpd(x)
% PURPOSE: inverts matrix using augmented eigenvalues for non PD case
% ----------------------------------------------------------------
% USAGE: [xinv,flag] = invpd(x)
% where: x    = input matrix
%---------------------------------------------------
% RETURNS: xinv = matrix inverse
%          flag = 0 for positive definite
%          flag = 1 for non-positive definite, eigenvalues augmented
% ----------------------------------------------------------------
% NOTES:
% uses function isposdef() to check for positive-definite, then
% if isposdef(x), xinv = inv(x)
% else,
% carries out SVD and augments small eigenvalues, setting them to 0.01
% This function is intended to ensure PD 
% var-cov matrices returned by numerical hessians
% ----------------------------------------------------------------

% Written by:
% James P. LeSage, Dept of Economics
% University of Toledo
% 2801 W. Bancroft St,
% Toledo, OH 43606
% jlesage@spatial-econometrics.com


if isposdef(x)
    xinv = inv(x);
    flag = 0;
else
flag = 1;
[n m] = size(x);
[u d v] = svd(x);
dd = diag(d);
xchk = u*diag(dd)*v';
dd = dd + 1000*eps;
di = ones(n,1)./dd;
xinv = u*diag(di)*v';
end

end

