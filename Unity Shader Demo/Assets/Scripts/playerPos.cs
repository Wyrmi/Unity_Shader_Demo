using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class playerPos : MonoBehaviour {

    public Material m_grass = null;
    private void Update()
    {
        m_grass.SetVector("_PlayerPos", this.transform.position);
        
    }
}
