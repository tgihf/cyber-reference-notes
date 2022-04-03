# ghidra

> A software reverse engineering (SRE) framework created and maintained by the NSA Research Directorate. It includes a suite of full-featured, high-end software analysis tools that enable users to analyze compiled code on a variety of platforms including Windows, macOS, and Linux.

---

## Search for a Particular Symbol

To search for a particular symbol (function, variable, etc.), use the `Filter` box of the `Symbol Tree`.

---

## Find a Function that Contains a Particular String

With the program pulled up in Code Browser, navigate to `Search` -> `For Strings...`.

Under `Memory Block Types`, select `All Blocks`.

![[Pasted image 20220308163228.png]]

Click `Search`.

In the `Filter`, type in the string you want to search for. Odds are the string's .data section entry will appear.

![[Pasted image 20220308163343.png]]

Double click it to view it in the assembly view. In its assembly view will be its address.

![[Pasted image 20220308163518.png]]

Right-click on the address and select `References` -> `Show References to Address`.

![[Pasted image 20220308163632.png]]

All the code that references the string will appear in the chart.

![[Pasted image 20220308163741.png]]

Double click one of these entries to view the code in the disassembly view.

---

## (PE32) Find the Address of the address of an External Function

Select the function from `Symbol Tree` -> `Functions` or double click on an existing call to the function in the disassembly view. Go to the assembly view. The address is highlighted in the below example.

![[Pasted image 20220308164339.png]]

Remember that this is the address of the address to the external function. You'll need to dereference it to actually call the function.

---

## References

[Ghidra GitHub Repository](https://github.com/NationalSecurityAgency/ghidra)
