#ifndef __HXNANOVG_H__
#define __HXNANOVG_H__

struct NVGcontext;

namespace nanovg {
    NVGcontext* nvgCreateGL(int _flags);
    void nvgDeleteGL(NVGcontext* _ctx);
    int nvglCreateImageFromHandle(NVGcontext* ctx, int textureId, int w, int h, int imageFlags);
}


#endif /* __HXNANOVG_H__ */
