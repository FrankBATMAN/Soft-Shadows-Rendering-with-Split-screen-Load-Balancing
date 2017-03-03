#version 330
layout (location = 0) out float OcclusionShadow;

in vec4 _FragmentLightPosition;

uniform float near_plane;
uniform float far_plane;
uniform sampler2D uDepthMap;

float calculateShadowValue(vec4 vFragmentLightPosition)
{
	vec3 ProjectionCoords = vFragmentLightPosition.xyz / vFragmentLightPosition.w;
	if(ProjectionCoords.z > 1.0)
		ProjectionCoords.z = 1.0;
	ProjectionCoords = ProjectionCoords * 0.5 + vec3(0.5);
	float currentDepth = ProjectionCoords.z;
	float closestDepth = texture(uDepthMap, ProjectionCoords.xy).r;
	return currentDepth - 0.000005 > closestDepth ? 1.0 : 0.0;
}

void main()
{
	OcclusionShadow = calculateShadowValue(_FragmentLightPosition);
}