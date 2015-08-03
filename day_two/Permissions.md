# Permissions

The Unix-like operating systems, such as Linux differ from other computing systems in that they are not only _multitasking_ but also _multi-user_.

What exactly does this mean? It means that more than one user can be operating the computer at the same time. While your computer only has one keyboard and monitor, it can still be used by more than one user. For example, if your computer is attached to a network, or the Internet, remote users can log in via <tt class="user">[ssh](lc3_man_pages/ssh1.html)</tt> (secure shell) and operate the computer. In fact, remote users can execute graphical applications and have the output displayed on a remote computer. The X Window system supports this.

The multi-user capability of Unix-like systems is a feature that is deeply ingrained into the design of the operating system. If you remember the environment in which Unix was created, this makes perfect sense. Years ago before computers were "personal," they were large, expensive, and centralized. A typical university computer system consisted of a large mainframe computer located in some building on campus and _terminals_ were located throughout the campus, each connected to the large central computer. The computer would support many users at the same time.

In order to make this practical, a method had to be devised to protect the users from each other. After all, you could not allow the actions of one user to crash the computer, nor could you allow one user to interfere with the files belonging to another user.

This lesson will cover the following commands:

*   <tt class="user">[chmod](lc3_man_pages/chmod1.html)</tt> - modify file access rights
*   <tt class="user">[su](lc3_man_pages/su1.html)</tt> - temporarily become the superuser
*   <tt class="user">[sudo](lc3_man_pages/sudo1.html)</tt> - temporarily become the superuser
*   <tt class="user">[chown](lc3_man_pages/chown1.html)</tt> - change file ownership
*   <tt class="user">[chgrp](lc3_man_pages/chgrp1.html)</tt> - change a file's group ownership

## File Permissions

On a Linux system, each file and directory is assigned access rights for the owner of the file, the members of a group of related users, and everybody else. Rights can be assigned to read a file, to write a file, and to execute a file (i.e., run the file as a program).

To see the permission settings for a file, we can use the <tt class="user">ls</tt> command. As an example, we will look at the <tt class="user">bash</tt> program which is located in the <tt class="user">/bin</tt> directory:

<div class="display">

<tt class="prompt">[me@linuxbox me]$</tt> <tt class="cmd">ls -l /bin/bash</tt>

<pre> <tt class="prompt">-rwxr-xr-x 1 root root  316848 Feb 27  2000 /bin/bash</tt>
</pre>

</div>

Here we can see:

*   The file "/bin/bash" is owned by user "root"
*   The superuser has the right to read, write, and execute this file
*   The file is owned by the group "root"
*   Members of the group "root" can also read and execute this file
*   Everybody else can read and execute this file

In the diagram below, we see how the first portion of the listing is interpreted. It consists of a character indicating the file type, followed by three sets of three characters that convey the reading, writing and execution permission for the owner, group, and everybody else.

![permissions diagram](images/file_permissions.png)

## <a name="chmod">chmod</a>

The <tt class="user">chmod</tt> command is used to change the permissions of a file or directory. To use it, you specify the desired permission settings and the file or files that you wish to modify. There are two ways to specify the permissions. In this lesson we will focus on one of these, called the _octal notation_ method.

It is easy to think of the permission settings as a series of bits (which is how the computer thinks about them). Here's how it works:

<pre><tt>rwx rwx rwx = 111 111 111
rw- rw- rw- = 110 110 110
rwx --- --- = 111 000 000

and so on...

rwx = 111 in binary = 7
rw- = 110 in binary = 6
r-x = 101 in binary = 5
r-- = 100 in binary = 4</tt> 
</pre>

Now, if you represent each of the three sets of permissions (owner, group, and other) as a single digit, you have a pretty convenient way of expressing the possible permissions settings. For example, if we wanted to set <tt>some_file</tt> to have read and write permission for the owner, but wanted to keep the file private from others, we would:

<div class="display">

<tt class="prompt">[me@linuxbox me]$</tt> <tt class="cmd">chmod 600 some_file</tt>

</div>

Here is a table of numbers that covers all the common settings. The ones beginning with "7" are used with programs (since they enable execution) and the rest are for other kinds of files.

| **Value** | **Meaning** |
| 

**777**

 | 

**(rwxrwxrwx)** No restrictions on permissions. Anybody may do anything. Generally not a desirable setting.

 |
| 

**755**

 | 

**(rwxr-xr-x)** The file's owner may read, write, and execute the file. All others may read and execute the file. This setting is common for programs that are used by all users.

 |
| 

**700**

 | 

**(rwx------)** The file's owner may read, write, and execute the file. Nobody else has any rights. This setting is useful for programs that only the owner may use and must be kept private from others.

 |
| 

**666**

 | 

**(rw-rw-rw-)** All users may read and write the file.

 |
| 

**644**

 | 

**(rw-r--r--)** The owner may read and write a file, while all others may only read the file. A common setting for data files that everybody may read, but only the owner may change.

 |
| 

**600**

 | 

**(rw-------)** The owner may read and write a file. All others have no rights. A common setting for data files that the owner wants to keep private.

 |

## Directory Permissions

The <tt class="user">chmod</tt> command can also be used to control the access permissions for directories. Again, we can use the octal notation to set permissions, but the meaning of the r, w, and x attributes is different:

*   **r** - Allows the contents of the directory to be listed if the x attribute is also set.
*   **w** - Allows files within the directory to be created, deleted, or renamed if the x attribute is also set.
*   **x** - Allows a directory to be entered (i.e. <tt class="user">cd dir</tt>).

Here are some useful settings for directories:

| **Value** | **Meaning** |
| 

**777**

 | 

**(rwxrwxrwx)** No restrictions on permissions. Anybody may list files, create new files in the directory and delete files in the directory. Generally not a good setting.

 |
| 

**755**

 | 

**(rwxr-xr-x)** The directory owner has full access. All others may list the directory, but cannot create files nor delete them. This setting is common for directories that you wish to share with other users.

 |
| 

**700**

 | 

**(rwx------)** The directory owner has full access. Nobody else has any rights. This setting is useful for directories that only the owner may use and must be kept private from others.

 |

## Becoming The Superuser For A Short While

It is often necessary to become the superuser to perform important system administration tasks, but as you have been warned, you should not stay logged in as the superuser. In most distributions, there is a program that can give you temporary access to the superuser's privileges. This program is called <tt class="user">su</tt> (short for substitute user) and can be used in those cases when you need to be the superuser for a small number of tasks. To become the superuser, simply type the <tt class="user">su</tt> command. You will be prompted for the superuser's password:

<div class="display">

<tt class="prompt">[me@linuxbox me]$</tt> <tt class="cmd">su</tt>
 <tt class="prompt">Password:</tt>
 <tt class="prompt">[root@linuxbox me]#</tt>

</div>

After executing the <tt class="user">su</tt> command, you have a new shell session as the superuser. To exit the superuser session, type <tt class="user">exit</tt> and you will return to your previous session.

In some distributions, most notably Ubuntu, an alternate method is used. Rather than using <tt class="user">su</tt>, these systems employ the <tt class="user">sudo</tt> command instead. With <tt class="user">sudo</tt>, one or more users are granted superuser privileges on an as needed basis. To execute a command as the superuser, the desired command is simply preceeded with the <tt class="user">sudo</tt> command. After the command is entered, the user is prompted for the user's password rather than the superuser's:

<div class="display">

<tt class="prompt">[me@linuxbox me]$</tt> <tt class="cmd">sudo some_command</tt>
 <tt class="prompt">Password:</tt>
 <tt class="prompt">[me@linuxbox me]$</tt>

</div>

## Changing File Ownership

You can change the owner of a file by using the <tt class="user">chown</tt> command. Here's an example: Suppose I wanted to change the owner of <tt>some_file</tt> from "me" to "you". I could:

<div class="display">

<tt class="prompt">[me@linuxbox me]$</tt> <tt class="cmd">su</tt>
 <tt class="prompt">Password:</tt>
 <tt class="prompt">[root@linuxbox me]#</tt> <tt class="cmd">chown you some_file</tt>
 <tt class="prompt">[root@linuxbox me]#</tt> <tt class="cmd">exit</tt>
 <tt class="prompt">[me@linuxbox me]$</tt>

</div>

Notice that in order to change the owner of a file, you must be the superuser. To do this, our example employed the <tt class="user">su</tt> command, then we executed <tt class="user">chown</tt>, and finally we typed <tt class="user">exit</tt> to return to our previous session.

<tt class="user">chown</tt> works the same way on directories as it does on files.

## Changing Group Ownership

The group ownership of a file or directory may be changed with <tt class="user">chgrp</tt>. This command is used like this:

<div class="display">

<tt class="prompt">[me@linuxbox me]$</tt> <tt class="cmd">chgrp new_group some_file</tt>

</div>

In the example above, we changed the group ownership of <tt>some_file</tt> from its previous group to "new_group". You must be the owner of the file or directory to perform a <tt class="user">chgrp</tt>.

* * *

© 2000-2015, [William E. Shotts, Jr.](mailto:bshotts@users.sourceforge.net) Verbatim copying and distribution of this entire article is permitted in any medium, provided this copyright notice is preserved.

Linux® is a registered trademark of Linus Torvalds.

</div>
