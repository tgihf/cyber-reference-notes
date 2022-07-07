# Expanding a Disk on Windows

So you've got a Windows VM that's running out of space, yeah? You need to increase the size of the disk? Here's how.

1. Shut off the VM
2. Increase the size of the disk in your hypvisor
3. Turn on the VM
4. Open `Disk Manager`
	- You should see your new, unallocated partition at the end of the available space
	- There is most likely a recovery partition between your primary partition and this unallocated partition
	- To expand the primary partition, the unallocated partition needs to be adjacent to it
	- You're going to need to move the recovery partition
5. Download [MiniTool Partition Wizard](https://www.partitionwizard.com/)
6. Use MiniTool Partition Wizard to move the recovery partition to the end of the available space (far right)
7. Now the primary partition and the unallocated partition are adjacent! You can now use MiniTool Partition Wizard or the Disk Manager to expand the primary partition
