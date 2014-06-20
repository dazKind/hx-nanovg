#ifndef __HXNANOVG_H__
#define __HXNANOVG_H__

struct NVGcontext;

namespace nanovg {
    NVGcontext* nvgCreateGL(int _atlasW, int _atlasH, int _flags);
    void nvgDeleteGL(NVGcontext* _ctx);
}


#endif /* __HXNANOVG_H__ */
