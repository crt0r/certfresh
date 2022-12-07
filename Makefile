PROG=certfresh

all: resolve-deps compiled

compiled:
	raco exe --vv -o $(PROG) ./cli.rkt

resolve-deps:
	raco pkg install --skip-installed --auto x509-lib gregor

clean:
	rm $(PROG)
