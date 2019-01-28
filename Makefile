all:
	bison -d -r all eiffel.y
	flex eiffel.l
	gcc eiffel.tab.c lex.yy.c eiffel.c -lfl
