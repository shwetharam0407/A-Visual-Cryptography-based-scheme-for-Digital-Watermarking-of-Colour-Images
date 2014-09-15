  function [v] = vgen( im, wmk,seed )
% Generates a matrix containing the verification information
% The function vgen() accepts the image to be marked, the watermark and the
% secret pass key as input arguments. It returns the verification matrix.
[R, C]= size(im);
[r, c]= size(wmk);
rng(seed); % pass key used as seed for random generator
mat= randperm( R*C, r*c); % function to generate an array of random numbers
v= zeros(r, 2*c); % initialization of verification matrix
vr=1; vc=1;
for n=1:r*c % algorithm to compute verification matrix
val = mat(n);
if(mod(val,C) ==0)
j=C;
else
j= mod(val, C);
end
if(val<=C)
i=1;
else
i= (val-j)/C +1;
end
if(mod(n, c) ==0)
wj=c;
else
wj= mod(n, c);
end
if(n<=c)
wi=1;
else
wi= (n-wj)/c +1;
end
more= 0;
less= 0;
if(i~=1 && j~=1)
if(im(i-1, j-1)<=im(i,j))
less= less+1;
else
more=more+1;
end
end
if(i~=1)
if(im(i-1, j)<=im(i,j))
less= less+1;
else
more=more+1;
end
end
if(i~=1 && j~=C)
if(im(i-1, j+1)<=im(i,j))
less= less+1;
else
more=more+1;
end
end
if(j~=1)
if(im(i, j-1)<=im(i,j))
less= less+1;
else
more=more+1;
end
end
if(j~=C)
if(im(i, j+1)<=im(i,j))
less= less+1;
else
more=more+1;
end
end
if(i~=R && j~=1)
if(im(i+1, j-1)<=im(i,j))
less= less+1;
else
more=more+1;
end
end
if(i~=R)
if(im(i+1, j)<=im(i,j))
less= less+1;
else
more=more+1;
end
end
if(i~=R && j~=C)
if(im(i+1, j+1)<=im(i,j))
less= less+1;
else
more=more+1;
end
end
if(less<=more && wmk(wi, wj)==1)
v(vr, vc:vc+1) = [1,0];
elseif(less>more && wmk(wi, wj)==1)
v(vr, vc:vc+1) = [0,1];
elseif(less<=more && wmk(wi, wj)==0)
v(vr, vc:vc+1) = [0,1];
elseif(less>more && wmk(wi, wj)==0)
v(vr, vc:vc+1) = [1,0];
end
vr= vr+1;
if(vr == r+1)
vr=1;
vc= vc+2;
end
end
end
