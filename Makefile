mkexample:
	mkdir -p obj
	cd obj && gcc -c -gnat2012 ../src/mkproj.adb
	cd obj && gnatbind -x mkproj.ali
	cd obj && gnatlink mkproj.ali
	mkdir -p bin
	mv obj/mkproj bin/

clean:
	rm -rf obj/ bin/

