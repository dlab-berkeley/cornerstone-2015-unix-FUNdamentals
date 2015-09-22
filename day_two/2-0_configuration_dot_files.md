---
title: Configuration and Dot Files
subtitle: Improving your AIX-UNIX setup
minutes: 5
---

It is possible to customize the behavior of nearly anything you'd type at the
command line. For example the global alias in bash on Cornerstone's AIX machine
now actually calls the native AIX `df`.  The reason for this is that the GNU
`df` gets an integer overflow and displays negative values.

> - Try `\df` now and you’ll see this.
> - The alias in `/etc/bashrc` is `alias df='/usr/bin/df -g'` - can you find
>   this line in the file?
> - We can also see the aliases in effect by typing `alias`. Try this now.

You are not stuck with these aliases. You can define your own at the command
line or in your `.bashrc` file. The same syntax is used in both cases
(remember, bash scripts are simply a file with things you might type at the
command line!).

> Create an alias now: `alias ls='ls -F --color=auto'`. What happens when you
> type `ls` after this?

You could also override the global `ll` alias (`alias ll='ls -ltarhF
--time-style=locale'`) with something more to your liking.

We'll come back to some specific configuration items tomorrow when we focus on
Git.
