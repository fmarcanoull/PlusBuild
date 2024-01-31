# This module can be loaded by
#   FIND_PACKAGE(CLARIUS)
# This module defines the following variables
# CLARIUS_DIR
# CLARIUS_INCLUDE_DIR
# CLARIUS_LIB_DIR
# CLARIUS_FOUND

IF(WIN32)
  SET(CLARIUS_PATH_HINTS
    "../PLTools/Clarius/cast/windows"
    "../../PLTools/Clarius/cast/windows"
    )
ELSE()
  MESSAGE(FATAL_ERROR "Clarius is currently only supported on Windows")
ENDIF()

FIND_PATH(CLARIUS_DIR include/cast/cast.h
  PATHS ${CLARIUS_PATH_HINTS}
  DOC "Clarius API dir")

IF(CLARIUS_DIR)
  SET(CLARIUS_INCLUDE_DIR ${CLARIUS_DIR}/include/cast)
  SET(CLARIUS_LIB_DIR ${CLARIUS_DIR}/lib)
ENDIF()

include(FindPackageHandleStandardArgs)
FIND_PACKAGE_HANDLE_STANDARD_ARGS(
  CLARIUS
  FOUND_VAR CLARIUS_FOUND
  REQUIRED_VARS CLARIUS_INCLUDE_DIR CLARIUS_LIB_DIR CLARIUS_DIR
)

IF(CLARIUS_FOUND)
  ADD_LIBRARY(Clarius STATIC IMPORTED)
  SET_TARGET_PROPERTIES(Clarius PROPERTIES
  IMPORTED_IMPLIB ${CLARIUS_LIB_DIR}
  IMPORTED_LOCATION ${CLARIUS_LIB_DIR}/listen${CMAKE_SHARED_LIBRARY_SUFFIX}
  INTERFACE_INCLUDE_DIRECTORIES ${CLARIUS_INCLUDE_DIR})
ENDIF()

MARK_AS_ADVANCED(CLARIUS_INCLUDE_DIR CLARIUS_LIB_DIR CLARIUS_DIR)
