SUB_DIRS = adder/ asdf/

build_test: $(SUB_DIRS)

clean: $(SUB_DIRS)

$(SUB_DIRS):
	@echo $@
	$(MAKE) -C $@ $(MAKECMDGOALS)
