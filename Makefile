.PHONY: bootstrap install sync doctor apply

bootstrap:
	bash scripts/bootstrap.sh

install:
	bash scripts/install.sh

sync:
	bash scripts/sync.sh

doctor:
	bash scripts/doctor.sh

apply:
	bash scripts/apply.sh
