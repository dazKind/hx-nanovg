#include "hxcpp.h"

#include <GL/glew.h>

#include "nanovg.h"
#include "nanovg_gl.h"

namespace nanovg {

    NVGcontext* nvgCreateGL(int _atlasW, int _atlasH, int _flags) {
        GLenum err = glewInit();
        if (err != GLEW_OK) {
            printf("Could not init glew.\n");
        }

        NVGcontext* ctx = 
        #if NANOVG_GL2_IMPLEMENTATION
            nvgCreateGL2((_atlasW), (_atlasH), (_flags));
        #elif NANOVG_GL3_IMPLEMENTATION
            nvgCreateGL3((_atlasW), (_atlasH), (_flags));
        #elif NANOVG_GL2ES_IMPLEMENTATION
            nvgCreateGL2ES((_atlasW), (_atlasH), (_flags));
        #elif NANOVG_GL3ES_IMPLEMENTATION
            nvgCreateGL3ES((_atlasW), (_atlasH), (_flags));
        #endif

        return ctx;
    }

    void nvgDeleteGL(NVGcontext* _ctx) {
        #if NANOVG_GL2_IMPLEMENTATION
            nvgDeleteGL2(_ctx);
        #elif NANOVG_GL3_IMPLEMENTATION
            nvgDeleteGL3(_ctx);
        #elif NANOVG_GL2ES_IMPLEMENTATION
            nvgDeleteGL2ES(_ctx);
        #elif NANOVG_GL3ES_IMPLEMENTATION
            nvgDeleteGL3ES(_ctx);
        #endif
    }
}