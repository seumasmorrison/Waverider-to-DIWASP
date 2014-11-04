function write_csv(spectra, output_file)
fid = fopen(output_file,'w');
C={'file_name', 'Hm0', 'peak_period','mean_dir_pp'};
fprintf(fid,'%s,%s,%s,%s \n',C{:});
formatSpec = '%s, %f, %f, %f \n';
for x=1:length(spectra),
    file_path = spectra(x).('file_path');
    Hm0 = spectra(x).('Hm0');
    peak_period = spectra(x).('pp');
    mean_dir_p_p = spectra(x).('mean_dir_pp');
    if length(file_path) ~= 0,
        split_file_path = regexp(file_path,'/','split');
        file_name = char(split_file_path(length(split_file_path)));
        fprintf(fid,formatSpec,file_name,Hm0, peak_period, mean_dir_p_p);
    end
end
fclose(fid)
end