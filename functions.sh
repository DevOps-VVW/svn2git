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

folder="/tmp/${$}"

function usage() {

    cat <<EOF

NAME:
   migrate.sh - Simple script to migrate from svn to git with history.

USAGE:
   migrate.sh -s <remote svn path> -d <remote git path>

OPTIONS:
   -h, --help           Show help
   -s, --source         Remote svn path, the source repository
   -d, --destinatiom    Remote git path, the destination repository (need to be empty)
   -f, --folder         You can optionally specify folder where you want the sources (default in /tmp)
   -a, --authors        You can optionally specify authors file to map usernames
   -v, --version        Show version

VERSION:
   svn-to-git version: ${version}

EOF

} # usage


function create_folders() {

    folder=${1:?}

    # create tmp folder
    if [ ! -d "${folder}" ]
    then
	mkdir -p "${folder}"
    else
	echo "Warning: ${folder} already exists."
	exit 1
    fi

} # create_folders


function svn_clone() {

    folder=${1:?}
    src=${2:?}
    authors=${3:?}

    echo '-- checkout svn'
    cd "${folder}" || exit
    if [ -z "${authors}" ]
    then
	git svn clone "${src}" "${folder}/svn"
    else
	if [ -f "${authors}" ]
	then
	    git svn clone "${src}" "${folder}/svn" --authors-file="${authors}"
	else
	    echo "Warning: ${authors} file missing."
	    exit 1
	fi
    fi
    if [ ${?} -ne 0 ]
    then
	echo 'KO (git svn clone failed)'
	exit 1
    else
	echo 'OK'
    fi

} # svn_clone


function git_clone() {

    folder=${1:?}

    echo -n "-- clone svn to git"
    cd "${folder}" || exit
    git clone "${folder}/svn" "${folder}/git"
    if [ ${?} -ne 0 ]
    then
	echo 'KO (git clone failed)'
	exit 1
    else
	echo 'OK'
    fi

} # git_clone


function git_ignore() {

    folder=${1:?}

    echo -n '-- generate .gitignore'
    cd "${folder}/svn" || exit
    git svn show-ignore > "${folder}/git/.gitignore"
    if [ ${?} -ne 0 ]
    then
	echo 'KO (git svn show-ignore failed)'
	exit 1
    else
	echo 'OK'
    fi

} # git_ignore


function git_remote() {

    folder=${1:?}
    dst=${2:?}

    echo -n '-- set git remote'
    cd "${folder}/git" || exit
    git remote set-url origin "${dst}"
    if [ ${?} -ne 0 ]
    then
	echo 'KO (git remote set-url origin failed)'
	exit 1
    else
	echo 'OK'
    fi

} # git_remote


function git_push() {

    folder=${1:?}

    cd "${folder}/git" || exit
    cat <<EOF
################################################################################
#
#       Migrate from svn to git with history finished \o/
#
#       You need to check commit history and push the code.
#
#       You also need to check your .gitignore file.
#
#       $ cd ${folder}/git
#       $ git log
#       [...]
#       $ git push
#
#
################################################################################
EOF

} # git_push
# EOF
