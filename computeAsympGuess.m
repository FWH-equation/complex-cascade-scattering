function asympGuess = computeAsympGuess(ADData,AAData,Modes)

mu = ADData.mu;
he = ADData.spac(1);
d = ADData.spac(2);
s = sqrt(he^2+d^2);
chie = ADData.chie;
sigma5 = AAData.sigma5;
n= 1:Modes.trunc;

% The Q suffix corresponds to the quadrant that the mode is in

if mu(2) ==0 && mu(3) == 0
% Case I
    a0q1  = (d+1i*he)*2*pi/s.^2;
    a1q1  = 1i*(d+1i*he)/s.^2;
    a2q1  = (pi/2 + chie - sigma5 + 1i*log(2*pi/mu(1)/s))*(d+1i*he)./s.^2;
    
    a0q2 = (-d+1i*he)*2*pi/s.^2;
    a1q2 =  -1i*(-d+1i*he)/s.^2;
    a2q2 = (pi/2 + chie + sigma5 - 1i*log(2*pi/mu(1)/s))*(-d+1i*he)./s.^2;
    
    a2a3 = (pi/2 + chie + sigma5 + 1i*log(2*pi/mu(1)/s))*(-d-1i*he)./s.^2;
    a2q4 = (pi/2 + chie - sigma5 - 1i*log(2*pi/mu(1)/s))*(d-1i*he)./s.^2;
    
elseif mu(3)==0
% Case II
    a0q1  = (d+1i*he)*2*pi/s.^2;
    a1q1  = 0;
    a2q1 = ( -sigma5+1i*log(1+1./(1i*mu(2))))*(d+1i*he)./s.^2;

    a0q2 = (-d+1i*he)*2*pi/s.^2;
    a1q2 =  0;
    a2q2 = ( sigma5-1i*log(1-1./(1i*mu(2))))*(-d+1i*he)./s.^2;
    
    a2a3 = ( sigma5+1i*log(1-1./(1i*mu(2))))*(-d-1i*he)./s.^2;
    a2q4 = (-sigma5-1i*log(1+1./(1i*mu(2))))*(d-1i*he)./s.^2;

else
% Case III
    a0q1  = (d+1i*he)*2*pi/s.^2;
    a1q1  = 0;
    a2q1  = -sigma5*(d+1i*he)./s.^2;

    a0q2 = (-d+1i*he)*2*pi/s.^2;
    a1q2 =  0;
    a2q2 = sigma5*(-d+1i*he)./s.^2;
    
    a2a3 = conj(a2q2);
    a2q4 = conj(a2q1);

end

Rsols1b = a0q1*n+a1q1*log(n)+a2q1;
Rsols2b = a0q2*n+a1q2*log(n)+a2q2;
Rsols3b = conj(a0q2)*n+conj(a1q2)*log(n)+a2a3;
Rsols4b = conj(a0q1)*n+conj(a1q1)*log(n)+a2q4;
asympGuess = [Rsols1b,Rsols2b,Rsols3b,Rsols4b];

end