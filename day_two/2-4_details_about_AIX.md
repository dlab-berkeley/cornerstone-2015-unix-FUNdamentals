---
title: Details about your AIX Environment
subtitle: Unique commands and accessing GUIs
minutes: 5
---

## Introduction

AIX has a vast array of commands that enable you to do a multitude of tasks.
Depending on what you need to accomplish, you use only a certain subset of
these commands. While many commands will be familiar (or identical) from a
GNU/Linux environment, there are important differences (we already encountered
one at the beginning of our config file lesson).

Another important feature of connecting to the Cornerstone AIX machine is that
you can access it not only through the command line, but also using X Windows
to enable graphical applications, and SAS Studio will allow connecting for SAS
workflows via a web browser.

## Using a GUI

For those of you who are terrified about whether you really need to use Vi,
note that you actually have access to graphical editors via MobaXterm as well.

To see this in action, choose a file and type `vs <filename>`.

## Getting details about the AIX system

Sometimes you might be curious what's going on with the system resources. This
can be a quick sanity check to figure out if it's your code or the machine
that's causing a slowdown.

### How many processors does my system have?

To display the number of processors on your system, type:

~~~
lscfg | grep proc
~~~

### How many hard disks does my system have and which ones are in use?

To display the number of hard disks on your system, type:

~~~
lspv
~~~

### How do I list information about a specific physical volume?

To find details about hdisk1, for example, run the following command:

~~~
lspv hdisk1
~~~

**How do I display statistics for all TTY, CPU, and disks?**

To display a single set of statistics for all TTY, CPU, and disks since boot, type:

~~~
iostat
~~~

To display a continuous disk report at 2-second intervals for the disk with the
logical name `disk1`, type:

~~~
iostat -d disk1 2
~~~

**How do I display local and remote system statistics?**

Type the following command:

~~~
topas
~~~

To go directly to the process display, enter:

~~~
topas -P
~~~

To go directly to the logical partition display, enter:

~~~
topas -L
~~~

To go directly to the disk metric display, enter:

~~~
topas -D
~~~

To go directly to the file system display, enter:

~~~
topas -F
~~~

To go directly to WPAR monitoring mode `abc`, enter the following command:



~~~
topas -@ abc
~~~



To go directly to the `topas` WPAR mode, enter the following command:



~~~
topas -@
~~~



**How do I report system unit activity?**

Type the following command:



~~~
sar
~~~



To report current TTY activity for each 2 seconds for the next 40 seconds, enter the following command:



~~~
sar -y -r 2 20
~~~



To report the processor use statistics in a WPAR from the global environment, enter the following command:



~~~
sar -@ wparname
~~~



To report all of the processor activities from inside a WPAR, enter the following command:



~~~
sar -P ALL 1 1
~~~



To report processor activity for the first two processors, enter:



~~~
sar  -u  -P 0,1
~~~



This produces output similar to the following:



~~~
cpu  %usr  %sys  %wio  %idle
0      45    45     5      5
1      27    65     3      5
~~~

## Conclusion

Admittedly, a list such as this can be helpful in quickly answering some of your own questions. However, it does not cover everything that you might need. You can extend the usefulness of such a list by adding other commands that answer additional questions not addressed here.

## Resources

**Learn**

*   [AIX Information Center](https://publib16.boulder.ibm.com/pseries/en_US/infocenter/base/): This website provides the latest documentation on AIX.
*   [Introduction to Workload Partition Management in IBM AIX Version 6.1](http://www.redbooks.ibm.com/abstracts/sg247431.html?Open): This Redbooks presents WPARs, a set of completely new software-based system virtualization features introduced in IBM AIX Version 6.1.
*   [The AIX and UNIX developerWorks zone](https://www.ibm.com/developerworks/aix/) provides a wealth of information relating to all aspects of AIX systems administration and expanding your UNIX skills.
*   [developerWorks technical events and webcasts](https://www.ibm.com/developerworks/offers/techbriefings/?S_TACT=105AGY06&S_CMP=art): Stay current with developerWorks technical events and webcasts.
*   [AIX Wiki](https://www.ibm.com/collaboration/wiki/display/WikiPtype/Home): Visit this collaborative environment for technical information related to AIX.
*   [Podcasts](https://www.ibm.com/developerworks/podcast/): Tune in and catch up with IBM technical experts.
*   [AIX 5L Differences Guide Version 5.3 Edition](http://www.redbooks.ibm.com/abstracts/sg247463.html?Open)
*   [AIX 5L Differences Guide Version 5.3 Addendum](http://www.redbooks.ibm.com/abstracts/sg247414.html?Open)
*   [IBM AIX Version 6.1 Differences Guide](http://www.redbooks.ibm.com/abstracts/sg247559.html?Open)
*   [IBM AIX Version 7.1 Differences Guide](http://www.redbooks.ibm.com/abstracts/sg247910.html?Open)
*   Browse the [technology bookstore](https://www.ibm.com/developerworks/apps/SendTo?bookstore=safari) for books on these and other technical topics.
*   [IBM AIX 7.1 Information Center](https://publib.boulder.ibm.com/infocenter/aix/v7r1/index.jsp?topic=%2Fcom)
*   [IBM AIX 6.1 Information Center](https://publib.boulder.ibm.com/infocenter/aix/v6r1/index.jsp?topic=%2Fcom)
*   [IBM AIX 5.3 Information Center](https://publib.boulder.ibm.com/infocenter/pseries/v5r3/index.jsp)
*   [Writing AIX kernel extensions](https://www.ibm.com/developerworks/aix/library/au-kernelext.html)

**Get products and technologies**

*   [IBM trial software](https://www.ibm.com/developerworks/downloads/?S_TACT=105AGY06&S_CMP=art): Build your next development project with software for download directly from developerWorks.

**Discuss**

*   Participate in the AIX and UNIX forums:
    *   [AIX Forum](https://www.ibm.com/developerworks/forums/dw_forum.jsp?forum=747&amp;cat=72)
    *   [AIX Forum for developers](https://www.ibm.com/developerworks/forums/dw_forum.jsp?forum=905&amp;cat=72)
    *   [Cluster Systems Management](https://www.ibm.com/developerworks/forums/dw_forum.jsp?forum=907&amp;cat=72)
    *   [IBM Support Assistant Forum](https://www.ibm.com/developerworks/forums/dw_forum.jsp?forum=935&amp;cat=72)
    *   [Performance Tools Forum](https://www.ibm.com/developerworks/forums/dw_forum.jsp?forum=749&amp;cat=72)
    *   [Virtualization Forum](https://www.ibm.com/developerworks/forums/forum.jspa?forumID=748)
    *   More [AIX and UNIX Forums](https://www.ibm.com/developerworks/forums/dw_auforums.jsp)
    *   [AIX Networking](https://www.ibm.com/developerworks/forums/forum.jspa?forumID=1333)

Adapted from [IBMdeveloperWorks - IBM AIX commands you should not leave home without](https://www.ibm.com/developerworks/aix/library/au-aix_cmds/)
