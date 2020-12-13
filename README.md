<img src="https://1.bp.blogspot.com/-9hHH7JvCF7A/XngF6CFvkaI/AAAAAAAAHaI/UNHd5hvUetwGiLLIi74MkLYkpUce8H3iACLcBGAsYHQ/s1600/Screen%2BShot%2B2020-03-23%2Bat%2B11.36.26%2Bam.png" alt="Lucian Academy as Boxes in an L-Shape">

# List-Prolog-Package-Manager (LPPM)

Registry manager and installer for GitHub repositories (of any language) with dependencies

* lppm.pl - starts a local or remote Prolog server to host the registry, where a repository entry on the registry can be uploaded or edited by reuploading, and GitHub repositories (a.k.a. packages) in the registry can be installed when in the same folder as the registry on the server.
* lppm_registry.pl - contains users, repositories, descriptions and dependencies (lists of users and repositories).

# Getting Started

Please read the following instructions on how to install the project on your computer for installing repositories with dependencies.

# Prerequisites

* Install <a href="https://www.swi-prolog.org/build/">SWI-Prolog</a> for your machine.

# Installing and Running List Prolog Package Manager

* Download the repositories above and save the files in a single folder, the ROOT folder.
```
git clone https://github.com/luciangreen/List-Prolog-Package-Manager.git
cd List-Prolog-Package-Manager
```

* Load `lppm` by entering `['lppm.pl'].` in SWI-Prolog and run with the command e.g. `lppm_start_server(8001).` on the machine that is a local or remote host.
* In the web browser, go to `http://127.0.0.1:8001/` to upload registry entries.  Take care to enter double quotes around all strings.  The registry will not accept badly formatted input.  To update an entry, re-enter it with the same user and repository.
* In the web browser, view the registry at `http://127.0.0.1:8001/registry`.
* Install packages by running `lppm_install("User","Repository").`  LPPM will prompt you for an installation folder.  Packages are uncompressed source code from GitHub, saved to folders of the same name in the target folder.  Please enter the relevant folder and follow the running instructions from the repository.

# Authors

Lucian Green - Initial programmer - <a href="https://www.lucianacademy.com/">Lucian Academy</a>

# License

I licensed this project under the BSD3 License - see the <a href="LICENSE">LICENSE.md</a> file for details



