## R CMD check results

0 errors | 0 warnings | 1 note

* Resubmission

comments from Benjamin Altmann have been adressed.
gwl_bw_estimation() wrapped in \donttest instead f \donttrun (example takes > 5 seconds to run but overall less than 2 minutes)
plot_gwl_map() -> switched if(rlang::is_installed("maps")) to if(requireNamespace("maps"))