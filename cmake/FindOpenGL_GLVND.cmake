# Find OpenGL_GLVND
#
# OpenGL_GLVND_LIBRARY
# OpenGL_GLVND_FOUND

find_library(OpenGL_GLVND_LIBRARY NAMES OpenGL PATHS / /usr/lib64 /usr/lib /usr/local/lib PATH_SUFFIXES nvidia nvidia-375 nvidia-367 nvidia-365 nvidia-361 nvidia-381 nvidia-384 nvidia-387 aarch64-linux-gnu NO_DEFAULT_PATH)

set(OpenGL_GLVND_LIBRARIES ${OpenGL_GLVND_LIBRARY})

include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(OpenGL_GLVND REQUIRED_VARS OpenGL_GLVND_LIBRARY)

mark_as_advanced(OpenGL_GLVND_LIBRARY)