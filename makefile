
index.js: index.ls
	echo '#!/usr/bin/env node' > $@
	lsc -p -c $<  >> $@
	chmod +x $@
	touch /Users/zaccaria/development/github/documents/papers/150203_petri_nets_and_promises/150203_petri_nets_and_promises.md

clean:
	rm index.js

XYZ = node_modules/.bin/xyz

.PHONY: release-major release-minor release-patch
	
release-major release-minor release-patch:
	@$(XYZ) --increment $(@:release-%=%)

