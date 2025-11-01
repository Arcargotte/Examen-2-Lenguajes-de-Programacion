all: test coverage

test:
	busted -c

coverage:
	luacov
	cat luacov.report.out

clean:
	rm -f luacov.stats.out luacov.report.out
