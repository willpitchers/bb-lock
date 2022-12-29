
# A `bash` utility for Backup of WSL Linux Setup

`bb-lock` is a bad pun on both 'beta blocker' anxiety meds, and BB for @BiomeB where I work.

Previously in my Research / Bioinformatic career I had always worked on MacOS or Linux machines. 
At @BiomeB they use Windows machines, and so I have had to become familiar with the Windows Subsystem for Linux (WSL), which rather neatly allows the integration of a virtual machine (Ubuntu in my case) with Windows apps etc. 

However, after a blue-screen crash struck my work laptop during a Windows update, I discovered that the built-in 'restore' tools of the Windows OS failed to save any files or settings from the WSL VM. 

To guard against having to re-install my unix tools/python packages/conda environments again from scratch should this happen again (and soothe my anxiety about the possibility: hence the 'beta-blocker' wordplay), I wrote a script to zip up my `~/.xxx` files, and `.txt` of my unix path, and `.yaml` config files for my conda environments to an archive stored on my `C:\` drive *outside* the WSL. 
If I lose my WSL VM completely again, I ought to be able to reconstitute it *much* more easily!

 - I've also added the option to include an arbitrary directory in the zip archive...
 - I've also, also added an option for the script to remind my of the `Windows Powershell` command needed to make a `.tar` archive of the entire WSL VM, as an extra redundant backup.

