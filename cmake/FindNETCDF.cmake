# ###############################################################################
# # CMake module to search for NETCDF library
# #
# # On success, the macro sets the following variables:
# # NETCDF_FOUND       = if the library found
# # NETCDF_LIBRARY     = full path to the library
# # NETCDF_INCLUDE_DIR = where to find the library headers 
# # also defined, but not for general use are
# # NETCDF_VERSION     = version of the library
# #
# ###############################################################################

MESSAGE(STATUS "Searching for NETCDF library")

FIND_PATH(NETCDF_INCLUDE_DIR netcdf.h
    PATHS /usr/local/include/
    DOC "Path to NETCDF library include directory"
)

FIND_LIBRARY(NETCDF_LIBRARY
    NAMES netcdf
    PATHS /usr/local/lib/
    DOC "Path to NETCDF library file"
    NO_DEFAULT_PATH
)

# Handle the QUIETLY and REQUIRED arguments and set
# SPATIALINDEX_FOUND to TRUE
# if all listed variables are TRUE
INCLUDE(FindPackageHandleStandardArgs)
FIND_PACKAGE_HANDLE_STANDARD_ARGS(NETCDF DEFAULT_MSG NETCDF_LIBRARY NETCDF_INCLUDE)


IF(NETCDF_FOUND)
    MESSAGE(STATUS "Found NETCDF_INCLUDE: ${NETCDF_INCLUDE_DIR}")
    MESSAGE(STATUS "Found NETCDF_LIBBRARY: ${NETCDF_LIBRARY}")
    SET(NETCDF_LIBRARY ${NETCDF_LIBRARY})
    SET(NETCDF_INCLUDE ${NETCDF_INCLUDE_DIR})
ENDIF()