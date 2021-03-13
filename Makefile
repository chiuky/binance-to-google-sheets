# https://developers.google.com/apps-script/guides/clasp

# You can replace it with your own script ID so you can call `make apply` directly.
SCRIPT_ID?=replace-me

all: push

push:
	@echo "Pushing Binance to Google Sheets to:"
	@cat .clasp.json
	@clasp push

setup:
	@echo "Binance to Google Sheets is being configured for SCRIPT_ID: ${SCRIPT_ID}"
	@echo '{"scriptId":"${SCRIPT_ID}"}' > .clasp.json
	@echo "DONE:"
	@cat .clasp.json

update:
	@echo "Pulling from repo and pushing to configured SCRIPT_ID.."
	@git pull
	${MAKE} push

##
# Next ones are for internal development purposes only  =]
##

versions:
	@clasp versions

deploys:
	@clasp deployments

demo:
	@cd ../binance-to-google-sheets-copies && ${MAKE} demo

dev: push
	@cd ../binance-to-google-sheets-copies && ${MAKE}

generate:
	@rm -f BINANCE-ALL.gs
	@find . -type f \( -iname "*.gs" ! -iname "main.gs" ! -iname "tmp.gs" \) -exec cat > tmp.gs {} +
	@cat main.gs > BINANCE-ALL.gs
	@printf "\n\n/////////////////////////////////////\n\n" >> BINANCE-ALL.gs
	@cat tmp.gs >> BINANCE-ALL.gs
	@rm -f tmp.gs
	@echo "BINANCE-ALL.gs generated!"

.PHONY: demo dev generate