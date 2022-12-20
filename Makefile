BUILD=build
PROG=certfresh
INSTALL=/usr/local/bin

all: resolve-deps clean $(BUILD)/$(PROG)

$(BUILD)/$(PROG):
	mkdir -p $(BUILD)
	raco exe --vv -o $(BUILD)/$(PROG) ./cli.rkt

resolve-deps:
	raco pkg install --skip-installed --auto x509-lib gregor

install:
	cp $(BUILD)/$(PROG) $(INSTALL)

uninstall:
	rm $(INSTALL)/$(PROG)

clean:
	if [ -d "$(BUILD)" ]; then rm -r $(BUILD); fi
