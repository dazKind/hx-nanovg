#ifndef __FOO3D_H__
#define __FOO3D_H__

struct NVGcontext;

namespace nanovg {
    NVGcontext* nvgCreateGL(int _atlasW, int _atlasH, int _flags);
    void nvgDeleteGL(NVGcontext* _ctx);
}

/*
#include <hx/CFFI.h>

#if defined _WIN32 || defined __CYGWIN__
    #ifdef __GNUC__
        #define DLL_PUBLIC __attribute__ ((dllexport))
    #else
        #define DLL_PUBLIC __declspec(dllexport)
    #endif
#else
    #if __GNUC__ >= 4
        #define DLL_PUBLIC __attribute__ ((visibility ("default")))
    #else
        #define DLL_PUBLIC
    #endif
#endif
*/


#endif /* __FOO3D_H__ */
