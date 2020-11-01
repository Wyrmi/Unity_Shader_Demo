Shader "Metropolia/ButterflyShader"
{
	Properties
	{
		_MainTex("Main Tex", 2D) = "white" {}
		_PositionTex("Position Tex", 2D) = "grey" {}
		_WingsPositionTex("Wings Position Tex", 2D) = "black" {}
		_Speed("Speed", float) = 1
		_Amount("Amount", float) = 1
		_Color("Glow Color", Color) = (1,1,1,1)
		_Glow("Intensity", Range(0, 3)) = 1
	}

		SubShader
		{
			CGPROGRAM

			#pragma surface surf Lambert vertex:vert

			struct Input
			{
				float2 uv_MainTex;
			};

			sampler2D _MainTex;
			sampler2D _PositionTex;
			sampler2D _WingsPositionTex;
			float _Speed;
			float _Amount;
			fixed4 _Color;
			half _Glow;

			void vert(inout appdata_full v)
			{
				float tx = _Time[1] * _Speed;
				float3 p = (tex2Dlod(_PositionTex, float4(v.texcoord1.x + tx, v.texcoord1.y + tx, 0, 0)).xyz - 0.5) * 2.0;
				float y = (tex2Dlod(_PositionTex, float4(v.texcoord1.x, v.texcoord1.y, 0, 0)).x - 0.5) * 2.0;
				float h = (tex2Dlod(_WingsPositionTex, float4(v.texcoord.x + tx * 400.0 + y * 40.0, v.texcoord.y, 0, 0)).x - 0.5) * 2.0;
				v.vertex.y += h * 0.04 * (1 - v.texcoord.x);
				v.vertex.xyz += p * _Amount;
			}

			void surf(Input IN, inout SurfaceOutput o)
			{
				fixed4 c = tex2D(_MainTex, IN.uv_MainTex);
				c = c * _Glow;
				c = c * _Color;
				o.Albedo = c.rgb;
				o.Alpha = c.a;
			}
			ENDCG
		}
}