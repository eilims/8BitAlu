SUB_DIRS = adder/ shifter/ twos_comp/ multiplier/

all: $(SUB_DIRS)

build_test: $(SUB_DIRS)

run_test: $(SUB_DIRS)

clean: $(SUB_DIRS)

$(SUB_DIRS):
	@echo $@
	$(MAKE) -C $@ $(MAKECMDGOALS)
