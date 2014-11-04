Datawell_RAW_to_DIWASP
======================

A repository for working with Datawell Waverider data in the DIWASP ( DIrectional WAve SPectra ) Matlab Toolbox

This repository uses a modified version of DIWASP found at https://github.com/seumasmorrison/diwasp

datawell_raw_to_diwasp.m take a path to a Datawell RAW file and produces an output spectra struct.

process_batch_datawell_diwasp is a function which takes a path to a folder and searches that directory for raw files then loops over these raw files and then call datawell_raw_to_diwasp for each raw file and stores each output spectra to a vector of spectra struts.

write_csv is a function for extracting parameters from the spectra and write these parameters to a comma separated variable text file.


