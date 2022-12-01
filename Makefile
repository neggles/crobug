.PHONY: all clean web

BOARDS = crobug crobug-direct crobug-host
GITREPO = https://github.com/neggles/crobug
JLCFAB_IGNORE = H1,H2,H3,H4,J1,JP2,J2,PS1

BOARD_FILES = $(addprefix build/, $(BOARDS:=.kicad_pcb))
GERBERS = $(addprefix build/, $(BOARDS:=-gerber.zip))
JLCGERBERS = $(addprefix build/, $(BOARDS:=-jlcpcb.zip))

RADIUS=1

all: $(GERBERS) $(JLCGERBERS) build/web/index.html

build/crobug.kicad_pcb: crobug/crobug.kicad_pcb build
	kikit panelize extractboard -s 120 50 43.75 81  $< $@

build/crobug-panel.kicad_pcb: crobug/crobug.kicad_pcb build
	kikit panelize grid --gridsize 1 2 --space 5 \
			--vtabs 0 --tabsfrom Eco2.User 15 \
			--tabheight 35 --mousebites 0.5 1 -0.25 \
			--railsTb 5 --fiducials 10 2.5 1 2 --tooling 5 2.5 1.5 \
			--radius $(RADIUS) $< $@

build/crobug-direct.kicad_pcb: crobug-direct/crobug-direct.kicad_pcb build
	kikit panelize extractboard -s 120 50 43.75 81  $< $@

build/crobug-direct-panel.kicad_pcb: crobug-direct/crobug-direct.kicad_pcb build
	kikit panelize grid --gridsize 1 2 --space 5 \
			--vtabs 0 --tabsfrom Eco2.User 15 \
			--tabheight 35 --mousebites 0.5 1 -0.25 \
			--railsTb 5 --fiducials 10 2.5 1 2 --tooling 5 2.5 1.5 \
			--radius $(RADIUS) $< $@

build/crobug-host.kicad_pcb: crobug-host/crobug-host.kicad_pcb build
	kikit panelize extractboard -s 120 50 43.75 81  $< $@

build/crobug-host-panel.kicad_pcb: crobug-host/crobug-host.kicad_pcb build
	kikit panelize grid --gridsize 1 2 --space 5 \
			--vtabs 0 --tabsfrom Eco2.User 15 \
			--tabheight 35 --mousebites 0.5 1 -0.25 \
			--railsTb 5 --fiducials 10 2.5 1 2 --tooling 5 2.5 1.5 \
			--radius $(RADIUS) $< $@

%-gerber: %.kicad_pcb
	kikit export gerber $< $@

%-gerber.zip: %-gerber
	zip -j $@ `find $<`

%-jlcpcb: %.kicad_pcb
	kikit fab jlcpcb --no-assembly $^ $@

%-jlcpcb.zip: %-jlcpcb
	zip -j $@ `find $<`

web: build/web/index.html

build:
	mkdir -p build

build/web: build
	mkdir -p build/web

build/web/index.html: build/web $(BOARD_FILES)
	kikit present boardpage \
		-d README.md \
		--name "crobug" \
		-b "crobug hub" "Single board" build/crobug.kicad_pcb  \
		-b "crobug hub" "Panel of 2" build/crobug-panel.kicad_pcb  \
		-b "crobug direct" "Single board" build/crobug-direct.kicad_pcb  \
		-b "crobug direct" "Panel of 2" build/crobug-direct-panel.kicad_pcb  \
		-b "crobug host" "Single board" build/crobug-host.kicad_pcb  \
		-b "crobug host" "Panel of 2" build/crobug-host-panel.kicad_pcb  \
		-r "assets/crobug-render.png" \
		-r "assets/crobug-direct-render.png" \
		-r "assets/crobug-host-render.png" \
		--repository "$(GITREPO)"\
		build/web

clean:
	rm -r build
