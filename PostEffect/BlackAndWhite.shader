Shader "PostEffect/BlackAndWhite"
{
	Properties
	{
		_MainTex("MainTex", 2D) = "white" {}
	}

	SubShader
	{
		Tags { "Queue" = "Transparent" }
		Cull Back
		Blend Off

		Pass
		{
			CGPROGRAM

			#include "UnityCG.cginc"
			#pragma vertex vert
			#pragma fragment frag
			#pragma fragmentoption ARB_precision_hint_fastest

			sampler2D _MainTex;
			float4 _MainTex_ST;

			struct v2f
			{
				float4 pos : POSITION;
				half2 uv : TEXCOORD0;
			};

			v2f vert(appdata_full input)
			{
				v2f o;
				o.pos = mul(UNITY_MATRIX_MVP, input.vertex);
				o.uv = TRANSFORM_TEX(input.texcoord, _MainTex);

				return o;
			}

			fixed4 frag(v2f input) : COLOR
			{
				fixed4 color = tex2D(_MainTex, input.uv);

				fixed sum = color.r + color.g + color.b;
				color = fixed4(sum, sum , sum , 3.0) / 3.0;

				return color;
			}

			ENDCG
		}
	}
}