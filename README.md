# svn2git ![License badge][license-img] [![Build Status][build-img]][build-url]

## Overview

This is a  simple shell script to migrate from svn  repository to git repository
with history.

Subversion exists  to be universally  recognized and adopted as  an open-source,
centralized version  control system characterized  by its reliability as  a safe
haven for valuable data; the simplicity  of its model and usage; and its ability
to support the  needs of a wide variety of users  and projects, from individuals
to large-scale enterprise operations.

https://subversion.apache.org/

Git is  a free and  open source distributed  version control system  designed to
handle  everything   from  small   to  very  large   projects  with   speed  and
efficiency. Git  is easy to learn and  has a tiny footprint  with lightning fast
performance.  It  outclasses  SCM  tools  like Subversion,  CVS,  Perforce,  and
ClearCase with  features like cheap  local branching, convenient  staging areas,
and multiple workflows.

https://git-scm.com/

## Description

The script follow some steps of : http://stackoverflow.com/a/3972103/292694

## Requirements

On Debian (>= wheezy) & Ubuntu (>= trusy), you need the following packages :

 ```bash
 $ sudo apt-get install subversion git-core git-svn
 ```

## Setup

## Usage

Show help.

 ```bash
 $ svn2git.sh -h
 ```

Migrate *remote-svn-path* into *remote-git-path*.

 ```bash
 $ svn2git.sh -s <remote svn path> -d <remote git path>
 $ git log
 $ git push
 ```

## Development

Feel free to contribute on GitHub.

```
    ╚⊙ ⊙╝
  ╚═(███)═╝
 ╚═(███)═╝
╚═(███)═╝
 ╚═(███)═╝
  ╚═(███)═╝
   ╚═(███)═╝
```

[license-img]: https://img.shields.io/badge/license-ISC-blue.svg
[build-img]: https://travis-ci.org/rockyluke/svn2git.svg?branch=master
[build-url]: https://travis-ci.org/rockyluke/svn2git
