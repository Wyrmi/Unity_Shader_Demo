Shader "Metropolia/BlinnShader"
{
	Properties
	{
		_Color("Color", Color) = (0.5, 0.5, 0.5, 1)
		_SpecularColor("Specular Color", Color) = (1,1,1,1)
		_SpecularAmount("Specular Amount", range(0, 3)) = 1
		_SpecularSmooth("Specular Smooth", range(0.1, 150)) = 1
	}

	SubShader
	{
		CGPROGRAM

		#pragma surface surf BlinnShading
		#include "UnityCG.cginc" 

		half4 _Color;
		half4 _SpecularColor;
		float _SpecularAmount;
		float _SpecularSmooth;
		float sini;

		struct Input
		{
			float2 uv_MainTex;
		};

		fixed4 LightingBlinnShading(SurfaceOutput s, half3 lightDir, half3 viewDir, half atten)
		{
			half3 h = normalize(lightDir + viewDir);
			half diff = max(0, dot(s.Normal, lightDir));
			float nh = max(0, dot(s.Normal, h));
			float spec = pow(nh, _SpecularSmooth) * _SpecularAmount;
			half4 c;
			c.rgb = (s.Albedo * _LightColor0.rgb * diff) * atten + spec * _SpecularColor;
			c.a = s.Alpha;
			return c;
		}

		/*void vert(inout appdata_full v)
		{
			float randoS = sin(_Time[1]);
			float randoC = cos(_Time[1]);
			float randoT = tan(_Time[1]);
			float3 rando = (randoS, randoC, randoT);
			rando = rando / 5;
			v.vertex.xyz += rando*v.texcoord.y*v.texcoord.y;
		}*/

		void surf(Input IN, inout SurfaceOutput o)
		{
			sini = sin(_Time[1]);
			sini = abs(sini) / 2.0;
			_Color.r = _Color.r + sini;
			o.Albedo = _Color.rgb;
			o.Alpha = _Color.a;
		}
		ENDCG
	}
	FallBack "Diffuse"
}