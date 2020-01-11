SUB_DIRS = adder/ shifter/

all: $(SUB_DIRS)

build_test: $(SUB_DIRS)

run_test: $(SUB_DIRS)

clean: $(SUB_DIRS)

$(SUB_DIRS):
	@echo $@
	$(MAKE) -C $@ $(MAKECMDGOALS)
