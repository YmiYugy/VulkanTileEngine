#version 450
#extension GL_ARB_separate_shader_objects : enable

struct Instance{
  mat4 model;
  vec4 arrayIndex;
};


layout(binding = 0) uniform UniformBufferObject {
    mat4 view;
    mat4 proj;
    Instance instance[9];
} ubo;

layout(location = 0) in vec3 inPosition;
layout(location = 1) in vec3 inColor;
layout(location = 2) in vec2 inTexCoord;

layout(location = 0) out vec3 fragColor;
layout(location = 1) out vec3 fragTexCoord;

out gl_PerVertex {
    vec4 gl_Position;
};

void main() {

    gl_Position = ubo.proj * ubo.view * ubo.instance[gl_InstanceIndex].model * vec4(inPosition, 1.0);
    //gl_Position = vec4(inPosition, 1.0);
    fragColor = vec3(1);
    fragTexCoord = vec3(inTexCoord, ubo.instance[gl_InstanceIndex].arrayIndex.x);
    //fragTexCoord = vec3(inTexCoord, gl_InstanceIndex);
}
