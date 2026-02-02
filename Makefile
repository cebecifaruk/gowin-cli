GOWIN_IDE_PATH=/Applications/GowinIDE.app/Contents/Resources/Gowin_EDA/IDE

GOWIN_IDE_BIN=$(GOWIN_IDE_PATH)/bin
GOWIN_IDE_LIB=$(GOWIN_IDE_PATH)/lib
GOWIN_ENV=DYLD_FRAMEWORK_PATH=$(GOWIN_IDE_LIB) DYLD_LIBRARY_PATH=$(GOWIN_IDE_LIB)
GOWIN_SH=$(GOWIN_ENV) $(GOWIN_IDE_BIN)/gw_sh

all: project/impl/pnr/project.fs

project/project.gprj: project.tcl
	rm -rf project
	$(GOWIN_SH) $<

project/impl/pnr/project.fs: project/project.gprj src/main.v pins.cst
	echo "open_project $<; run all"	| $(GOWIN_SH) -

flash: project/impl/pnr/project.fs
	openFPGALoader -b tangprimer20k -f $<

erase:
	openFPGALoader -b tangprimer20k --bulk-erase

run: project/impl/pnr/project.fs 
	openFPGALoader -b tangprimer20k $<
	
clean:
	rm -rf project
