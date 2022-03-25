#!/bin/bash
# SPDX-License-Identifier: LGPL-3.0-or-later
#
# Copyright (C) 2022 Jukka Pakarinen
#


workdir=$HOME/radioflux-test

# Where to download flux data file
url=https://services.swpc.noaa.gov/text/daily-solar-indices.txt

# You may need to use proxy server
#export https_proxy=

# Download the data to this file
dlfile=${workdir}/daily-solar-indices.txt

# Store flux data to this file
fluxfile=${workdir}/fluxtable_noaa_gov.txt

# We want to get yesterday's flux
fluxdate=$(date -u --date="$(date -u +%Y%m%d) -1 days" +%Y%m%d)
year=${fluxdate:0:4}
month=${fluxdate:4:2}
day=${fluxdate:6:2}

# Create working directory if not exist
test -d ${workdir} || mkdir -p ${workdir}

# Delete old file
rm -f ${dlfile}

# Download the flux data file
wget -qO ${dlfile} ${url}

# Do we have a file now
if ! [ -f ${dlfile} ] ; then
    echo "File not found. Maybe we failed to download the flux data file."
    exit 1
fi

# Parse the flux value
fluxobsflux=$(cat ${dlfile}|grep ^"${year} ${month} ${day}"|xargs|cut -d' ' -f4)

# Check the fluxdate and fluxobsflux are numbers
re='^[+-]?[0-9]+([.][0-9]+)?$'
if ! [[ ${fluxdate} =~ ${re} ]] ; then
    echo "Fluxdate is not a number. fluxdate='${fluxdate}' fluxobsflux='${fluxobsflux}'" >&2
    exit 1
fi
if ! [[ ${fluxobsflux} =~ ${re} ]] ; then
    echo "Flux value parsing failed. fluxdate='${fluxdate}' fluxobsflux='${fluxobsflux}'" >&2
    exit 1
fi

if ! [ -f ${fluxfile} ] ; then
  echo "fluxdate    fluxtime    fluxjulian    fluxcarrington  fluxobsflux  fluxadjflux  fluxursi  " > ${fluxfile}
  echo "----------  ----------  ------------  --------------  -----------  -----------  ----------" >> ${fluxfile}
fi

echo "${fluxdate}    200000               -1         -1           ${fluxobsflux}           -1            0" >> ${fluxfile}


exit 0
