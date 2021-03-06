﻿Shader "Metropolia/frameshader" {
	Properties {
		_MainTex("Image", 2D) = "black"{}
		_FrameTex("Frame", 2D) = "black"{}
	}
	SubShader {
		CGPROGRAM
		#pragma surface surf Lambert
		#include "UnityCG.cginc"

		sampler2D _MainTex;
		sampler2D _FrameTex;

		struct Input {
			float2 uv_MainTex;
			float2 uv2_FrameTex;
		};

		void surf (Input IN, inout SurfaceOutput o) {
			fixed4 mainCol = tex2D(_MainTex, IN.uv_MainTex);
		    fixed4 texTwoCol = tex2D(_FrameTex, IN.uv_MainTex);                           
		      
		    fixed4 mainOutput = mainCol.rgba * (1.0 - (texTwoCol.a));
		    fixed4 blendOutput = texTwoCol.rgba * texTwoCol.a;         
		      
		    o.Albedo = mainOutput.rgb + blendOutput.rgb;
		    o.Alpha = mainOutput.a + blendOutput.a;
		}
		ENDCG
	}
}
