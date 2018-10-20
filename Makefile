examples: minimal basic modern animation nonblock xkcd quiver

minimal: examples/minimal.cpp matplotlibcpp.h
	cd examples && g++ -DWITHOUT_NUMPY minimal.cpp -I/usr/lib/python3.7/site-packages/numpy/core/include -I/usr/include/python3.7m -lpython3.7m -lcml -o minimal.o -std=c++11

basic: examples/basic.cpp matplotlibcpp.h
	cd examples && g++ basic.cpp -I/usr/lib/python3.7/site-packages/numpy/core/include -I/usr/include/python3.7m -lpython3.7m -lcml -o basic

modern: examples/modern.cpp matplotlibcpp.h
	cd examples && g++ modern.cpp -I/usr/lib/python3.7/site-packages/numpy/core/include -I/usr/include/python3.7m -lpython3.7m -lcml -o modern.o -std=c++11

animation: examples/animation.cpp matplotlibcpp.h
	cd examples && g++ animation.cpp -I/usr/lib/python3.7/site-packages/numpy/core/include -I/usr/include/python3.7m -lpython3.7m -lcml -o animation.o -std=c++11

nonblock: examples/nonblock.cpp matplotlibcpp.h
	cd examples && g++ nonblock.cpp -I/usr/lib/python3.7/site-packages/numpy/core/include -I/usr/include/python3.7m -lpython3.7m -lcml -o nonblock.o -std=c++11

quiver: examples/quiver.cpp matplotlibcpp.h
	cd examples && g++ quiver.cpp -I/usr/lib/python3.7/site-packages/numpy/core/include -I/usr/include/python3.7m -lpython3.7m -lcml -o quiver.o -std=c++11

xkcd: examples/xkcd.cpp matplotlibcpp.h
	cd examples && g++ xkcd.cpp -I/usr/lib/python3.7/site-packages/numpy/core/include -I/usr/include/python3.7m -lpython3.7m -lcml -o xkcd.o -std=c++11

clean:
	rm -f examples/{minimal.o,basic.o,modern.o,animation.o,nonblock.o,xkcd.o,quiver.o}
