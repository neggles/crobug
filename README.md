# crobug

### Render:

![KiCad raytraced main board render](assets/crobug-render.png)
![KiCad raytraced top board render](assets/crobug-top-render.png)

## y tho

cause you can't get suzyqable anymore

will add more details to this readme later

## Repository Structure
- `crobug` contains a suzy-q-alike adapter with a built in usb hub to give you both CCD and OTG gadget access at the same time
- `crobug-direct` foregoes the usb hub in service of being cheaper and easier to assemble, and also triggers BC1.2 mode for 1.5A charging
- `crobug-host` is the same as `crobug-direct` but with a host-mode micro-B connector for booting from a flash drive while using CCD
- `libraries/crobug.pretty` contains board-specific footprints
- `libraries/crobug.kicad_sym` contains board-specific symbols
- `libraries/shapes3D` contains board-specific STEP models (and a few extra)

## Building

### **building most likely does not work at the moment.** 
(I need to update kikit stuff to deal with KiCad 6 and also actually specify board dimensions, panel tabs etc still.)


Simply call `make` in the top-top level directory. The `build` directory will then contain:

- the main board and top board
- A panelized version of said boards
- zipped gerbers for the boards you can directly use for manufacturing

### Credit where it's due:

Makefile uses [Jan Mrázek](https://github.com/yaqwsx)'s [KiKit](https://github.com/yaqwsx/KiKit),
which I cannot recommend enough and will need to be available before running `make`

Jan's [jlcparts](https://yaqwsx.github.io/jlcparts/) app was also extremely useful in narrowing 
down part choices based on what JLCPCB have available.

### License
<a rel="license" href="http://creativecommons.org/licenses/by-sa/4.0/">
<img alt="Creative Commons License" style="border-width:0" src="https://i.creativecommons.org/l/by-sa/4.0/88x31.png" />
</a><br /><span xmlns:dct="http://purl.org/dc/terms/" property="dct:title">crobug</span> by
<a xmlns:cc="http://creativecommons.org/ns#" href="https://github.com/neggles" property="cc:attributionName" rel="cc:attributionURL">neggles</a>
is licensed under a
<a rel="license" href="http://creativecommons.org/licenses/by-sa/4.0/">
Creative Commons Attribution-ShareAlike 4.0 International License
</a>

