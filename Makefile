IMAGE:=tqxr/cfn_nag
BINPATH:=/usr/local/bin/
ITEMS:=cfn_nag_scan cfn_nag_rules

define RUN_COMMAND
printf '#!/bin/bash\ndocker run -it --rm -v `pwd`:`pwd` -w `pwd` $(IMAGE) $(THE_ITEM) "$$@"\n' > $(BINPATH)$(THE_ITEM) ; chmod u+x $(BINPATH)$(THE_ITEM) ;
endef
export RUN_COMMAND

define CLEANUP_COMMAND
rm -f $(BINPATH)$(THE_ITEM)
endef
export CLEANUP_COMMAND

create-commands:
	@$(foreach THE_ITEM, $(ITEMS), $(RUN_COMMAND))
build:
	docker build -t $(IMAGE) .
install: create-commands build
	@:

cleanup-commands:
	@$(foreach THE_ITEM, $(ITEMS), $(CLEANUP_COMMAND))
uninstall: cleanup-commands
	docker rmi $(IMAGE)
