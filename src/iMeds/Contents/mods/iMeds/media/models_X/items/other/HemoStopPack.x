xof 0302txt 0064
template Header {
 <3D82AB43-62DA-11cf-AB39-0020AF71E433>
 WORD major;
 WORD minor;
 DWORD flags;
}

template Vector {
 <3D82AB5E-62DA-11cf-AB39-0020AF71E433>
 FLOAT x;
 FLOAT y;
 FLOAT z;
}

template Coords2d {
 <F6F23F44-7686-11cf-8F52-0040333594A3>
 FLOAT u;
 FLOAT v;
}

template Matrix4x4 {
 <F6F23F45-7686-11cf-8F52-0040333594A3>
 array FLOAT matrix[16];
}

template ColorRGBA {
 <35FF44E0-6C7C-11cf-8F52-0040333594A3>
 FLOAT red;
 FLOAT green;
 FLOAT blue;
 FLOAT alpha;
}

template ColorRGB {
 <D3E16E81-7835-11cf-8F52-0040333594A3>
 FLOAT red;
 FLOAT green;
 FLOAT blue;
}

template Material {
 <3D82AB4D-62DA-11cf-AB39-0020AF71E433>
 ColorRGBA faceColor;
 FLOAT power;
 ColorRGB specularColor;
 ColorRGB emissiveColor;
 [...]
}

template MeshFace {
 <3D82AB5F-62DA-11cf-AB39-0020AF71E433>
 DWORD nFaceVertexIndices;
 array DWORD faceVertexIndices[nFaceVertexIndices];
}

template MeshTextureCoords {
 <F6F23F40-7686-11cf-8F52-0040333594A3>
 DWORD nTextureCoords;
 array Coords2d textureCoords[nTextureCoords];
}

template MeshMaterialList {
 <F6F23F42-7686-11cf-8F52-0040333594A3>
 DWORD nMaterials;
 DWORD nFaceIndexes;
 array DWORD faceIndexes[nFaceIndexes];
 [Material]
}

template MeshNormals {
 <F6F23F43-7686-11cf-8F52-0040333594A3>
 DWORD nNormals;
 array Vector normals[nNormals];
 DWORD nFaceNormals;
 array MeshFace faceNormals[nFaceNormals];
}

template Mesh {
 <3D82AB44-62DA-11cf-AB39-0020AF71E433>
 DWORD nVertices;
 array Vector vertices[nVertices];
 DWORD nFaces;
 array MeshFace faces[nFaces];
 [...]
}

template FrameTransformMatrix {
 <F6F23F41-7686-11cf-8F52-0040333594A3>
 Matrix4x4 frameMatrix;
}

template Frame {
 <3D82AB46-62DA-11cf-AB39-0020AF71E433>
 [...]
}


Material Mat_HemoStopPack {
 0.800000;0.800000;0.800000;1.000000;;
 324.0000;
 0.500000;0.500000;0.500000;;
 0.250000;0.250000;0.250000;;
 TextureFilename {
 "HemoStopPack.png";
 }
}

Header {
 1;
 0;
 1;
}

Frame Model1 {
 FrameTransformMatrix {
  1.000000,0.000000,0.000000,0.000000,
  0.000000,1.000000,0.000000,0.000000,
  0.000000,0.000000,1.000000,0.000000,
  0.000000,0.000000,0.000000,1.000000;;
 }
Mesh Model1 {
 24;
 0.000302;0.000476;-0.000127;,
 -0.000302;0.000476;-0.000127;,
 -0.000302;0.000476;0.000127;,
 0.000302;0.000476;0.000127;,
 0.000302;-0.000476;0.000127;,
 0.000302;0.000476;0.000127;,
 -0.000302;0.000476;0.000127;,
 -0.000302;-0.000476;0.000127;,
 -0.000302;-0.000476;0.000127;,
 -0.000302;0.000476;0.000127;,
 -0.000302;0.000476;-0.000127;,
 -0.000302;-0.000476;-0.000127;,
 -0.000302;-0.000476;-0.000127;,
 0.000302;-0.000476;-0.000127;,
 0.000302;-0.000476;0.000127;,
 -0.000302;-0.000476;0.000127;,
 0.000302;-0.000476;-0.000127;,
 0.000302;0.000476;-0.000127;,
 0.000302;0.000476;0.000127;,
 0.000302;-0.000476;0.000127;,
 -0.000302;-0.000476;-0.000127;,
 -0.000302;0.000476;-0.000127;,
 0.000302;0.000476;-0.000127;,
 0.000302;-0.000476;-0.000127;;

 6;
 4;0,1,2,3;,
 4;4,5,6,7;,
 4;8,9,10,11;,
 4;12,13,14,15;,
 4;16,17,18,19;,
 4;20,21,22,23;;

 MeshMaterialList {
  1;
  6;
  0,
  0,
  0,
  0,
  0,
  0;;
  {Mat_HemoStopPack}
 }

 MeshNormals {
  24;
  0.000000;1.000000;0.000000;,
  0.000000;1.000000;0.000000;,
  0.000000;1.000000;0.000000;,
  0.000000;1.000000;0.000000;,
  0.000000;0.000000;1.000000;,
  0.000000;0.000000;1.000000;,
  0.000000;0.000000;1.000000;,
  0.000000;0.000000;1.000000;,
  -1.000000;0.000000;0.000000;,
  -1.000000;0.000000;0.000000;,
  -1.000000;0.000000;0.000000;,
  -1.000000;0.000000;0.000000;,
  0.000000;-1.000000;0.000000;,
  0.000000;-1.000000;0.000000;,
  0.000000;-1.000000;0.000000;,
  0.000000;-1.000000;0.000000;,
  1.000000;0.000000;0.000000;,
  1.000000;0.000000;0.000000;,
  1.000000;0.000000;0.000000;,
  1.000000;0.000000;0.000000;,
  0.000000;0.000000;-1.000000;,
  0.000000;0.000000;-1.000000;,
  0.000000;0.000000;-1.000000;,
  0.000000;0.000000;-1.000000;;

  6;
  4;0,1,2,3;,
  4;4,5,6,7;,
  4;8,9,10,11;,
  4;12,13,14,15;,
  4;16,17,18,19;,
  4;20,21,22,23;;
 }

 MeshTextureCoords {
  24;
  0.295852;0.554210;,
  0.295852;0.906284;,
  0.147926;0.906284;,
  0.147926;0.554210;,
  0.352074;0.000000;,
  0.352074;0.554210;,
  0.000000;0.554210;,
  0.000000;0.000000;,
  1.000000;0.000000;,
  1.000000;0.554210;,
  0.852074;0.554210;,
  0.852074;0.000000;,
  0.147926;0.554210;,
  0.147926;0.906284;,
  0.000000;0.906284;,
  0.000000;0.554210;,
  0.852074;0.000000;,
  0.852074;0.554210;,
  0.704148;0.554210;,
  0.704148;0.000000;,
  0.704148;0.000000;,
  0.704148;0.554210;,
  0.352074;0.554210;,
  0.352074;0.000000;;
  }
 }
}
