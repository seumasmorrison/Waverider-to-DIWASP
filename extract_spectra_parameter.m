function parameter = extract_spectra_parameter(spectra,param)
for x=1:length(spectra),
    parameter_x = spectra(x).(param);
    if length(parameter_x) ~= 0,
        parameter(x) = parameter_x;
    end
end
end