# ###############################################################################
# # CMake module to search for GEOS library
# #
# # On success, the macro sets the following variables:
# # GEOS_FOUND       = if the library found
# # GEOS_INCLUDE_DIR = where to find the library headers 
# # also defined, but not for general use are
# # GEOS_VERSION     = version of the library
# #
# ###############################################################################

MESSAGE(STATUS "Searching for GEOS header")

FIND_PATH(GEOS_INCLUDE_DIR geos_c.h
    PATHS /usr/local/include/
    DOC "Path to GEOS library include directory"
)

# Handle the QUIETLY and REQUIRED arguments and set
# SPATIALINDEX_FOUND to TRUE
# if all listed variables are TRUE
INCLUDE(FindPackageHandleStandardArgs)
FIND_PACKAGE_HANDLE_STANDARD_ARGS(GEOS DEFAULT_MSG GEOS_INCLUDE)


IF(GEOS_FOUND)
    MESSAGE(STATUS "Found GEOS_INCLUDE: ${GEOS_INCLUDE_DIR}")
    SET(GEOS_INCLUDE ${GEOS_INCLUDE_DIR})
ENDIF()