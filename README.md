# Radiosun

# Solar radio flux at 10.7 cm

## Download radio sun flux from NOAA

You can use ```radiosunflux-dl-noaa.sh``` bash script to download the solar radio flux at 10.7 cm from NOAA site. The program creates a similar file as fluxtable.txt available through the FTP server of [Canada's solar monitoring program](https://www.spaceweather.gc.ca/forecast-prevision/solar-solaire/solarflux/sx-en.php).
Read details about the NOAA's data from [F10.7 cm Radio Emissions](https://www.swpc.noaa.gov/phenomena/f107-cm-radio-emissions) page.

Before executing the program on Linux you may want to edit ```workdir``` and ```https_proxy``` parameters in the script and install ```wget``` and ```bash``` programs.


# License

[LGPL-3.0-or-later](LICENSE)