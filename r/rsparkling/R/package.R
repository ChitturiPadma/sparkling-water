#' @import sparklyr h2o utils
NULL

# define required spark packages
spark_dependencies <- function(spark_version, scala_version, ...) {
  sw_version = getOption("rsparkling.sparklingwater.version", default = "1.6.7")

  if(as.package_version(spark_version)$major != as.package_version(sw_version)$major){
    stop(cat(paste0("Major version of Sparkling Water does not correspond to major Spark version.
    \nMajor Sparkling Water Version = ",as.package_version(sw_version)$major,
    "\nMajor Spark Version = ",as.package_version(spark_version)$major)))
  }
  if(as.package_version(spark_version)$minor != as.package_version(sw_version)$minor){
     stop(cat(paste0("Minor version of Sparkling Water does not correspond to minor Spark version.
     \nMinor Sparkling Water Version = ",as.package_version(sw_version)$minor,
     "\nMinor Spark Version = ",as.package_version(spark_version)$minor)))
  }
  sparklyr::spark_dependency(packages = c(
    sprintf("ai.h2o:sparkling-water-core_%s:%s", scala_version,sw_version),
    sprintf("ai.h2o:sparkling-water-ml_%s:%s", scala_version,sw_version),
    sprintf("ai.h2o:sparkling-water-repl_%s:%s", scala_version,sw_version)
  ))
}

.onLoad <- function(libname, pkgname) {
  sparklyr::register_extension(pkgname)
}

