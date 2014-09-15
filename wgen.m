function [ watermark ] = wgen( im,v,seed)
% Generates a matrix containing the verification information
% The function wgen() accepts the test image, the verification matrix and the
% secret pass key as input arguments. It returns the test watermark.
[r,c] = size(v);
c=c/2;
vr=1;
vc=1;
[R, C]= size(im);
watermark= zeros(r,c); % initialization of test watermark matrix
rng(seed); % passkey used as seed for random number generation
mat= randperm( R*C, r*c); % random number array generation
for n=1:r*c % algorithm to compute test watermark
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
more=0;
less=0;
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
if((less<=more) && (v(vr,vc)==1 && v(vr,vc+1)== 0))
watermark(wi, wj) = 1;
elseif((less>more) && (v(vr,vc)==0 && v(vr,vc+1)== 1))
watermark(wi, wj) = 1;
elseif((less<=more )&&(v(vr, vc)==0 && v(vr, vc+1)== 1))
watermark(wi,wj) =0;
elseif((less>more )&& (v(vr, vc)==1 && v(vr,vc+1)== 0))
watermark(wi,wj) =0;
end
vr= vr+1;
if(vr == r+1)
vr=1;
vc= vc+2;
end
end
end
