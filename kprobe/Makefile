# ~~~~~~~~~~~~~~~~~~~~~
#
#   Makefile for bcc-testcases/kprobe
#
# ~~~~~~~~~~~~~~~~~~~~~

export TEST        := bcc-testcases/kprobe
export TESTVERSION := 1.0

.PHONY: build run clean

FILES := $(METADATA) runtest.sh Makefile metadata

run: $(FILES) build
	./runtest.sh

build:
	chmod a+x ./runtest.sh

clean:
	rm -f $(METADATA)

# Include a global make rules file
include /usr/share/rhts/lib/rhts-make.include

$(METADATA):
	touch $(METADATA)
	@echo "Owner:		Ziqian SUN <zsun@redhat.com>" >$(METADATA)
	@echo "Name:		$(TEST)" >>$(METADATA)
	@echo "Path:		$(TEST_DIR)" >>$(METADATA)
	@echo "TestVersion:	$(TESTVERSION)"	>>$(METADATA)
	@echo "License:		GPLv3" >>$(METADATA)
	@echo "Description: 	Test kprobe related bcc scripts." >>$(METADATA)
	@echo "TestTime:	60m" >>$(METADATA)

	rhts-lint $(METADATA)
