function output_spectra = process_batch_datawell_diwasp(folder_path)
%%
raw_files = dir([folder_path,'/*.raw']);

for x=1:length(raw_files),
    tic
    raw_file_names(x,:) = raw_files(x).name;
    disp(raw_file_names(x,:))
    spectra = datawell_raw_to_diwasp([folder_path,'/',raw_file_names(x,:)]);
    if class(spectra) == 'struct',
        output_spectra(x,:) = spectra;
    end
    toc
end
end