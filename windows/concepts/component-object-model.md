# Component Object Model (COM)

> A binary-interface standard for software components introduced by Microsoft in 1993. Component Object Model (COM) is a **language-neutral** way of implementing objects that can be used in environments different from the one it was created in.

---

## Identifiers

### Class ID (CLSID)

Each COM component is an object-oriented *class*, identified by a class ID (CLSID).

### Interface ID (IID)

Each COM component (class) implements one or more particular *interfaces*, each identified by an interface ID (IID).

---

## Registration

A Windows system's COM components (classes) are defined in the registry under `HKCR\CLSID\`. These are aggregated from entries in `HKCU\Classes\` and `HKLM\Classes\`. If an entry for the same COM component exists in both `HKCU\Classes\` and `HKLM\Classes\`, `HKCU\Classes\`'s will be prioritized and copied to `HKCR\CLSID\`, not `HKLM\Classes\`'s.

A Windows system's COM interfaces are defined in the registry under `HKCR\Interface`.

There is also a registration-free COM (RegFree COM) which allows a COM component (class) to exist without using the registry. In this case, data such as the CLSID is stored in an XML manifest file.

---

## COM Registry Entry Structure

Each COM component's (class's) registry entry has a structure similar to the following:

![[Pasted image 20220609133111.png]]

- `HKCR\$CLSID\InProcServer32\(Default)` contains the path of a DLL that defines the COM component (class)
	- When an object of this class is instantiated, the class definition within this DLL is executed
- `HKCR\$CLSID\InProcServer32\ThreadingModel` defines the component's threading model (surprise!)
	- Options:
		- `Apartment`: single-threaded
		- `Free`: multi-threaded
		- `Both`: single- or multi-threaded
		- `Neutral`: thread neutral

Instead of the registry key `InProcServer32`, you may see `LocalServer32`. `HKCR\$CLSID\LocalServer32\(Default)` contains the path of an EXE rather than a DLL.

---

## References

[Component Object Model (COM) - Microsoft Windows App Development](https://docs.microsoft.com/en-us/windows/win32/com/component-object-model--com--portal)

[Component Object Model - Wikipedia](https://en.wikipedia.org/wiki/Component_Object_Model)

[COM Hijacking - Zero-Point Security CRTO Course](https://training.zeropointsecurity.co.uk/courses/take/red-team-ops/texts/30332403-com-hijacking)
