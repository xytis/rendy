#     _                 GLSL.std.450                      main                -   .   2   4   >   @   L    
    examples/src/meshes/shader.vert  ?   �     // OpModuleProcessed entry-point main
// OpModuleProcessed client vulkan100
// OpModuleProcessed target-env vulkan1.0
// OpModuleProcessed entry-point main
#line 1
#version 450
#extension GL_ARB_separate_shader_objects : enable

layout(location = 0) in vec3 position;
layout(location = 1) in vec4 color;
layout(location = 2) in vec3 normal;
// vec4[4] is used instead of mat4 due to spirv-cross bug for dx12 backend
layout(location = 3) in vec4 model_1; // per-instance.
layout(location = 4) in vec4 model_2; // per-instance.
layout(location = 5) in vec4 model_3; // per-instance.
layout(location = 6) in vec4 model_4; // per-instance.

struct Light {
    vec3 pos;
    float pad;
    float intencity;
};

layout(std140, set = 0, binding = 0) uniform Args {
    mat4 proj;
    mat4 view;
    int lights_count;
    int pad1;
    int pad2;
    int pad3;
    Light lights[32];
};

layout(location = 0) out vec4 frag_pos;
layout(location = 1) out vec3 frag_norm;
layout(location = 2) out vec4 frag_color;

void main() {
    mat4 model_mat = mat4(model_1, model_2, model_3, model_4);
    frag_color = color;
    frag_norm = normalize((vec4(normal, 1.0) * model_mat).xyz);
    frag_pos = model_mat * vec4(position, 1.0);
    gl_Position = proj * view * frag_pos;
}
  	 GL_ARB_separate_shader_objects   
 GL_GOOGLE_cpp_style_line_directive    GL_GOOGLE_include_directive      main         model_1      model_2      model_3      model_4   -   frag_color    .   color     2   frag_norm     4   normal    >   frag_pos      @   position      J   gl_PerVertex      J       gl_Position   J      gl_PointSize      J      gl_ClipDistance   J      gl_CullDistance   L         O   Light     O       pos   O      pad   O      intencity     R   Args      R       proj      R      view      R      lights_count      R      pad1      R      pad2      R      pad3      R      lights    T       G           G           G           G           G  -         G  .         G  2         G  4         G  >          G  @          H  J              H  J            H  J            H  J            G  J      H  O       #       H  O      #      H  O      #      G  Q          H  R          H  R       #       H  R             H  R         H  R      #   @   H  R            H  R      #   �   H  R      #   �   H  R      #   �   H  R      #   �   H  R      #   �   G  R      G  T   "       G  T   !            !                              	                     ;           ;           ;           ;           +          �?   ,         ;  ,   -      ;     .        0            1      0   ;  1   2         3      0   ;  3   4      ;  ,   >      ;  3   @        G           +  G   H        I      H     J         I   I      K      J   ;  K   L        M          +  M   N         O   0         +  G   P         Q   O   P    	 R   	   	   M   M   M   M   Q      S      R   ;  S   T         U      	   +  M   X      6               �          "       =           =           =           =           P  	   +                    #       =     /   .   >  -   /        $       =  0   5   4   Q     6   5       Q     7   5      Q     8   5      P     9   6   7   8      �     ;   9   +   O  0   <   ;   ;               0   =      E   <   >  2   =   =  0   A   @   Q     B   A       Q     C   A      Q     D   A      P     E   B   C   D      �     F   +   E   >  >   F        &       A  U   V   T   N   =  	   W   V   A  U   Y   T   X   =  	   Z   Y   �  	   [   W   Z   =     \   >   �     ]   [   \   A  ,   ^   L   N   >  ^   ]   �  8  