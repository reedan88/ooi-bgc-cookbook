# OOI Biogeochemical Sensor - Carbonate Sensors Working Group

Welcome, this repo provides starter code, example notebooks, and example data for getting started working with Ocean Observatories Initiative Carbon System Sensors.


## Project Files Description


## Setup

0. **Make an account on OOINet**
First, please go to https://ooinet.oceanobservatories.org/ and make an register. Once you have made an account for yourself and logged in, navigate to your account settings by clicking on "User Profile" under your email in the top right corner of your screen. Once at your Profile, record your API Username and API Token. These are necessary if you wish to access and download data from the Ocean Observatories API.

1. **Setup python environment**
Its recommended that miniconda or anaconda3 has been installed. The python environment can be setup with the following commands:

    ```
    conda env create -f environment.yaml
    ```

2. **Launch jupyter notebooks**
Now you are ready to get working with OOI data! Launch a jupyter notebook in your browser and get ready to explore OOI carbon system data.

---
### Project Files Description
---
#### Dependencies
The example notebooks in this repo rely heavily on packages, functions, and routines that have been developed over the years by the OOI operators to assist in processing and working with OOI data. There are two principle repos on which the example notebooks lean are:

* ##### OOINet
> The modules and tools within this repo are designed to assist in requesting, importing, downloading, and vizualizing data from the Ocean Observatories Initiative API by M2M requests. It can be found at https://github.com/reedan88/OOINet.

* ##### OOI-Data-Explorations
> Explorations of Ocean Observatories Initiative Datasets via MATLAB, Python, R, and Julia. It can be found at https://github.com/oceanobservatories/ooi-data-explorations.

These repos are not distributed, so they will need to be either cloned to your local machine or the files and functions directly downloaded.

#### Notebooks
* **Downloading_Data.ipynb** - example of how to download data from the OOI API via M2M as well as from Data Explorer.
* **Bottle_Data.ipynb** - example of processing and preparing bottle data for comparison with carbon system sensors
* **PHSEN.ipynb** - example working with Sunburst iSAMI-pH data
* **PCO2W.ipynb** - example working with Sunburst iSAMI-CO2 data
* **PCO2A.ipynb** - example working with Pro-Oceanus pCO2 data

#### Files in this repo
* **utils.py**
* **environment.yaml**



