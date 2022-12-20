PROG=certfresh

all: resolve-deps $(PROG)

$(PROG):
	raco exe --vv -o $(PROG) ./cli.rkt

resolve-deps:
	raco pkg install --skip-installed --auto x509-lib gregor

clean:
	if [ -f "$(PROG)" ]; then rm $(PROG); fi
