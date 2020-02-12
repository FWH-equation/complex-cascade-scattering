function acousticFieldLowerTriangle = acousticFieldLowerTriangle(data,type)

A1bResM = data.A1bResM.(type);
A1bTM=data.A1bTM.(type);
A1bTP=data.A1bTP.(type);
TMd=data.TMd;
GM0=data.GM0;
PM0=data.PM0;

KMTM=data.KMTM;
% A1aGM=data.A1aGM.(type);
A1bGM0=data.A1bGM0.(type);
% 
KPGM0=data.KPGM0;
KMGM0=data.KMGM0;

KPPM0=data.KPPM0;
KMPM0=data.KMPM0;
% JMGM0=JMGM(:,:,ceil(end/2),:,:);

LMa = permute(data.LMa,[3,2,1,4,5]);

data.comb=[0,1,0,1];

Dfin= pi*1i*bsxfun(@times,permute(D(LMa,data),[3,2,1,4,5]),A1bResM);
Dterms = sum(Dfin,3);

Aterms = -pi*sum((data.D1.A+data.D1.C)./(TMd-PM0).*A1bTM,3);
Bterms = pi*1i*sum((data.D1.B).*A1bTP,3);

gModeFun = data.A1aPM0.(type);
% 
AsumG = -sum((data.D1.A+data.D1.C)./(1i*(TMd-PM0)).*KMTM./KMPM0.*exp(-1i*(TMd-PM0)),3);

Tsum2 = data.D1.T./KPGM0.*A1bGM0; 
Tterms2 = -pi*1i*sum(Tsum2,3);

TtermsG = -data.D1.T.*KMGM0./KPGM0./KMPM0.*exp(-1i*(GM0-PM0));

P =  AsumG + TtermsG ;
gModeTerms = 1i*pi*P.*gModeFun;

%% Final sums
acousticFieldLowerTriangle = Dterms +Aterms + Bterms + Tterms2  + gModeTerms;
end