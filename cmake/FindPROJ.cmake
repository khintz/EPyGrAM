# ###############################################################################
# # CMake module to search for PROJ library
# #
# # On success, the macro sets the following variables:
# # PROJ_FOUND       = if the library found
# # PROJ_INCLUDE_DIR = where to find the library headers 
# # also defined, but not for general use are
# # PROJ_VERSION     = version of the library
# #
# ###############################################################################

MESSAGE(STATUS "Searching for PROJ header")

FIND_PATH(PROJ_INCLUDE_DIR proj.h
    PATHS /usr/local/include/
    DOC "Path to PROJ library include directory"
)

# Handle the QUIETLY and REQUIRED arguments and set
# SPATIALINDEX_FOUND to TRUE
# if all listed variables are TRUE
INCLUDE(FindPackageHandleStandardArgs)
FIND_PACKAGE_HANDLE_STANDARD_ARGS(PROJ DEFAULT_MSG PROJ_INCLUDE)


IF(PROJ_FOUND)
    MESSAGE(STATUS "Found PROJ_INCLUDE: ${PROJ_INCLUDE_DIR}")
    SET(PROJ_INCLUDE ${PROJ_INCLUDE_DIR})
ENDIF()