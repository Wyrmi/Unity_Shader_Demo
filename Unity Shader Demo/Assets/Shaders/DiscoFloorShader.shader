Shader "Metropolia/DiscoFloorShader"
{
	Properties
	{
		_TexYksi("1st Texture", 2D) = "white" {}
		_TexKaksi("2nd Texture", 2D) = "black" {}
		_Speed("Speed", range(1.0,10.0)) = 5.0
	}
	SubShader
	{
		CGPROGRAM

		#pragma surface surf Lambert
		#include "UnityCG.cginc" 

		sampler2D _TexYksi;
		sampler2D _TexKaksi;
		float _Speed;

		struct Input {
			float2 uv_TexYksi;
			float2 uv_TexKaksi;
		};

		void surf(Input IN, inout SurfaceOutput o)
		{
			float sini = sin(_Time[1] * _Speed);
			fixed4 texOne = tex2D(_TexYksi, IN.uv_TexYksi);
			fixed4 texTwo = tex2D(_TexKaksi, IN.uv_TexKaksi);
			o.Alpha = texOne.a;
			if(sini > 0)
				o.Albedo = texTwo.rgb;
			else
				o.Albedo = texOne.rgb;
		}
		ENDCG
	}
	FallBack "Diffuse"
}