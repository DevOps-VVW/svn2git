#!/bin/bash

# Copyright (c) 2016, rockyluke
#
# Permission  to use,  copy, modify,  and/or  distribute this  software for  any
# purpose  with  or without  fee  is hereby  granted,  provided  that the  above
# copyright notice and this permission notice appear in all copies.
#
# THE SOFTWARE IS PROVIDED "AS IS"  AND THE AUTHOR DISCLAIMS ALL WARRANTIES WITH
# REGARD TO  THIS SOFTWARE INCLUDING  ALL IMPLIED WARRANTIES  OF MERCHANTABILITY
# AND FITNESS.  IN NO EVENT SHALL  THE AUTHOR BE LIABLE FOR ANY SPECIAL, DIRECT,
# INDIRECT, OR  CONSEQUENTIAL DAMAGES OR  ANY DAMAGES WHATSOEVER  RESULTING FROM
# LOSS OF USE, DATA OR PROFITS,  WHETHER IN AN ACTION OF CONTRACT, NEGLIGENCE OR
# OTHER  TORTIOUS ACTION,  ARISING  OUT OF  OR  IN CONNECTION  WITH  THE USE  OR
# PERFORMANCE OF THIS SOFTWARE.

version='1.0'

if [ -f functions.sh ]
then
    . functions.sh
else
    echo "Missing functions.sh"
    exit 1
fi

while getopts 'hw:s:d:f:a:v' OPTIONS
do
    case ${OPTIONS} in
        h)
            # -h / --help
            usage
            exit 0
            ;;
	s)
	    # -s / --source
	    src=${OPTARG}
	    ;;
	d)
	    # -d / --destination
	    dst=${OPTARG}
	    ;;
	f)
	    # -f / --folder
	    folder=${OPTARG}
	    ;;
	a)
	    # -a / --authors
	    authors=${OPTARG}
	    ;;
        v)
            # -v / --version
            echo "${version}"
            exit 0
            ;;
        *)
            usage
            exit 1
            ;;
    esac
done

which svn > /dev/null
if [ ${?} -ne 0 ]
then
    echo "Please install svn (see README.md)"
    exit 1
fi

which git > /dev/null
if [ ${?} -ne 0 ]
then
    echo "Please install git (see README.md)"
    exit 1
fi

# -s / --source
if [ -z "${src}" ]
then
    echo 'You need to specify svn repository (source)'
    echo ''
    usage
    exit 1
fi

# -d / --destination
if [ -z "${dst}" ]
then
    echo 'You need to specify git repository (destination)'
    echo ''
    usage
    exit 1
fi

# create folders
create_folders "${folder}"

# checkout svn
svn_clone "${folder}" "${src}" "${authors}"

# clone svn into git
git_clone "${folder}"

# generate .gitignore from svn:ignore
git_ignore "${folder}"

# set git remote
git_remote "${folder}" "${dst}"

# final steps
git_push "${folder}"
# EOF
