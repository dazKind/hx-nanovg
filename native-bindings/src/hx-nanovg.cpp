#define IMPLEMENT_API
#include "hx-nanovg.h"

#include <GL/glew.h>
#include "nanovg.h"
#include "nanovg_gl.h"

namespace nanovg {

	DEFINE_KIND(k_nvgContext);
	value hx_nvgCreateGL(value _atlasW, value _atlasH, value _flags) {

		GLenum err = glewInit();
		if (err != GLEW_OK) {
			printf("Could not init glew.\n");
		}

		NVGcontext* ctx = 
		#if NANOVG_GL2_IMPLEMENTATION
			nvgCreateGL2(val_int(_atlasW), val_int(_atlasH), val_int(_flags));
		#elif NANOVG_GL3_IMPLEMENTATION
			nvgCreateGL3(val_int(_atlasW), val_int(_atlasH), val_int(_flags));
		#elif NANOVG_GL2ES_IMPLEMENTATION
			nvgCreateGL2ES(val_int(_atlasW), val_int(_atlasH), val_int(_flags));
		#elif NANOVG_GL3ES_IMPLEMENTATION
			nvgCreateGL3ES(val_int(_atlasW), val_int(_atlasH), val_int(_flags));
		#endif

		return alloc_abstract(k_nvgContext, ctx);
	}
	DEFINE_PRIM(hx_nvgCreateGL, 3);

	void hx_nvgDeleteGL(value _ctx) {
		NVGcontext* ctx = (NVGcontext*)val_to_kind(_ctx, k_nvgContext);
		#if NANOVG_GL2_IMPLEMENTATION
			nvgDeleteGL2(ctx);
		#elif NANOVG_GL3_IMPLEMENTATION
			nvgDeleteGL3(ctx);
		#elif NANOVG_GL2ES_IMPLEMENTATION
			nvgDeleteGL2ES(ctx);
		#elif NANOVG_GL3ES_IMPLEMENTATION
			nvgDeleteGL3ES(ctx);
		#endif
	}
	DEFINE_PRIM(hx_nvgDeleteGL, 1);
}