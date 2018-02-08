# Find EGL
#
# EGL_INCLUDE_DIR
# EGL_LIBRARY
# EGL_FOUND

set(_EGL_INCLUDE_PREFIXES 
    /usr/include
    /usr/local/include
    ${CMAKE_SOURCE_DIR}/source/glbinding/include/egl
    /libglvnd/include
)

set(_EGL_LIBRARY_PREFIXES 
    /usr/lib64
    /usr/lib
    /usr/local/lib
)

function(GetNvidiaDriverPathSuffix resultVar)
    set(result)
    foreach(ITR ${ARGN})
        file(GLOB folders ${ITR}/*)
        foreach(folder_path ${folders})
            get_filename_component(folder ${folder_path} NAME)
            if(folder MATCHES "^nvidia-[^-]*$")
                list(APPEND result ${folder})
            endif()
        endforeach()
    endforeach()
    set(${resultVar} ${result} PARENT_SCOPE)
endfunction()

GetNvidiaDriverPathSuffix(NVIDIA_FOLDER_PATH_SUFFIX ${_EGL_LIBRARY_PREFIXES})
if(NVIDIA_FOLDER_PATH_SUFFIX)
    message(STATUS "Using nvidia drivers directory ${NVIDIA_FOLDER_PATH_SUFFIX}")
endif()

find_path(EGL_INCLUDE_DIR NAMES EGL/egl.h PATHS ${_EGL_INCLUDE_PREFIXES} PATH_SUFFIXES ${NVIDIA_FOLDER_PATH_SUFFIX} aarch64-linux-gnu)
find_library(EGL_LIBRARY NAMES egl EGL libEGL PATHS ${_EGL_LIBRARY_PREFIXES} PATH_SUFFIXES ${NVIDIA_FOLDER_PATH_SUFFIX} aarch64-linux-gnu NO_DEFAULT_PATH)

set(EGL_INCLUDE_DIRS ${EGL_INCLUDE_DIR})
set(EGL_LIBRARIES ${EGL_LIBRARY})

include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(EGL REQUIRED_VARS EGL_INCLUDE_DIR EGL_LIBRARY)

mark_as_advanced(EGL_INCLUDE_DIR EGL_LIBRARY)
