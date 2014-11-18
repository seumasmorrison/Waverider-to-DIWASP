function T_10 = energy_period(freqs,spec)
spec = real(spec);
numfreqs = length(freqs);
% Check which dimensions of spectrum correspond to direction/freq
whichisdir = find(size(spec)~=numfreqs);
assert(length(whichisdir) == 1,'Not sure which dimension is which');

% Get 1D nondirectional spectrum from 2D directional spectrum by summing
% over the directional dimension, and multipliying by 2*pi/(number of
% directions) (dtheta)
numdirs = size(spec,whichisdir);
dtheta = 1; % as units are "per degree" and bins are of one degrees
spec1D = dtheta*sum(spec,whichisdir);
spec1D = spec1D(:);
% Calculate the -1th and zeroth moment.  First, vector of df (more general,
% in case have to use for non equally spaced frequency vector)
df = freqs(2:end)-freqs(1:end-1);
df = [df,df(end)];  

% Now to actually calculate the moments (vector multiplication: ensures
% summation)
m_1 = (freqs.^(-1).*df)*spec1D;
m0 = df*spec1D;

% Finally, the energy period...
T_10 = m_1/m0;
end
