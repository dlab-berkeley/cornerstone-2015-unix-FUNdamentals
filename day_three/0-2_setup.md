---
title: Git FUN!damentals
subtitle: Installation and Setup
minutes:
---

## Getting Git

* You've already got it:
  * installed on CRMPACS1 and 
  * SmartGit on the Windows server
* But, just for fun (if you want):
  * Open a "local terminal" in MobaXterm
  * `sudo apt-get install git`
  * you should see something like:

~~~{.output}
Reading package lists... done
Building dependency tree
Reading state information... done
...lots of details...
~~~

* On a debian system (including Ubuntu), you install via `apt-get install`
* On a RHEL system, you install via `yum install`
* On Cygwin (what's running in MobaXterm), `apt-get` is an alias for `apt-cyg`

## On OSX

* your system *might* have git installed already
  * you can test this by opening a terminal and typing `git`
* if not, install Xcode from the app store (or just the command line tools -
  google it!)

## On Windows

* For your personal machine, the standard git (and git-bash) installer are the
  easiest way to go.
* MobaXterm includes a rich "GNU" environment (cygwin) and we described how to
  install git above, and some folks also like MSYS to get a unix environment.
  Others prefer to install more windows-native apps with chocolatey.

# Configuring git to work with you

## You need to tell git who you are

We do this by setting a couple of options in a file found in your home directory. *Do this now!*

~~~{.input}
git config --global user.name "Firstname Lastname"
git config --global user.email username@company.extension
~~~

Your name and email address is included in every change that you make, so it's
easy to keep track of who did what

Also, unless you are a vimwizard, I would recommend changing your default
editor to `nano` or `vs` if you'll always have an X11 session open.

~~~{.input}
git config --global core.editor nano
~~~

Or, I prefer to set my EDITOR variable globally (you may have already done
this). How would you set a shell variable again?

Make sure everything was entered correctly by typing `git config --list`

~~~{.output}
user.name=Dillon Niederhut
user.email=dillon.niederhut@gmail.com
core.editor=nano
~~~

## Acknowledgments

This learning module borrows and adapts materials from the following organizations and individuals. Thank you!

[Software Carpentry](https://github.com/swcarpentry/git-novice)
