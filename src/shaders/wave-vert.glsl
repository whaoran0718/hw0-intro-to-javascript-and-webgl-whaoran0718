#version 300 es
precision highp float;

uniform mat4 u_Model;
uniform mat4 u_ModelInvTr;
uniform mat4 u_ViewProj;
uniform float u_Time;

in vec4 vs_Pos;
in vec4 vs_Nor;
in vec4 vs_Col;

out vec4 fs_Pos;
out vec4 fs_Nor;
out vec4 fs_LightVec;
out vec4 fs_Col;

const vec4 lightPos = vec4(5, 5, 3, 1);

void main()
{
    fs_Col = vs_Col;

    mat3 invTranspose = mat3(u_ModelInvTr);
    fs_Nor = vec4(invTranspose * vec3(vs_Nor), 0);


    vec4 modelposition = u_Model * vs_Pos;

    fs_LightVec = lightPos - modelposition;
    modelposition += (normalize(fs_LightVec) * 0.4 + fs_Nor * 0.1) * clamp(cos(u_Time * 0.01 * 6.28318 - length(fs_LightVec) * 5.0 + 2.0), 0.0, 1.0) * 0.4;

    fs_Pos = u_Model * vs_Pos;
    gl_Position = u_ViewProj * modelposition;
}
