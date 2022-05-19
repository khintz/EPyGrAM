# ###############################################################################
# # CMake module to search for ECCODES library
# #
# # On success, the macro sets the following variables:
# # ECCODES_FOUND       = if the library found
# # ECCODES_LIBRARY     = full path to the library
# # ECCODES_INCLUDE_DIR = where to find the library headers 
# # also defined, but not for general use are
# # ECCODES_VERSION     = version of the library
# #
# ###############################################################################

MESSAGE(STATUS "Searching for ECCODES library")

FIND_PATH(ECCODES_INCLUDE_DIR eccodes.h
    PATHS /usr/local/include/
    DOC "Path to ECCODES library include directory")

FIND_LIBRARY(ECCODES_LIBRARY
    NAMES eccodes libeccodes # What to look for
    PATHS /usr/local/lib/
    DOC "Path to ECCODES library file")

# Handle the QUIETLY and REQUIRED arguments and set
# SPATIALINDEX_FOUND to TRUE
# if all listed variables are TRUE
INCLUDE(FindPackageHandleStandardArgs)
FIND_PACKAGE_HANDLE_STANDARD_ARGS(ECCODES DEFAULT_MSG ECCODES_LIBRARY
    ECCODES_INCLUDE_DIR)

IF(ECCODES_FOUND)
    MESSAGE(STATUS "Found ECCODES_INCLUDE: ${ECCODES_INCLUDE_DIR}")
    SET(ECCODES_LIBRARY ${ECCODES_LIBRARY})
    SET(ECCODES_INCLUDE ${ECCODES_INCLUDE_DIR})
    # target_include_directories(${TARGET_NAME} PUBLIC ${ECCODES_INCLUDE})
ENDIF()
