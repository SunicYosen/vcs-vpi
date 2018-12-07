#
BASE_DIR = ..
SRC_DIR = $(BASE_DIR)/src
CSRC_DIR = $(SRC_DIR)/csrc
VSRC_DIR = $(SRC_DIR)/vsrc

CSRC = $(CSRC_DIR)/helloVPI.c \
	   $(CSRC_DIR)/helloVPICPP.cc \
	   $(CSRC_DIR)/testParams.c

VSRC = $(VSRC_DIR)/helloVPI.v \
       $(VSRC_DIR)/testbench.v 

PLITAB = $(SRC_DIR)/pli.tab

VCS = vcs
VCS_OPTS = -cc gcc-4.8 -cpp g++-4.8 \
		-timescale=1ns/10ps \
		-LDFLAGS -Wl,--no-as-needed \
		+vpi \
		-P \


OUTPUT = helloVPI.vsim

all: $(OUTPUT)

$(OUTPUT): $(PLITAB) $(VSRC) $(CSRC)
	$(VCS) $(VCS_OPTS) $^ -o $@

.PHONY: run
run:
	$(OUTPUT)

.PHONY: clean
clean:
	rm -rf $(OUTPUT) $(OUTPUT).daidir csrc/ ucli.key