matplotlib-cpp
==============

This repository emerges as a fork of [matplotlib-cpp](https://github.com/lava/matplotlib-cpp) with the idea of evaluating how the SciC libraries are integrated with matplotlib.

Dependencies
------------

-   [cmathl](https://scientificc.github.io/cmathl/)
-   [matplotlib-cpp](https://github.com/lava/matplotlib-cpp)
-   [numpy](http://www.numpy.org/)

Examples
--------

Complete minimal example:
```cpp
#include "matplotlibcpp.h"

namespace plt = matplotlibcpp;

int main()
{
    plt::plot({ 1, 3, 2, 4 });
    plt::show();
}
```
    g++ minimal.cpp -std=c++11 $(pkg-config --cflags --libs python2)

**Result:**

![Minimal example](./examples/minimal.png)

A more comprehensive example:

```cpp
#define _USE_MATH_DEFINES

#include <iostream>
#include <cml/math.h>

#include "../matplotlibcpp.h"

namespace plt = matplotlibcpp;

int main() 
{
    // Prepare data.
    int n = 5000;
    std::vector<double> x(n), y(n), z(n), w(n,2);

    for (int i = 0; i < n; ++i) 
    {
        x.at(i) = i*i;
        y.at(i) = cml_sin(2*M_PI*i/360.0);
        z.at(i) = cml_log(i);
    }
    
    // Set the size of output image = 1200x780 pixels
    plt::figure_size(1200, 780);

    // Plot line from given x and y data. Color is selected automatically.
    plt::plot(x, y);

    // Plot a red dashed line from given x and y data.
    plt::plot(x, w,"r--");

    // Plot a line whose name will show up as "log(x)" in the legend.
    plt::named_plot("log(x)", x, z);

    // Set x-axis to interval [0,1000000]
    plt::xlim(0, 1000*1000);

    // Add graph title
    plt::title("Sample figure");

    // Enable legend.
    plt::legend();

    // save figure
    const char *filename = "./basic.png";

    std::cout << "Saving result to " << filename << std::endl;;
    plt::save(filename);
}
```
    g++ basic.cpp $(pkg-config --cflags --libs python2)

**Result:**

![Basic example](./examples/basic.png)

matplotlib-cpp doesn't require C++11, but will enable some additional syntactic sugar when available:

```cpp
#define _USE_MATH_DEFINES

#include <cml/math.h>
#include "../matplotlibcpp.h"

using namespace std;
namespace plt = matplotlibcpp;

int main() 
{
	// plot(y) - the x-coordinates are implicitly set to [0,1,...,n)
	//plt::plot({1,2,3,4}); 
	
	// Prepare data for parametric plot.
	int n = 5000; // number of data points
	vector<double> x(n), y(n);

	for (int i = 0; i < n; ++i) 
	{
		double t = 2 * M_PI * i/n;
		x.at(i) = 16 * cml_sin(t) * cml_sin(t) * cml_sin(t);
		y.at(i) = 13 * cml_cos(t) - 5 * cml_cos(2 * t) - 2 * cml_cos(3 * t) - cml_cos(4 * t);
	}

	// plot() takes an arbitrary number of (x,y,format)-triples. 
	// x must be iterable (that is, anything providing begin(x) and end(x)),
	// y must either be callable (providing operator() const) or iterable. 
	plt::plot(x, y, "r-", x, [](double d) { return 12.5 + cml_abs(cml_sin(d)); }, "k-");

	// show plots
	plt::show();
}
```
    g++ modern.cpp -std=c++11 -I/usr/include/python2.7 -lpython

**Result:**

![Modern example](./examples/modern.png)

Or some *funny-looking xkcd-styled* example:

```cpp
#define _USE_MATH_DEFINES

#include <vector>
#include <cml/math.h>

#include "../matplotlibcpp.h"

namespace plt = matplotlibcpp;

int main() 
{
    std::vector<double> t(1000);
    std::vector<double> x(t.size());

    for (size_t i = 0; i < t.size(); i++) 
    {
        t[i] = i / 100.0;
        x[i] = cml_sin(2.0 * M_PI * 1.0 * t[i]);
    }

    plt::xkcd();
    plt::plot(t, x);
    plt::title("AN ORDINARY SIN WAVE");
    plt::show();
}
```
    g++ xkcd.cpp -std=c++11 $(pkg-config --cflags --libs python2)

**Result:**

![xkcd example](./examples/xkcd.png)

When working with vector fields, you might be interested in quiver plots:

```cpp
#include "../matplotlibcpp.h"

namespace plt = matplotlibcpp;

int main()
{
    // u and v are respectively the x and y components of the arrows we're plotting
    std::vector<int> x, y, u, v;
    
    for (int i = -5; i <= 5; i++) 
        for (int j = -5; j <= 5; j++) 
        {
            x.push_back(i);
            u.push_back(-i);
            y.push_back(j);
            v.push_back(-j);
        }

    plt::quiver(x, y, u, v);
    plt::show();
}
```
    g++ quiver.cpp -std=c++11 $(pkg-config --cflags --libs python2)

**Result:**

![quiver example](./examples/quiver.png)

# Python 3

This library supports both python2 and python3 (although the python3 support is probably far less tested,
so it is recommended to prefer python2.7). To switch the used python version, simply change the compiler flags accordingly.

    g++ example.cpp $(pkg-config --cflags --libs python3)

The same technique can be used for linking against a custom build of python

    g++ example.cpp -I/usr/local/include/fancy-python4 -L/usr/local/lib -lfancy-python4
