---
title: The Unix Shell
subtitle: Files & Directories
minutes: 5
---

# The Unix Shell: Files and Directories

> ## Learning Objectives
>
> *   Explain the similarities and differences between a file and a directory.
> *   Translate an absolute path into a relative path and vice versa.
> *   Construct absolute and relative paths that identify specific files and directories.
> *   Explain the steps in the shell's read-run-print cycle.
> *   Identify the actual command, flags, and filenames in a command-line call.
> *   Demonstrate the use of tab completion, and explain its advantages.

The part of the operating system responsible for managing files and directories is called the **file system**. It organizes our data into files, which hold information, and directories (also called "folders"), which hold files or other directories.

Several commands are frequently used to create, inspect, rename, and delete files and directories. To start exploring them, let's open a shell window:

~~~ {.input}
>
~~~

The angular bracket is a **prompt**, which shows us that the shell is waiting for input; your shell may show something more elaborate.

Type the command `whoami`, then press the Enter key (sometimes marked Return) to send the command to the shell.

The command's output is the ID of the current user, i.e., it shows us who the shell thinks we are:

~~~ {.input}
> whoami
~~~

~~~ {.output}
DNiederhut
~~~

More specifically, when we type `whoami` the shell:

1.  finds a program called `whoami`,
2.  runs that program,
3.  displays that program's output, then
4.  displays a new prompt to tell us that it's ready for more commands.

### Home Directories

Next, let's find out where we are by running a command called `pwd` (which stands for "print working directory").

At any moment, our **current working directory** is our current default directory, i.e., the directory that the computer assumes we want to run commands in  unless we explicitly specify something else.

Here, the computer's response is `/home/mobaxterm`, which is the **home directory**:

~~~ {.input}
> pwd
~~~

~~~ {.output}
/home/mobaxterm
~~~

> #### Alphabet Soup
>
> If the command to find out who we are is `whoami`, the command to find
> out where we are ought to be called `whereami`, so why is it `pwd`
> instead? The usual answer is that in the early 1970s, when Unix was
> first being developed, every keystroke counted: the devices of the day
> were slow, and backspacing on a teletype was so painful that cutting the
> number of keystrokes in order to cut the number of typing mistakes was
> actually a win for usability. The reality is that commands were added to
> Unix one by one, without any master plan, by people who were immersed in
> its jargon. The result is as inconsistent as the roolz uv Inglish
> speling, but we're stuck with it now.
>
> The good news is: because these basic commands were so integral to the
> development of early Unix, they have stuck around, and appear (in some form)
> in almost all programming languages.

To understand what a "home directory" is, let's have a look at how the file system as a whole is organized. At the top is the **root directory** that holds everything else.

We refer to it using a slash character `/` on its own; this is the leading slash in `/home/mobaxterm`.

Note that the slashes point the *opposite* way on Unix machines. Backslashes, which separate levels of a directory in Windows, are reserved for handling special characters like "\n".

Inside that directory are several other directories: `bin` (which is where some built-in programs are stored), `data` (holding miscellaneous data files) `etc` (where local configuration files are stored), `tmp` (for temporary files that don't need to be stored long-term), and so on.

> If you're working on a Mac, the file structure will look similar, but not
> identical. The following image shows a file system graph for the typical Mac.

![File Directory](https://swcarpentry.github.io/shell-novice/fig/home-directories.svg)

> Notice that there are two meanings for the `/` character.
> When it appears at the front of a file or directory name,
> it refers to the root directory. When it appears *inside* a name,
> it's just a separator.

### Listing

Let's see what's in Rochelle's home directory by running `ls`, which stands for "listing":

~~~ {.input}
> ls
~~~

~~~ {.output}
data       file.txt                  Public                     Videos
Desktop    Music                     R
Documents  Pictures                  setup_ipython_notebook.sh
Downloads  programming-fundamentals  Templates
~~~

`ls` prints the names of the files and directories in the current directory in alphabetical order, arranged neatly into columns.

Most Unix commands, including `ls`, have options that you can select. If you provide no options, it uses a set of defaults. You can access information about how commands work and the kinds of options they have with the `man` command.

~~~ {.input}
man ls
~~~

This should take you to a page that looks like this:

~~~ {.output}
NAME
     ls -- list directory contents

SYNOPSIS
     ls [-ABCFGHLOPRSTUW@abcdefghiklmnopqrstuwx1] [file ...]

DESCRIPTION
     For each operand that names a file of a type other than directory, ls
     displays its name as well as any requested, associated information.  For
     each operand that names a file of type directory, ls displays the names
     of files contained within that directory, as well as any requested, asso-
     ciated information.

     If no operands are given, the contents of the current directory are dis-
     played.  If more than one operand is given, non-directory operands are
     displayed first; directory and non-directory operands are sorted sepa-
     rately and in lexicographical order.

     The following options are available:

     -@      Display extended attribute keys and sizes in long (-l) output.

     -1      (The numeric digit ``one''.)  Force output to be one entry per
             line.  This is the default when output is not to a terminal.

     -A      List all entries except for . and ...  Always set for the super-
             user.

     -a      Include directory entries whose names begin with a dot (.).
~~~

This is actually a program called `less`, which displays the contents of files inside a terminal. You can scroll up and down with the up and down arrow keys. Try scrolling down through the options - which of these will help you see differences between files and directories?

We can make its output more comprehensible by using the **flag** `-F`, which tells `ls` to add a trailing `/` to the names of directories:

~~~ {.input}
> ls -F
~~~

~~~ {.output}
data/       Music/                     setup_ipython_notebook.sh*
Desktop/    Pictures/                  Templates/
Documents/  programming-fundamentals/  Videos/
Downloads/  Public/
file.txt    R/
~~~

**Flags** come in two varieties -- chainable and unchainable. `-F` and `-G` are chainable, which means you can clump a lot of them together like `-FGl`. Unchainable flags have two dashes and long names, like `--help` and `--verbose`. You *cannot* enter `--helpverbose` without getting fussed at.

Here, we can see that `/home/oski` contains 11 **sub-directories**. The names that don't have trailing slashes, like `file.txt` are plain old files.

And note that **whitespace matters**! There is a space between `ls` and `-F`: without it, the shell thinks we're trying to run a command called `ls-F`, which doesn't exist.

> #### What's In A Name?
>
> You may have noticed that all of our's files' names are "something dot
> something". This is just a convention: we can call a file `file` or
> almost anything else we want. However, most people use two-part names
> most of the time to help them (and their programs) tell different kinds
> of files apart. The second part of such a name is called the
> **filename extension**, and indicates what type of data the file holds:
> `.txt` signals a plain text file, `.pdf` indicates a PDF document, `.cfg` is
> a configuration file full of parameters for some program or other, and so on.
>
> This is just a convention, albeit an important one. Files contain
> bytes: it's up to us and our programs to interpret those bytes
> according to the rules for PDF documents, images, and so on.
>
> Naming a PNG image of a whale as `whale.mp3` doesn't somehow
> magically turn it into a recording of whalesong, though it *might*
> cause the operating system to try to open it with a music player
> when someone double-clicks it.

Now let's take a look at what's in Rochelle's `data` directory by running `ls -F data`, i.e., the command `ls` with the **arguments** `-F` and `data`. The second argument --- the one *without* a leading dash --- tells `ls` that we want a listing of something other than our current working directory:

~~~ {.input}
> ls -F data
~~~

~~~ {.output}
animals.txt articles/
~~~

The output shows us that there are four text files and two sub-sub-directories.Organizing things hierarchically in this way helps us keep track of our work: it's possible to put hundreds of files in our home directory, just as it's possible to pile hundreds of printed papers on our desk, but it's a self-defeating strategy.

Notice, by the way that we spelled the directory name `data`. It doesn't have a trailing slash: that's added to directory names by `ls` when we use the `-F` flag to help us tell things apart. And it doesn't begin with a slash because it's a **relative path**, i.e., it tells `ls` how to find something from where we are, rather than from the root of the file system.

> #### Parameters vs. Arguments
>
> According to [Wikipedia](https://en.wikipedia.org/wiki/Parameter_(computer_programming)#Parameters_and_arguments),
> the terms **argument** and **parameter** mean slightly different things.
> In practice, however, most people use them interchangeably or inconsistently,
> so we will too.

If we run `ls -F /data` (*with* a leading slash) we get a different answer,
because `/data` is an **absolute path**:

~~~ {.input}
> ls -F /data
~~~

~~~ {.output}
ls: data: No such file or directory
~~~

The leading `/` tells the computer to follow the path from the root of the file system, so it always refers to exactly one directory, no matter where we are when we run the command.

What if we want to change our current working directory? Before we do this, `pwd` shows us that we're in `/home/oski`, and `ls` without any arguments shows us that directory's contents:

~~~ {.input}
> pwd
~~~

~~~ {.output}
/home/oski
~~~

~~~ {.input}
> ls
~~~

~~~ {.output}
data       file.txt                  Public                     Videos
Desktop    Music                     R
Documents  Pictures                  setup_ipython_notebook.sh
Downloads  programming-fundamentals  Templates
~~~

### Moving Around

We can use `cd` followed by a directory name to change our working directory. `cd` stands for "change directory", which is a bit misleading: the command doesn't change the directory, it changes the shell's idea of what directory we are in.

~~~ {.input}
> cd programming-fundamentals
~~~

`cd` doesn't print anything, but if we run `pwd` after it, we can see that we are now in `/home/mobaxterm/data`.

If we run `ls` without arguments now, it lists the contents of `/home/oski/data`, because that's where we now are:

~~~ {.input}
> pwd
~~~

~~~ {.output}
/home/mobaxterm/programming-fundametnals
~~~

~~~ {.input}
> ls -F
~~~

~~~ {.output}
0-0_Introduction.md	README.md		resource.md
2-0_help.md		data/			test.R
LICENSE			day_one/
~~~

We now know how to go down the directory tree: how do we go up? We could use an absolute path:

~~~ {.input}
> cd /home/oski/
~~~

but it's almost always simpler to use `cd ..` to go up one level:

~~~ {.input}
> pwd
~~~

~~~ {.output}
/home/mobaxterm/data
~~~

~~~ {.input}
> cd ..
~~~

`..` is a special directory name meaning "the directory containing this one",
or more succinctly, the **parent** of the current directory. Sure enough, if we run `pwd` after running `cd ..`, we're back in `/home/oski/`:

~~~ {.input}
> pwd
~~~

~~~ {.output}
/home/mobaxterm/
~~~

The special directory `..` doesn't usually show up when we run `ls`. If we want to display it, we can give `ls` the `-a` flag:

~~~ {.input}
> ls -a
~~~

~~~ {.output}
.              .gnome                    .rstudio-desktop
..             .ICEauthority             setup_ipython_notebook.sh
.bash_history  .ipynb_checkpoints        .subversion
.bash_logout   .ipython                  Templates
.bashrc        .local                    .thumbnails
.cache         .mozilla                  .vboxclient-clipboard.pid
.config        Music                     .vboxclient-display.pid
data           Pictures                  .vboxclient-draganddrop.pid
.dbus          .pip                      .vboxclient-seamless.pid
Desktop        .pki                      .vbox_version
Documents      .profile                  Videos
Downloads      programming-fundamentals  .Xauthority
file.txt       Public                    .xsession-errors
.gconf         R                         .xsession-errors.old
.gitconfig     .Rhistory
~~~

`-a` stands for "show all"; it forces `ls` to show us file and directory names that begin with `.`, such as `..` (which, if we're in `/home/mobaxterm`, refers to the `/users` directory).

> #### Hidden Files: For Your Own Protection
>
> As you can see, a bunch of other items just appeared when we enter `ls -a`.
> These files and directories begin with `.` followed by a name. These are
> usually files and directories that hold important programmatic information,
> not usually edited by the casual computer user. They are kept hidden so that
> users don't accidentally delete or edit them without knowing what they're
> doing.

As you can see, it also displays another special directory that's just called `.`, which means "the current working directory". It may seem redundant to have a name for it, but we'll see some uses for it soon.

> #### Phone Home
>
> If you ever want to get to the home directory immediately, you can use the
> shortcut `~`. For example, type `cd ~` and you'll get back home in a jiffy.
> `~` will also stand in for your home directory in paths, so for instance
> `~/data` is the same as `/home/oski/data`. This only works if it is the
> first character in the path: `here/there/~/elsewhere` is not
> `/home/oski/elsewhere`.


## Rochelle's Pipeline: Getting Ready

In order to start her text analysis project, Rochelle first has to figure out where her data is stored.

Everything Rochelle needs for her text project is in the `data` directory of the git repository (i.e. the directory) `programming-fundamentals`. So Rochelle will migrate there.


~~~ {.input}
> cd ~/programming-fundamentals/data
> ls
~~~

~~~ {.output}
articles  downloads
~~~

Each of Rochelle's text files is labeled according to the parameters leading to her LexisNexis Search. Since she searched and downloaded articles containing the phrase 'human rights' for each year, she will call her files `human-rights-2001.txt`, `human-rights-2002.txt`, and so on. All files are in currently in the `downloads` directory.

~~~ {.input}
> cd downloads
> ls
~~~

~~~ {.output}
human-rights-2000.TXT  human-rights-2004.TXT  human-rights-2008.TXT
human-rights-2001.TXT  human-rights-2005.TXT  human-rights-2009.TXT
human-rights-2002.TXT  human-rights-2006.TXT
human-rights-2003.TXT  human-rights-2007.TXT
~~~

If she is in her home directory, Rochelle can see what files she has using the command:

~~~ {.input}
> cd ~
> ls programming-fundamentals/data/downloads
~~~

This is a lot to type, but she can let the shell do most of the work. If she types:

~~~ {.input}
> ls prog
~~~

and then presses tab, the shell automatically completes the directory name for her:

~~~ {.input}
> ls programming-fundamentals/
~~~

Pressing tab again does nothing, since there are multiple possibilities. Pressing tab twice brings up a list of all the files and directories, and so on.

This is called **tab completion**, and we will see it in many other tools as we go on.

This is the feature that ksh is missing. It's sad and you'll cry, but you're strong on the inside and you'll find a way to move on. We believe in you!

> ####  Quick File Paths
>
> If you quickly need the path of a file or directory, you can also copy the
> file/directory in the GUI (in BCE: click on file, type `CTRL + c`) and paste
> it into your shell (in BCE: `CTRL + Shift + v`). The full path of the file
> or directory will appear.

## Exercises

#### Challenge 1

If `pwd` displays `/home/mobaxterm/programming-fundamentals`, what will `ls ../documents` display?

1.  `../documents: No such file or directory`
2.  `bce-help.desktop  Shared`
3.  `bce-help.desktop/  Shared/`
4.  no output.

#### Challenge 2

If `pwd` displays `/home/mobaxterm`, and `-r` tells `ls` to display things in reverse order, what command will display:
~~~
Videos/                     Public/                    Music/      Documents/
Templates/                  programming-fundamentals/  file.txt    Desktop/
setup_ipython_notebook.sh*  Pictures/                  Downloads/  data/
~~~

1.  `ls pwd`
2.  `ls -r -F`
3.  `ls -rF `
4.  Either \#2 or \#3 above, but not \#1.

#### Challenge 3

What does the command `cd` without a directory name do?

1.  It has no effect.
2.  It changes the working directory to `/`.
3.  It changes the working directory to the user's home directory.
4.  It produces an error message.

#### Challenge 4

What does the command `ls` do when used with the -s arguments?


---

Adapted from: [Software Carpentry](http://software-carpentry.org/v5/novice/shell/01-filedir.html)
