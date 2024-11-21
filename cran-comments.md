## Resubmission

comments from Benjamin Altmann have been adressed.
gwl_bw_estimation() examples wrapped in \donttest instead of \donttrun (example takes > 5 seconds to run but overall less than 2 minutes)
plot_gwl_map() -> switched if(rlang::is_installed("maps")) to if(requireNamespace("maps"))