# Raman-Data-Processing

This GitHub repository includes the matlab files and TIFF data files collected as part of my Final Year Project at Imperial College London in the Department of Bioengineering.

The project aimed to develop a protocol for Raman Imaging of mice tumour xenografts. The MATLAB data files here presented allowed to process the data collected using the microscope.

Here it is possible to find:
(a) baseline correction function composed by the files baseline.m and peak_stripping.m. This code implements teh baseline correction algorithm written by and it was written by.

(b) cosmic ray artefact removal algorithm relying on the existance of a large data set. This function is composed of a single file cosmicray.m. This code implementation was done by me and aims to replicate the algorithm proposed by Barton and Hennelly for cosmic ray removal in a large data set by finding a best match spectra.

(c) cosmic ray artefact removal algorithm proposed as part of my Master's Project, which does not require multispectral acquisition and simply relies on the stochasticity of these artefacts in the detector. This function is implemented by using the codes cosmicraystatistical.m and tukey_method.m.

(d) App Interface for data processing of Raman map data implemented for streamlining analysis of collected data. This app is implemented in the file app.mlapp and relies on the functions: baseline.m, peak_stripping.m, cosmicraystatistical.m, and tukey_method.
