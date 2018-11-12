# Unity_VariousTextureInstancing

<img src="https://github.com/XJINE/Unity_VariousTextureInstancing/blob/master/Screenshot.png" width="100%" height="auto" />

Sample for instancing with various textures. 

``sampler2D`` cannot be defined and used as ``UNITY_DEFINE_INSTANCED_PROP``.
So this sample uses ``Texture2DArray`` and define the index as ``UNITY_DEFINE_INSTANCED_PROP``.