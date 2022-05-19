# ###############################################################################
# # CMake module to search for HDF5 library
# #
# # On success, the macro sets the following variables:
# # HDF5_FOUND       = if the library found
# # HDF5_LIBRARY     = full path to the library
# # HDF5_INCLUDE_DIR = where to find the library headers 
# # also defined, but not for general use are
# # HDF5_VERSION     = version of the library
# #
# ###############################################################################

MESSAGE(STATUS "Searching for HDF5 library")

FIND_PATH(HDF5_INCLUDE_DIR H5Cpp.h
    PATHS /usr/local/include/
    DOC "Path to HDF5_CPP library include directory"
)

FIND_LIBRARY(HDF5_LIBRARY
    NAMES hdf5
    PATHS /usr/local/lib/
    DOC "Path to HDF5 library file"
    NO_DEFAULT_PATH
)

FIND_LIBRARY(HDF5CPP_LIBRARY
    NAMES hdf5_cpp
    PATHS /usr/local/lib/
    DOC "Path to HDF5CPP library file"
    NO_DEFAULT_PATH
)

# Handle the QUIETLY and REQUIRED arguments and set
# SPATIALINDEX_FOUND to TRUE
# if all listed variables are TRUE
INCLUDE(FindPackageHandleStandardArgs)
FIND_PACKAGE_HANDLE_STANDARD_ARGS(HDF5 DEFAULT_MSG HDF5_LIBRARY
    HDF5CPP_LIBRARY HDF5_INCLUDE_DIR)


IF(HDF5_FOUND)
    MESSAGE(STATUS "Found HDF5_INCLUDE: ${HDF5_INCLUDE_DIR}")
    MESSAGE(STATUS "Found HDF5_LIBBRARY: ${HDF5_LIBRARY}")
    MESSAGE(STATUS "Found HDF5CPP_LIBRARY: ${HDF5CPP_LIBRARY}")
    SET(HDF5_LIBRARY ${HDF5_LIBRARY})
    SET(HDF5CPP_LIBRARY ${HDF5CPP_LIBRARY})
    SET(HDF5_INCLUDE ${HDF5_INCLUDE_DIR})
ENDIF()