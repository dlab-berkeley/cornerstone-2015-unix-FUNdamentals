---
title: Networked environments
subtitle: Command line on AIX-UNIX
minutes: 5
---

## Introduction

As you know, AIX has a vast array of commands that enable you to do a multitude of tasks. Depending on what you need to accomplish, you use only a certain subset of these commands. These subsets differ from user to user and from need to need. However, there are a few core commands that you commonly use. You need these commands either to answer your own questions or to provide answers to the queries of the support professionals.

In this article, I'll discuss some of these core commands. The intent is to provide a list that you can use as a ready reference. The behavior of these commands should be identical in all releases of AIX. The exceptions have been noted where that is not true.

# Commands

## Kernel

**How do I know if I am running a uniprocessor kernel or a multiprocessor kernel, or a 32-bit kernel or a 64-bit kernel?**

`/unix` is a symbolic link to the booted kernel. To find out what kernel mode is running, enter `ls -l /unix` and see what file `/unix` it links to. The following are the three possible outputs from the `ls -l /unix` command and their corresponding kernels:

~~~
/unix -> /usr/lib/boot/unix_up 		# 32 bit uniprocessor kernel
/unix -> /usr/lib/boot/unix_mp 		# 32 bit multiprocessor kernel
/unix -> /usr/lib/boot/unix_64 		# 64 bit multiprocessor kernel~~~
~~~

**Note:**
AIX 5L Version 5.3 does not support a uniprocessor kernel.

**How can I change from one kernel mode to another?**

During the installation process, one of the kernels, appropriate for the AIX version and the hardware in operation, is enabled by default. Use the method from the previous question and assume that the 32-bit kernel is enabled. Also assume that you want to boot it up in the 64-bit kernel mode. This can be done by running the following commands in sequence:

~~~
ln -sf /usr/lib/boot/unix_64    /unix
ln -sf /usr/lib/boot/unix_64    /usr/lib/boot/unix

bosboot -ad  /dev/hdiskxx
shutdown -r~~~
~~~

The /dev/hdiskxx directory is where the boot logical volume /dev/hd5 is located. To find out what xx is in hdiskxx, run the following command:

~~~
lslv -m hd5
~~~

**Note:**
In AIX V5.2, the 32-bit kernel is installed by default. In AIX V5.3, the 64-bit kernel is installed on 64-bit hardware and the 32-bit kernel is installed on 32-bit hardware by default.

### Hardware

**How do I know if my machine is capable of running AIX 5L Version 5.3?**

AIX 5L Version 5.3 supports all 32- bit and 64-bit Common Hardware Reference Platform (CHRP)-based IBM Power® hardware. Only 64-bit CHRP systems are supported with AIX 6.1 and AIX V7.1.

**How do I know if my machine is CHRP-based?**

Run the `prtconf` command. If it is a CHRP machine, the string `chrp` appears on the Model Architecture line.

**How do I know if my Power Systems machine (hardware) is 32-bit or 64-bit?**

Run the `prtconf` command.

**How much real memory does my machine have?**

To display real memory in kilobytes (KB), type one of the following:

~~~
lsattr -El sys0 -a realmem
~~~


**Can my machine run the 64-bit kernel?**

64-bit hardware is required to run the 64-bit kernel.

**What are the values of attributes for devices in my system?**

To list the current values of the attributes for the tape device, rmt0, type:



~~~
lsattr -l rmt0 -E
~~~



To list the default values of the attributes for the tape device, rmt0, type:



~~~
lsattr -l rmt0 -D
~~~



To list the possible values of the login attribute for the TTY device, `tty0`, type:



~~~
lsattr -l tty0 -a login -R
~~~



To display system-level attributes, type:



~~~
lsattr -E -l sys0
~~~



**How many processors does my system have?**

To display the number of processors on your system, type:



~~~
lscfg | grep proc
~~~



**How many hard disks does my system have and which ones are in use?**

To display the number of hard disks on your system, type:



~~~
lspv
~~~



**How do I list information about a specific physical volume?**

To find details about hdisk1, for example, run the following command:



~~~
lspv hdisk1
~~~



**How do I get a detailed configuration of my system?**

Type the following:



~~~
lscfg
~~~



The following options provide specific information:

| Option | Description |
| --- | --- |
| **-p** | Displays platform-specific device information. The flag is applicable to AIX V4.2.1 or later. |
| **-v** | Displays the vital product data (VPD) found in the customized VPD object class. |

For example, to display details about the tape drive, rmt0, type:



~~~
lscfg -vl rmt0
~~~



You can obtain similar information by running the `prtconf` command.

**How do I find out the chip type, system name, node name, model number, and so forth?**

The `uname` command provides details about your system.

| Command | Description |
| --- | --- |
| **uname -p** | Displays the chip type of the system. For example, IBM PowerPC®. |
| **uname -r** | Displays the release number of the operating system. |
| **uname -s** | Displays the system name. For example, AIX. |
| **uname -n** | Displays the name of the node. |
| **uname -a** | Displays the system name, nodename, version, machine ID. |
| **uname -M** | Displays the system model name. For example, IBM, 9114-275. |
| **uname -v** | Displays the operating system version. |
| **uname -m** | Displays the machine ID number of the hardware running the system. |
| **name -u** | Displays the system ID number. |

### AIX

**What is the technology level of my system?**

To determine the highest technology level reached for the current version of AIX on the system, type:



~~~
oslevel -r
lslpp -h bos.rte
~~~



To list the installation state for the most-recent level of installed file sets for all of the bos.rte file sets, type:



~~~
lslpp -l "bos.rte.*"
~~~



To list which software is below AIX Version 5.3 technology level 1, type:



~~~
oslevel -r -l 5300-01
~~~



To list which software is at a level later than AIX Version 5.3 technology level 1, type:



~~~
oslevel -r -g 5300-01
~~~



To determine the highest service pack reached for the current technology level on the system, type:



~~~
oslevel -s
~~~



To list the known service packs on a system, type:



~~~
oslevel -sq
~~~



The levels returned can be used with the [ -s -l ] or [ -s -g ] flags, and will be similar to the following:



~~~
Known service packs
**-------------------**
6100-00-02-0750
6100-00-01-0748
6100-00-00-0000
~~~



To list which software is below AIX Version 6.1 technology level 0, service pack 1, type:



~~~
oslevel -s -l 6100-00-01-0748
~~~



To list which software is at a level later than AIX Version 6.1 technology level 0, service pack 1, type:



~~~
oslevel -s -g 6100-00-01-0748
~~~



**How do I create a file system?**

The following command will create, within volume group testvg, a journaled file system (JFS) of 10 MB with mounting point /fs1:



~~~
crfs -v jfs -g testvg -a size=10M -m /fs1
~~~



The following command creates, within the testvg volume group, a enhanced journaled file system (JFS2) of 10 MB with mounting point /fs2 and having read-only permissions:



~~~
crfs -v jfs2 -g testvg -a size=10M -p ro -m /fs2
~~~



To make a JFS on the rootvg volume group with nondefault fragment size and nondefault number of bytes per i-node (NBPI), enter:



~~~
crfs  -v jfs  -g  rootvg  -m /test -a \ size=32768 -a frag=512 -a nbpi=1024
~~~



This command creates the /test file system on the rootvg volume group with a fragment size of 512 bytes, a NBPI ratio of 1024, and an initial size of 16 MB (512 * 32768).

To make a JFS on the rootvg volume group with nondefault fragment size and nondefault NBPI, enter:



~~~
crfs -v jfs -g rootvg -m /test -a size=16M -a frag=512 -a nbpi=1024
~~~



This command creates the /test file system on the rootvg volume group with a fragment size of 512 bytes, a NBPI ratio of 1024, and an initial size of 16 MB.

**How do I change the size of a file system?**

To increase the `/usr` file system size by 1000000 512-byte blocks, type:



~~~
chfs -a size=+1000000 /usr
~~~



To change the file system size of the /test JFS, enter:



~~~
chfs  -a size=24576 /test
~~~



This command changes the size of the /test JFS to 24576 512-byte blocks, or 12 MB (provided, it was previously no larger than this).

To increase the size of the /test JFS, enter:



~~~
chfs  -a size=+8192 /test
~~~



This command increases the size of the /test Journaled File System by 8192 512-byte blocks, or 4 MB.

To change the mount point of a file system, enter:



~~~
chfs  -m /test2 /test
~~~



This command changes the mount point of a file system from /test to /test2.

To delete the accounting attribute from a file system, enter:



~~~
chfs -d account /home
~~~



This command removes the accounting attribute from the /home file system. The accounting attribute is deleted from the /home: stanza of the /etc/filesystems file.

To split off a copy of a mirrored file system and mount it read-only for use as an online backup, enter:



~~~
chfs -a splitcopy=/backup -a copy=2 /testfs
~~~



This mounts a read-only copy of /testfs at /backup.

To change the file system size of the /test JFS, enter:



~~~
chfs -a size=64M /test
~~~



This command changes the size of the /test JFS to 64 MB (provided, it was previously no larger than this).

To reduce the size of the /test JFS2 file system, enter:



~~~
chfs  -a size=-16M /test
~~~



This command reduces the size of the /test JFS2 file system by 16 MB.

**Note:**
In AIX V5.3, the size of a JFS2 file system can be shrunk, as well.

**How do I mount a CD?**

Type the following:



~~~
mount -V cdrfs -o ro /dev/cd0  /cdrom
~~~



**How do I mount a file system?**

The following command will mount file system /dev/fslv02 on the /test directory:



~~~
mount /dev/fslv02 /test
~~~



**How do I mount all default file systems (all standard file systems in the /etc/filesystems file marked by the mount=true attribute)?**

The following command will mount all such file systems:



~~~
mount {-a|all}
~~~



**How do I display mounted file systems?**

Type the following command to display information about all currently mounted file systems:



~~~
mount
~~~



To mount a remote directory, enter the following command:



~~~
mount -n nodeA /home/tom.remote /home/tom.local
~~~



This command sequence mounts the /home/tom.remote directory located on nodeA onto the local /home/tom.local directory. It assumes the default `VfsName parameter=remote`, which must be defined in the /etc/vfs file.

To mount a file or directory from the /etc/file systems file with a specific type, enter the following command:



~~~
mount -t remote
~~~



This command sequence mounts all files or directories in the /etc/file systems file that have a stanza containing the `type=remote` attribute.

To mount a snapshot, enter the following command:



~~~
mount -o snapshot /dev/snapsb /home/janet/snapsb
~~~



This command mounts the snapshot contained on the /dev/snapsb device onto the /home/janet/snapsb directory.

To mount a file system and create a snapshot, enter the following command:



~~~
mount -o snapto=/dev/snapsb /dev/sb /home/janet/sb
~~~



This command mounts the file system contained on the /dev/sbdevice directory onto the /home/janet/sb directory and creates a snapshot for the file system on /dev/snapsbdevice.

To remount the mounted read-only JFS2 file system to a read-write file system, enter the following command:



~~~
mount o remount,rw fsname
~~~



**Note:**

The `remount` option is not available in AIX 5.3.

**How do I unmount a file system?**

Type the following command to unmount the /test file system:



~~~
umount /test
~~~



To unmount all mounts from the Node A remote node, enter:



~~~
umount  -n nodeA
~~~



**How do I remove a file system?**

Type the following command to remove the /test file system:



~~~
rmfs /test
~~~



This removes the /test file system, its entry in the /etc/filesystems file, and the underlying logical volume.

**How can I defragment a file system?**

The `defragfs` command can be used to improve or report the status of contiguous space within a file system. For example, to defragment the file system /home, use the following command:



~~~
defragfs /home
~~~



To generate a report on the /data1 file system that indicates its current status as well as its status after being defragmented, enter:



~~~
defragfs  -r /data1
~~~



To generate a report on the fragmentation in the /data1 file system, enter:



~~~
defragfs -s /data1
~~~



**Which file set contains a particular binary?**

To list the file set that owns `/usr/bin/vmstat`, type:



~~~
lslpp -w /usr/bin/vmstat
~~~



To display all files in the inventory database, type:



~~~
lslpp -w
~~~



To list the file set that owns all file names containing `installp`, type:



~~~
lslpp -w "*installp*"
~~~



Or, to show which file set contains `/usr/bin/svmon`, type:



~~~
which_fileset svmon
~~~



**How do I display information about the installed file sets on my system?**

Type the following command:



~~~
lslpp -l
~~~



To list the installation state for the most recent level of installed file sets for all of the bos.rte file sets, type:



~~~
lslpp -l "bos.rte.*"
~~~



To list the installation state for the base level and updates for the bos.rte.filesystem file set, type:



~~~
lslpp -La bos.rte.filesystem
~~~



To list the names of all the files of the bos.rte.lvm file set, type:



~~~
lslpp -f bos.rte.lvm
~~~



To list the file set that owns all file names containing `installp`, type:



~~~
lslpp -w "*installp*"
~~~



**How do I determine if all file sets of technology level are installed on my system?**

Type the following command:



~~~
instfix -i | grep TL
~~~



**How do I determine if a fix is installed on my system?**

To inform the user on whether fixes IX38794 and IX48523 are installed, type:



~~~
instfix  -i  -k "IX38794 IX48523"
~~~



**How do I install an individual fix by APAR?**

To install APAR IY73748 from `/dev/cd0`, for example, enter the command:



~~~
instfix -k IY73748 -d /dev/cd0
~~~



To install all file sets associated with fix IX38794 from the tape mounted on /dev/rmt0.1, type:



~~~
instfix  -k IX38794  -d /dev/rmt0.1
~~~



To install all fixes on the media in the tape drive, type:



~~~
instfix  -T  -d /dev/rmt0.1 | instfix  -d /dev/rmt0.1  -f-
~~~



The first part of this command lists the fixes on the media, and the second part of this command uses the list as input.

**How do I verify if file sets have required prerequisites and are completely installed?**

To show the file sets that need to be installed or corrected, type:



~~~
lppchk -v
~~~



**How do I get a dump of the header of the loader section and the symbol entries in symbolic representation?**

Type the following command:



~~~
dump -Htv
~~~



To dump the object file headers, enter:



~~~
dump -o a.out
~~~



To dump line number information for the a.out file, enter:



~~~
dump -l a.out
~~~



To dump the contents of the a.out object file text section, enter:



~~~
dump -s a.out
~~~



To dump symbol table information for the a.out object file, enter:



~~~
dump -t a.out
~~~



**Note:**

Firmware-assisted dump is now the default dump type in AIX V7.1, when the hardware platform supports firmware-assisted dump. The traditional dump remains the default dump type for AIX V6.1, even when the hardware platform supports firmware-assisted dump.



~~~
# oslevel -s
6100-00-03-0808
# sysdumpdev -l
primary 		/dev/lg_dumplv
secondary 		/dev/sysdumpnull
copy directory 		/var/adm/ras
forced copy flag 	TRUE
always allow dump 	FALSE
dump compression 	ON
type of dump 		traditional

# oslevel -s
7100-00-00-0000
# sysdumpdev -l
primary 		/dev/lg_dumplv
secondary 		/dev/sysdumpnull
copy directory 		/var/adm/ras
forced copy flag 	TRUE
always allow dump 	FALSE
dump compression 	ON
type of dump 		fw-assisted
full memory dump 	disallow
~~~



To set the full memory dump option, type:



~~~
# sysdumpdev -f require
# sysdumpdev -l
primary 		/dev/lg_dumplv
secondary 		/dev/sysdumpnull
copy directory 		/var/adm/ras
forced copy flag 	TRUE
always allow dump 	FALSE
dump compression 	ON
type of dump 		fw-assisted
full memory dump 	require
~~~



The full memory system dump mode is now allowed. To change to the traditional dump on AIX V7.1, type:



~~~
# sysdumpdev -t traditional
# sysdumpdev -l
primary 		/dev/lg_dumplv
secondary 		/dev/sysdumpnull
copy directory 		/var/adm/ras
forced copy flag 	TRUE
always allow dump 	FALSE
dump compression 	ON
type of dump 		traditional
~~~



To reinstate firmware-assisted dump, type:



~~~
# sysdumpdev -t fw-assisted
~~~



**Note:**

The firmware-assisted system dump will be configured at the next reboot.

**How do I determine the amount of paging space allocated and in use?**

Type the following:



~~~
lsps -a
~~~



**How do I increase a paging space?**

You can use the `chps -s` command to dynamically increase the size of a paging space. For example, if you want to increase the size of hd6 with three logical partitions, you issue the following command:



~~~
chps -s 3 hd6
~~~



To change the size of the myvg paging space, enter:



~~~
chps  -s 4 myvg
~~~



This adds four logical partitions to the myvg paging space.

**How do I reduce a paging space?**

You can use the `chps``-d` command to dynamically reduce the size of a paging space. For example, if you want to decrease the size of hd6 with four logical partitions, you issue the following command:



~~~
chps -d 4 hd6
~~~



**How would I know if my system is capable of using simultaneous multithreading (SMT)?**

Your system is capable of SMT if it is an IBM POWER5 processor-based system or later running AIX 5L Version 5.3 or later.

**How would I know if SMT is enabled for my system?**

If you run the `smtctl` command without any options, it tells you if it is enabled or not.

**Is SMT supported for the 32-bit kernel?**

Yes, SMT is supported for both 32-bit and 64-bit kernel.

**Note:**

AIX V5.3 32-bit kernel only supports SMT 2\. For SMT 4 exploitation, you would need to run AIX V5.3 in a versioned workload partition (WPAR) on top of AIX V7.1 (described in the Workload partitions section). The 32-bit kernel was removed in AIX V6.1.

**How do I enable or disable SMT?**

You can enable or disable SMT by running the `smtctl` command. The following is the syntax:



~~~
smtctl [ -m off | on [ -w boot | now]]
~~~



The following options are available:

| Option | Description |
| --- | --- |
| **-m off** | Sets SMT mode to disabled |
| **-m on** | Sets SMT mode to enabled |
| **-w boot** | Makes the SMT mode change effective on next and subsequent reboots if you run the `bosboot` command before the next system reboot |
| **-w now** | Makes the SMT mode change immediately but will not persist across reboot |

**If neither the** `**-w boot**` **option nor the** `**-w now**` **option is specified, then the mode change is made immediately. It persists across subsequent reboots if you run the** `**bosboot**` **command before the next system reboot.**

To disable simultaneous multithreading for the current boot cycle and for all subsequent boots, enter:



~~~
smtctl -m off
~~~



The system displays a message similar to the following:

smtctl: SMT is now disabled. It will persist across reboots if you run the `bosboot` command before the next reboot.

**How do I get partition-specific information and statistics?**

**The** **`lparstat`** **command provides a report of partition information and utilization statistics. This command also provides a display of hypervisor information.**

To get the default LPAR statistics, enter the following command:



~~~
lparstat 1 1
~~~



To get default LPAR statistics with summary statistics on Hypervisor, enter the following command:



~~~
lparstat h 1 1
~~~



To get the information about the partition, enter the following command:



~~~
lparstat -i
~~~



To get detailed hypervisor statistics, enter the following command:



~~~
lparstat H 1 1
~~~



To get statistics about the shared memory pool and the I/O memory entitlement of the partition, enter the following command:



~~~
lparstat m
~~~



**Note:**

The `m` option is not available in AIX 5.3.

**Volume groups and logical volumes**

AIX V7.1 includes enhanced support for solid-state drive (SSD) in the AIX Logical Volume Manager (LVM). The commands `lsvg, mkvg, chvg, extendvg,` and `replacepv` described in the following sections support creation, extension, and maintenance of volume groups consisting of SSDs.

**How do I know if my volume group is normal, big, or scalable?**

Run the `lsvg` command on the volume group and look at the value for MAX PVs. The value is 32 for normal, 128 for big, and 1024 for scalable volume group.

**How can I create a volume group?**

Use the following command, where `s` _partition_size_ sets the number of megabytes (MB) in each physical partition where the `partition_size` is expressed in units of MB from 1 through 1024\. (It is 1 through 131072 for AIX V5.3.) The `partition_size` variable must be equal to a power of 2 (for example: 1, 2, 4, 8). The default value for standard and big volume groups is the lowest value to remain within the limitation of 1016 physical partitions per physical volume. The default value for scalable volume groups is the lowest value to accommodate 2040 physical partitions per physical volume.



~~~
mkvg -y _name_of_volume_group_ -s _partition_size_ _list_of_hard_disks_
~~~



To create a volume group that contains three physical volumes with partition size set to 1 MB, type:



~~~
mkvg  -s 1 hdisk3 hdisk5 hdisk6
~~~



The volume group is created with an automatically generated name, which is displayed and available at system restart time.

To create a volume group that can accommodate a maximum of 1024 physical volumes and 2048 logical volumes, type:



~~~
mkvg -S -v 2048 hdisk6
~~~



**How can I change the characteristics of a volume group?**

You use the following command to change the characteristics of a volume group:



~~~
chvg
~~~



To cause volume group vg03 to be automatically activated during system startup, type:



~~~
chvg  -a y vg03
~~~



In AIX 7.1, you can also use the System Management Interface Tool (SMIT) `smit chvg` fast path to run this command.

**How do I create a logical volume?**

Type the following:



~~~
mklv -y _name_of_logical_volume_ _name_of_volume_group_ _number_of_partition_
~~~



To make a logical volume in vg03 with 15 logical partitions chosen from physical volumes hdisk5, hdisk6, and hdisk9, type:



~~~
mklv vg03 15 hdisk5 hdisk6 hdisk9
~~~



**How do I increase the size of a logical volume?**

To increase the size of the logical volume represented by the lv05 directory by three logical partitions, for example, type:



~~~
extendlv lv05 3
~~~



**How do I display all logical volumes that are part of a volume group (for example, rootvg)?**

You can display all logical volumes that are part of rootvg by typing the following command:



~~~
lsvg -l rootvg
~~~



To display the names of all active volume groups, enter the following command:



~~~
lsvg -o
~~~



To display the names of all volume groups within the system, enter the following command:



~~~
lsvg
~~~



To display information about volume group vg02, enter the following command:



~~~
lsvg vg02
~~~



The characteristics and status of both the logical and physical partitions of volume group vg02 are displayed.

**How do I list information about logical volumes?**

Run the following command to display information about the logical volume lv1:



~~~
lslv lv1
~~~



**To display the logical volume allocation map for hdisk2, enter:**



~~~
lslv -p hdisk2
~~~



An allocation map for hdisk2 is displayed, showing the state of each partition. Because no `_LogicalVolume_` parameter was included, the map does not contain logical partition numbers specific to any logical volume.

To display information about the lv03 logical volume by physical volume, enter:



~~~
lslv -l lv03
~~~



The characteristics and status of lv03 are displayed, with the output arranged by physical volume.

**How do I remove a logical volume from a volume group?**

You can remove the logical volume lv7 by running the following command:



~~~
rmlv lv7
~~~



The `rmlv` command removes only the logical volume, but does not remove other entities, such as file systems or paging spaces that were using the logical volume.

**How do I mirror a logical volume?**

1.  `mklvcopy` _`LogicalVolumeName Numberofcopies`_
2.  `syncvg` _`VolumeGroupName`_

The `syncvg` command synchronizes the logical volume copies.

To add physical partitions to the logical partitions in the `lv01` logical volume, so that a total of three copies exist for each logical partition, enter:



~~~
mklvcopy lv01 3
~~~



The logical partitions in the logical volume represented by the `lv01` directory have three copies.

**How do I remove a copy of a logical volume?**

You can use the `rmlvcopy` command to remove copies of logical partitions of a logical volume. To reduce the number of copies of each logical partition belonging to the `testlv` logical volume, enter:



~~~
rmlvcopy testlv 2
~~~



Each logical partition in the logical volume now has at most two physical partitions.

**Queries about volume groups**

To show volume groups in the system, type:



~~~
lsvg
~~~



To show all the characteristics of `rootvg`, type:



~~~
lsvg rootvg
~~~



To show disks used by `rootvg`, type:



~~~
lsvg -p rootvg
~~~



**How to add a disk to a volume group?**

Type the following:



~~~
extendvg   _VolumeGroupName_   hdisk0 hdisk1 ... hdiskn
~~~



To add physical volumes `hdisk3` and `hdisk8` to volume group `vg3`, enter:



~~~
extendvg vg3 hdisk3 hdisk8
~~~



**Note:**

The volume group must be varied on before extending.

**How do I find out the maximum supported logical track group (LTG) size of my hard disk?**

You can use the `lquerypv` command with the `-M` flag. The output gives the LTG size in KB. For instance, the LTG size for hdisk0 in the following example is 256 KB.



~~~
/usr/sbin/lquerypv -M hdisk0
256
~~~



You can also run the `lspv` command on the hard disk and look at the value for MAX REQUEST.

**What does the** `**syncvg**` **command do?**

The `syncvg` command is used to synchronize stale physical partitions. It accepts names of logical volumes, physical volumes, or volume groups as parameters.

For example, to synchronize the physical partitions located on physical volumes `hdisk4` and `hdisk5`, use:



~~~
syncvg -p hdisk4 hdisk5
~~~



To synchronize all physical partitions from volume group `testvg`, use:



~~~
syncvg -v testvg
~~~



To synchronize the copies on volume groups `vg04` and `vg05`, enter:



~~~
syncvg -v vg04 vg05
~~~



**How do I replace a disk?**

1.  `extendvg`_ `VolumeGroupName hdisk_new`_
2.  `migratepv`_ `hdisk_bad hdisk_new`_
3.  `reducevg -d` _`VolumeGroupName hdisk_bad`_

The command `migratepv` moves allocated physical partitions from one physical volume to one or more other physical volumes.

The `reducevg` command removes physical volumes from a volume group. When all the physical volumes are removed from the volume group, the volume group is deleted.

**How can I clone (make a copy of) the rootvg?**

You can run the `alt_disk_copy` command to copy the current rootvg to an alternate disk. The following example shows how to clone the rootvg to hdisk1.



~~~
alt_disk_copy -d  hdisk1
~~~



### Network

**How can I display or set values for network parameters?**

The `no` command sets or displays current or next boot values for network tuning parameters.

To display the maximum size of the mbuf pool, type:



~~~
no -o thewall
~~~



To change the default socket buffer sizes on your system, type:



~~~
no -r -o tcp_sendspace=32768
no -r -o udp_recvspace=32768
~~~



To use a system as an Internet work router over the Internet Protocol networks, type:



~~~
no -o ipforwarding=1
~~~



To list the current and reboot value, range, unit, type and dependencies of all tunable parameters that are managed by the `no` command, type:



~~~
no -L
~~~



**How do I get the IP address of my machine?**

Type one of the following commands:



~~~
ifconfig -a

host Fully_Qualified_Host_Name
~~~



For example, type the following command to get the IP address of the machine cyclop.austin.ibm.com:



~~~
host cyclop.austin.ibm.com
~~~



**How do I identify the network interfaces on my server?**

Either of the following two commands will display the network interfaces:



~~~
lsdev -Cc if
ifconfig -a
~~~



To get information about one specific network interface, for example, `tr0`, run the command:



~~~
ifconfig tr0
~~~



**How do I activate a network interface?**

To activate the network interface `tr0`, run the command:



~~~
ifconfig tr0 up
~~~



**How do I deactivate a network interface?**

For example, to deactivate the network interface `tr0`, run the command:



~~~
ifconfig tr0 down
~~~



**How do I display routing table, interface, and protocol information?**

To display routing table information for an Internet interface, type:



~~~
netstat -r -f inet
~~~



To display interface information for an Internet interface, type:



~~~
netstat -i -f inet
~~~



To display statistics for each protocol, type:



~~~
netstat -s -f inet
~~~



**How do I record packets received or transmitted?**

To record packets coming in and going out to any host on every interface, enter:



~~~
iptrace /tmp/nettrace
~~~



The trace information is placed in the /tmp/nettrace file.

To record packets received on an interface `en0` from a remote host airmail over the Telnet port, enter:

~~~
iptrace -i en0 -p telnet -s airmail /tmp/telnet.trace
~~~

The trace information is placed in the /tmp/telnet.trace file.


## Workload partitions

Workload partitions (WPARs), a set of completely new software-based system virtualization features, were introduced in IBM AIX Version 6.1\. With AIX 6.1 TL4, the capability to create a WPAR with its root file systems on a storage device dedicated to that WPAR was introduced. With AIX 6.1 TL6, the capability to have Virtual I/O Server (VIOS)-based virtual Small Computer System Interface (VSCSI) disks in a WPAR was introduced. Storage area network (SAN) support for rootvg system WPAR released with AIX 6.1 TL 6 provided the support of individual devices (disk or tapes) in a WPAR.

With AIX 7.1, the support of kernel extension load and VIOS disks and their management within a WPAR has been added, allowing a rootvg WPAR that supports VIOS disks. A new product named AIX 5.2 Workload Partitions for AIX 7 to support an AIX 5.2 environment in a versioned workload partition has been introduced in AIX 7.1\. The enhancement introduced with the reliability, availability, and serviceability (RAS) error-logging mechanism has been propagated to WPARs with AIX 7.1\. This RAS error-logging feature first became available in AIX 7.1 and was included in AIX 6.1 TL 06.

**How do I create a workload partition?**

To create a WPAR named temp with the IP address xxx.yyy.zzz.nnn, type:



~~~
mkwpar -n temp -N address= xxx.yyy.zzz.nnn
~~~



All values that are not specified are generated or discovered from the global system settings.

To create a workload partition based on an existing specification file wpar1.spec, type:



~~~
mkwpar -f /tmp/wpar1.spec
~~~



**How do I create a new specification file for an existing workload partition wpar1?**

To create a specification file wpar2.spec for an existing workload partition `wpar1`, type:



~~~
mkwpar -e wpar1 -o /tmp/wpar2.spec -w
~~~



**How do I start a workload partition?**

To start the workload partition called `temp`, type:



~~~
startwpar temp
~~~



**How do I stop a workload partition?**

To stop the workload partition called `temp`, type:



~~~
stopwpar temp
~~~



**How do I view the characteristics of workload partitions?**

To view the characteristics of all workload partitions, type:



~~~
lswpar

Name	  State	  Type	  Hostname		Directory     
---------------------------------------------------------------------------------
bar	  A	  S	  bar.austin.ibm.com 	/wpars/bar
foo	  D	  S	  foo.austin.ibm.com	/wpars/foo
trigger	  A	  A	  trigger		/
~~~



**How do I log in to a workload partition?**

To log in to the workload partition named `wpar1` as user `foo`, type:



~~~
clogin wpar1 -l foo
~~~



**How do I run a command in a workload partition?**

To run the /usr/bin/ps command as user root in a workload partition named `howdy`, type:



~~~
clogin howdy -l root /usr/bin/ps
~~~



**How do I remove a workload partition?**

To remove the workload partition called `temp`, type:



~~~
rmwpar temp
~~~



To stop and remove the workload partition called `temp` preserving data on its file system, type:



~~~
rmwpar -p -s temp
~~~



## Performance monitoring tools

The `iostat` command described below has been enhanced in AIX 6.1 TL6 and AIX 7.1 to capture useful data to help analyze I/O issues and identify and correct the problem quicker. A new flag, `-b`, is available for the `iostat` command to display block I/O device utilization statistics.

**How do I display virtual memory statistics?**

To display a summary of the virtual memory statistics since boot, type:



~~~
vmstat
~~~



To display five summaries at 2-second intervals, type:



~~~
vmstat 2 5
~~~



To display a summary of the statistics since boot including statistics for logical disks scdisk13 and scdisk14, enter the following command:



~~~
vmstat scdisk13 scdisk14
~~~



To display time-stamp next to each column of output of vmstat, enter the following command:



~~~
vmstat -t
~~~



To display all the VMM statistics available, enter the following command:



~~~
vmstat -vs
~~~



To display a summary of the statistics for all of the workload partitions after boot, type:



~~~
vmstat -@ ALL
~~~



To display all of the virtual memory statistics available for all of the workload partitions, type:



~~~
vmstat -vs -@ ALL
~~~



**How do I display statistics for all TTY, CPU, and disks?**

To display a single set of statistics for all TTY, CPU, and disks since boot, type:



~~~
iostat
~~~



To display a continuous disk report at 2-second intervals for the disk with the logical name `disk1`, type:



~~~
iostat -d disk1 2
~~~



To display six reports at 2-second intervals for the disk with the logical name `disk1`, type:



~~~
iostat disk1 2 6
~~~



To display six reports at 2-second intervals for all disks, type:



~~~
iostat -d 2 6
~~~



To display six reports at two second intervals for three disks named `disk1`, `disk2`, `disk3`, enter the following command:



~~~
iostat disk1 disk2 disk3 2 6
~~~



To print the system throughput report since boot, enter the following command:



~~~
iostat -s
~~~



To print the adapter throughput reports at 5-second intervals, enter the following command:



~~~
iostat -a 5
~~~



To print 10 system and adapter throughput reports at 20-second intervals, with only the TTY and CPU report (no disk reports), enter the following command:



~~~
iostat -sat 20 10
~~~



To print the system and adapter throughput reports with the disk utilization reports of hdisk0 and hdisk7 every 30 seconds, enter the following command:



~~~
iostat -sad hdisk0 hdisk7 30
~~~



To display time stamp next to each line of output of `iostat`, enter the following command:



~~~
iostat -T 60
~~~



To display only file system statistics for all workload partitions, type:



~~~
iostat -F -@ ALL
~~~



To display system throughput of all workload partitions along with the system, type:



~~~
iostat -s -@ ALL
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
