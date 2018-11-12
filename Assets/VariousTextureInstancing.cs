using UnityEngine;

public class VariousTextureInstancing : MonoBehaviour
{
    // REFERENCE:
    // - https://docs.unity3d.com/ja/current/Manual/GPUInstancing.html
    // - https://docs.unity3d.com/Manual/SL-TextureArrays.html

    #region Field

    public Material instancingMaterial;

    public Texture2D[] textures;

    #endregion Field

    protected virtual void Awake()
    {
        this.instancingMaterial.SetTexture("_Textures", Texture2DArrayGenerator.Generate(this.textures));
    }

    protected virtual void Update ()
    {
        if (Input.GetKeyDown(KeyCode.Return))
        {

            GameObject cube = GameObject.CreatePrimitive(PrimitiveType.Cube);
            cube.transform.position = new Vector3(Random.Range(-3, 3),
                                                  Random.Range(-3, 3),
                                                  Random.Range(-3, 3));

            Renderer renderer = cube.GetComponent<Renderer>();
            renderer.material = this.instancingMaterial;

            MaterialPropertyBlock materialPropertyBlock = new MaterialPropertyBlock();
            renderer.GetPropertyBlock(materialPropertyBlock);
            materialPropertyBlock.SetInt("_TexturesIndex", Random.Range(0, this.textures.Length));
            renderer.SetPropertyBlock(materialPropertyBlock);
        }
    }

    protected virtual void OnGUI() 
    {
        GUILayout.Label("Press [Return] to make new object.");
        GUILayout.Label("Keep check 'GameView > Stats > Graphics Batches' count.");
        GUILayout.Label("Turn off the 'Enable GPU Instancing' in material if you need.");
    }
}