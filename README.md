# List-Prolog-Package-Manager (LPPM)

Registry manager and installer for GitHub repositories (of any language) with dependencies

* lppm.pl - starts a local or remote Prolog server to host the registry, where a repository entry on the registry can be uploaded or edited by reuploading, and GitHub repositories (a.k.a. packages) in the registry can be installed when in the same directory as the registry on the server.  This limitation means that LPPM is more appropriate for private use.  Due to a bug the registry and GitHub manifest files cannot be read using a web service algorithm, so the registry must be accessed through a browser and GitHub can only commit, not pull.
* lppm_registry.pl - contains users, repositories, descriptions and dependencies (lists of users and repositories).

# Getting Started

Please read the following instructions on how to install the project on your computer for installing repositories with dependencies.

# Prerequisites

Install List Prolog Interpreter Repository (https://github.com/luciangreen/listprologinterpreter).

This will be part of a package soon.

# Installing and Running List Prolog Package Manager

* Download the repositories above and save them in a single folder, the ROOT folder.
* Load `lppm` by entering `['lppm.pl'].` and run with the command e.g. `lppm_start_server(8001).` on the machine that is a local or remote host.
* In the web browser, go to `http://127.0.0.1:8001/` to upload registry entries.  Take care to enter double quotes around all strings.  The registry cannot accept badly formatted input.  To update an entry, re-enter it with the same user and repository.
* In the web browser, view the registry at `http://127.0.0.1:8001/registry`.
* Install packages by running `lppm_install(\"User\",\"Repository\").`  LPPM will prompt you for an installation directory.  Packages are uncompressed source code from GitHub, saved to directories of the same name in the target folder.  The algorithms need to work with this.  There are no versions, ratings or download tallies.
* LPPM can be used in a novel way to install and run verify scripts on multiple algorithms to test them.
* To uninstall packages, simply move them to the trash.  LPPM doesn't check if files exist, so install in an empty folder.

# Authors

Lucian Green - Initial programmer - <a href="https://www.lucianacademy.com/">Lucian Academy</a>

# License

I licensed this project under the BSD3 License - see the <a href="LICENSE">LICENSE.md</a> file for details



