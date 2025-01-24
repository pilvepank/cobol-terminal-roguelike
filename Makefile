all:
	cobc -free -x -Wall -Icopybooks src/roguelike_core.cbl -o roguelike_core
	cobc -free -x -Wall -Icopybooks tests/roguelike_test.cbl -o roguelike_test
test:
	./roguelike_test
clean:
	rm -f roguelike_core roguelike_test *.exe *.o
