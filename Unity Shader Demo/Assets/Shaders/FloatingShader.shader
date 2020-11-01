Shader "Metropolia/FloatingShader"
{
	Properties
	{
		_MainTex("Main texture", 2D) = "white" {}
		_FloatX("X floating speed", float) = 1
		_FloatY("Y floating speed", float) = 1
		_AmpliX("X amplitude", float) = 2
		_AmpliY("Y amplitude", float) = 2
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
			float _FloatX;
			float _FloatY;
			float _AmpliX;
			float _AmpliY;

			void vert(inout appdata_full v)
			{
				float sx = v.texcoord.x + cos(_FloatX * _Time[1]) * _AmpliX;
				float sy = v.texcoord.y + sin(_FloatY * _Time[1]) * _AmpliY;
				v.vertex.y = sy;
				v.vertex.x = sx;
				v.normal = normalize(float3(sx, sy, v.vertex.z));
			}

			void surf(Input IN, inout SurfaceOutput o)
			{
				o.Albedo = tex2D(_MainTex, IN.uv_MainTex);
				o.Alpha = 1;
			}

			ENDCG
		}
}