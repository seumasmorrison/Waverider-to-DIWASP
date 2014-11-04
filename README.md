Datawell_RAW_to_DIWASP
======================

A repository for working with Datawell Waverider data in the DIWASP ( DIrectional WAve SPectra ) Matlab Toolbox

This repository uses a slightly modified version of DIWASP found at https://github.com/seumasmorrison/diwasp
These changes were made to remove conflict with WAFO namespace clashes and allow easier batch processing of raw files.

**datawell_raw_to_diwasp** takes a path to a Datawell RAW file and produces an output spectra struct.

**process_batch_datawell_diwasp** is a function which takes a path to a folder and searches that directory for raw files then loops over these raw files and then calls datawell_raw_to_diwasp for each raw file and stores each output spectra to a vector of spectra struts.

**write_csv** is a function for extracting parameters from the spectra and write these parameters to a comma separated variable text file.

There is an example raw file from cdip in the example folder and a plot shown below generated from that raw file.

![Polar Plot of cdip.raw Spectra](https://raw.githubusercontent.com/seumasmorrison/Datawell_RAW_to_DIWASP/master/example/cdip_plot.png)


