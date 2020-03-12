#     b                 GLSL.std.450              	       main       H   X   Y            
    examples/src/meshes/shader.frag  &   �     // OpModuleProcessed entry-point main
// OpModuleProcessed client vulkan100
// OpModuleProcessed target-env vulkan1.0
// OpModuleProcessed entry-point main
#line 1
#version 450
#extension GL_ARB_separate_shader_objects : enable

//layout(early_fragment_tests) in;

layout(location = 0) in vec4 frag_pos;
layout(location = 1) in vec3 frag_norm;
layout(location = 2) in vec4 frag_color;
layout(location = 0) out vec4 color;

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

void main() {
    float acc = 0.0;

    vec3 frag_pos = frag_pos.xyz / frag_pos.w;

    for (int i = 0; i < lights_count; ++i) {
        vec3 v = lights[i].pos - frag_pos;
        float d = length(v);
        float l = lights[i].intencity / d / d;
        l *= max(0.0, dot(normalize(v), frag_norm));
        acc += l;
        // acc += 0.5;
        // acc += lights[i].intencity;
    }
    acc = min(acc, 1.0);
    color = frag_color * vec4(acc, acc, acc, 1.0);
    // color = frag_color;
}
     	 GL_ARB_separate_shader_objects   
 GL_GOOGLE_cpp_style_line_directive    GL_GOOGLE_include_directive      main         frag_pos      %   Light     %       pos   %      pad   %      intencity     (   Args      (       proj      (      view      (      lights_count      (      pad1      (      pad2      (      pad3      (      lights    *         H   frag_norm     X   color     Y   frag_color  G            H  %       #       H  %      #      H  %      #      G  '          H  (          H  (       #       H  (             H  (         H  (      #   @   H  (            H  (      #   �   H  (      #   �   H  (      #   �   H  (      #   �   H  (      #   �   G  (      G  *   "       G  *   !       G  H         G  X          G  Y              !                 +     
                                         ;                        +                                   +              $           %            +     &         '   %   &    	 (   $   $               '      )      (   ;  )   *      +     +         ,           /   +     2         4            >            G         ;  G   H      +     R      +     U     �?   W         ;  W   X      ;     Y      6               �                 =           O                        A              =           P                 �              �     �     �     a   
      P      �     `         S      A  ,   -   *   +   =     .   -   �  /   0   `   .   �             �  0          �     A  4   5   *   2   `      =     6   5   �     8   6           ;      B   8   A  >   ?   *   2   `   +   =     @   ?   �     B   @   ;   �     D   B   ;        F      E   8   =     I   H   �     J   F   I        K      (   
   J   �     M   D   K   �     P   a   M   �     S   `   R   �     �           V      %   a   U        *       =     Z   Y   P     ^   V   V   V   U   �     _   Z   ^   >  X   _   �  8  