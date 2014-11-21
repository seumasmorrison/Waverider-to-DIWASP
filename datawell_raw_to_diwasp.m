function output_spectra = datawell_raw_to_diwasp(file_path, output_dir,...
                                                 visible, method, mask)
% read the raw file data into a matrix stripping signal quality info
disp(file_path)
try
    raw_matrix = csvread(file_path);
catch err
    disp('Problem with RAW file')
    output_spectra = 0;
    return
end
raw_matrix = raw_matrix/100;
if length(raw_matrix) < 256,
    disp('Problem with RAW file')
    output_spectra = 0;
    return
end
%raw_matrix(:,2) = -1 * raw_matrix(:,2);
raw_matrix(:,3) = -1 * raw_matrix(:,3);
if nargin == 5,
    if mask == 'Mask',
        find_zero = diff(sign(raw_matrix(:,2)));
        indx_up = find(find_zero>0); %find all upward going zeros
        masked_raw = [];
        for x=2:length(indx_up),
            if sum(raw_matrix(indx_up(x-1):indx_up(x),1)) == 0,
                masked_raw = vertcat(masked_raw(1:size(masked_raw,1)-1,:),...
                                     raw_matrix(indx_up(x-1):indx_up(x),:));
            end
        end
        raw_matrix = masked_raw;
    end
end

ID.data = raw_matrix(:,2:4);
%define the nature of the values elev - heave, dspx - north, dspy - west 
ID.datatypes = {'elev','dspy','dspx'};
% position of the sensors relative to an origin
depth=65;
ID.layout = [0 0 depth;0 0 depth;0 0 depth]';
ID.fs = 1.28;
ID.depth = depth;
%SM   		A spectral matrix structure
%period = [30:0.2:1];
%SM.freqs = period.^(-1)
%Freqs below represent the binnings from the large spectral files
%SM.freqs = [0.025:0.005:0.635];
%Freqs below represent the binnings from the small spectral files
SM.freqs = cat(2,[0.04:0.005:0.1],[0.11:0.01:0.58]);
SM.dirs = [-180:1:180];
SM.xaxisdir = 0;
EP = [];
%EP.dres = 180
EP.nfft = 256;
EP.iter = 100;
EP.smooth = 'ON';
EP.method = 'IMLM';
if nargin > 3,
    EP.method = method;
end

[output_spectra, EP] = dirspec(ID,SM,EP,{'PLOTTYPE',0});
index_of_peak_frequency = find(sum(output_spectra.S==max(max(output_spectra.S)),2));
[output_spectra.S, output_spectra.dirs] = diwasp_bins_to_DW(output_spectra.S, output_spectra.dirs);
psds_at_peak_frequency = output_spectra.S(index_of_peak_frequency,:);
mean_dir_pp = mean_direction(real(psds_at_peak_frequency), output_spectra.dirs);
output_spectra.file_path = file_path;
if nargin == 3 & visible == 'Plot',
    output_spectra.visible = 'On';
end
h = diwasp_plotspec(output_spectra,2);
camroll(-90)
view(90,-90)
%pp is the peak period, dir_p_pp dominant direction at peak period
[Hm0,pp,dir_p_pp, dom_dir] = infospec(output_spectra);
output_spectra.Hm0 = Hm0;
output_spectra.pp = pp;
output_spectra.dir_p_pp = dir_p_pp;
output_spectra.dom_dir = dom_dir;
output_spectra.mean_dir_pp = mean_dir_pp;
output_spectra.psds_at_peak_frequency = psds_at_peak_frequency;
output_spectra.index_of_peak_frequency = index_of_peak_frequency;
output_spectra.raw_matrix = raw_matrix;
output_spectra.energy_period = energy_period(SM.freqs,output_spectra.S);
output_spectra.datatypes = ID.datatypes;
