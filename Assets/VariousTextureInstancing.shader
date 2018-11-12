Shader "Unlit/VariousTextureInstancing"
{
    // When use Texture2DArray as precompiled assets.

    //Properties
    //{
    //    _Textures("Textures", 2DArray) = "" {}
    //}

    SubShader
    {
        Tags
        {
            "RenderType" = "Opaque"
        }

        Pass
        {
            CGPROGRAM

            #pragma vertex   vert
            #pragma fragment frag
            #pragma multi_compile_instancing

            // This is not required, use for notice in an unsupported environment.
            #pragma require 2darray

            #include "UnityCG.cginc"

            struct appdata
            {
                float4 vertex : POSITION;
                float2 uv : TEXCOORD0;

                UNITY_VERTEX_INPUT_INSTANCE_ID
            };

            struct v2f
            {
                float2 uv : TEXCOORD0;
                float4 vertex : SV_POSITION;

                UNITY_VERTEX_INPUT_INSTANCE_ID
            };

            UNITY_DECLARE_TEX2DARRAY(_Textures);
            
            UNITY_INSTANCING_BUFFER_START(Props)
            UNITY_DEFINE_INSTANCED_PROP(int, _TexturesIndex)
            UNITY_INSTANCING_BUFFER_END(Props)

            v2f vert (appdata v)
            {
                UNITY_SETUP_INSTANCE_ID(v); // This must be done in the top function.

                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.uv     = v.uv;

                UNITY_TRANSFER_INSTANCE_ID(v, o);

                return o;
            }
            
            fixed4 frag (v2f i) : SV_Target
            {
                UNITY_SETUP_INSTANCE_ID(i); // This must be done in the top of function.

                int texIndex  = UNITY_ACCESS_INSTANCED_PROP(Props, _TexturesIndex);
                fixed4 color  = UNITY_SAMPLE_TEX2DARRAY(_Textures, float3(i.uv.xy, texIndex)); // z will be rounded.

                return color;
            }

            ENDCG
        }
    }
}