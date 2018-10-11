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

