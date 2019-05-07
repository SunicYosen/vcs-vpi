#
BASE_DIR = ..
SRC_DIR = $(BASE_DIR)/src
CSRC_DIR = $(SRC_DIR)/csrc
VSRC_DIR = $(SRC_DIR)/vsrc

OUPUTLOGDIR = $(BASE_DIR)/build/output_log

NVMAIN_BASE_DIR = $(abspath /home/sun/File/RISCV/Projects/nvmain)
NVMAIN_ALLSUBDIR := $(shell find $(NVMAIN_BASE_DIR) -maxdepth 4 -type d)
NVMAIN_SRCS := $(foreach n,$(NVMAIN_ALLSUBDIR), $(wildcard $(n)/*.cpp))
NVMAIN_SRCS_RVSIM := $(foreach n,$(NVMAIN_ALLSUBDIR), $(wildcard $(n)/*.cc))
NVMAIN_HEADERS :=  $(foreach n,$(NVMAIN_ALLSUBDIR) , $(wildcard $(n)/*.h))

CSRC = $(CSRC_DIR)/test_data_transfer.c

VSRC = $(VSRC_DIR)/vpi_nvmain.v \
       $(VSRC_DIR)/tb_nvmain.v 

PLITAB = $(SRC_DIR)/pli.tab

VCS = vcs
VCS_OPTS = -cc gcc-4.8 -cpp g++-4.8 \
		-timescale=1ns/10ps \
		-LDFLAGS -Wl,--no-as-needed \
		-CC "-I$(NVMAIN_BASE_DIR)" \
		-CC "-std=c++11" \
		-CC "-O3 -Wall" \
	  -CC "-Wextra -DNDEBUG" \
	  -CC "-DTRACE" \
		+vpi \
		-P \


OUTPUT = vpi_nvmain.vsim

all: $(OUTPUT)

%.vsim: $(PLITAB) $(VSRC) $(CSRC) $(NVMAIN_SRCS) $(NVMAIN_SRCS_RVSIM)
	$(VCS) $(VCS_OPTS) $^ -o $@

.PHONY: run

run:
	mkdir -p $(OUPUTLOGDIR)
	$(OUTPUT) > $(OUPUTLOGDIR)/run_`date +%y%m%d%02k%M`.log

.PHONY: clean
clean:
	rm -rf $(OUTPUT) $(OUTPUT).daidir csrc/ ucli.key $(OUPUTLOGDIR)