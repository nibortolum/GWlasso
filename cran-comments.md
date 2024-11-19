## R CMD check results

0 errors | 0 warnings | 1 note

* This is a new release

Notes have been fixed
comments from Benjamin Altmann have been adressed.
gwl_bw_estimation() is a > 5 seconds to run
plot_gwl_map() requires package maps to be installed, because it calls ggplot2::borders() that itself requires maps. It is added in the suggests section of the description file.