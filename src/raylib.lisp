;;;/**********************************************************************************************
;;;*
;;;*   raylib 1.6.0 (www.raylib.com)
;;;*
;;;*   A simple and easy-to-use library to learn videogames programming
;;;*
;;;*   Features:
;;;*     Library written in plain C code (C99)
;;;*     Uses PascalCase/camelCase notation
;;;*     Hardware accelerated with OpenGL (1.1, 2.1, 3.3 or ES 2.0)
;;;*     Unique OpenGL abstraction layer (usable as standalone module): [rlgl]
;;;*     Powerful fonts module with SpriteFonts support (XNA bitmap fonts, AngelCode fonts, TTF)
;;;*     Multiple textures support, including compressed formats and mipmaps generation
;;;*     Basic 3d support for Shapes, Models, Billboards, Heightmaps and Cubicmaps
;;;*     Materials (diffuse, normal, specular) and Lighting (point, directional, spot) support
;;;*     Powerful math module for Vector, Matrix and Quaternion operations: [raymath]
;;;*     Audio loading and playing with streaming support and mixing channels [audio]
;;;*     VR stereo rendering support with configurable HMD device parameters
;;;*     Multiple platforms support: Windows, Linux, Mac, Android, Raspberry Pi, HTML5 and Oculus Rift CV1
;;;*     Custom color palette for fancy visuals on raywhite background
;;;*     Minimal external dependencies (GLFW3, OpenGL, OpenAL)
;;;*     Complete binding for LUA [rlua]
;;;*
;;;*   External libs:
;;;*     GLFW3 (www.glfw.org) for window/context management and input [core]
;;;*     GLAD for OpenGL extensions loading (3.3 Core profile, only PLATFORM_DESKTOP) [rlgl]
;;;*     stb_image (Sean Barret) for images loading (JPEG, PNG, BMP, TGA) [textures]
;;;*     stb_image_write (Sean Barret) for image writting (PNG) [utils]
;;;*     stb_truetype (Sean Barret) for ttf fonts loading [text]
;;;*     stb_vorbis (Sean Barret) for ogg audio loading [audio]
;;;*     jar_xm (Joshua Reisenauer) for XM audio module loading [audio]
;;;*     jar_mod (Joshua Reisenauer) for MOD audio module loading [audio]
;;;*     dr_flac (David Reid) for FLAC audio file loading [audio]
;;;*     OpenAL Soft for audio device/context management [audio]
;;;*     tinfl for data decompression (DEFLATE algorithm) [utils]
;;;*
;;;*   Some design decisions:
;;;*     32bit Colors - All defined color are always RGBA (struct Color is 4 byte)
;;;*     One custom default font could be loaded automatically when InitWindow() [core]
;;;*     If using OpenGL 3.3 or ES2, several vertex buffers (VAO/VBO) are created to manage lines-triangles-quads
;;;*     If using OpenGL 3.3 or ES2, two default shaders could be loaded automatically (internally defined)
;;;*
;;;*   -- LICENSE --
;;;*
;;;*   raylib is licensed under an unmodified zlib/libpng license, which is an OSI-certified,
;;;*   BSD-like license that allows static linking with closed source software:
;;;*
;;;*   Copyright (c) 2013-2016 Ramon Santamaria (@raysan5)
;;;*
;;;*   This software is provided "as-is", without any express or implied warranty. In no event
;;;*   will the authors be held liable for any damages arising from the use of this software.
;;;*
;;;*   Permission is granted to anyone to use this software for any purpose, including commercial
;;;*   applications, and to alter it and redistribute it freely, subject to the following restrictions:
;;;*
;;;*     1. The origin of this software must not be misrepresented; you must not claim that you
;;;*     wrote the original software. If you use this software in a product, an acknowledgment
;;;*     in the product documentation would be appreciated but is not required.
;;;*
;;;*     2. Altered source versions must be plainly marked as such, and must not be misrepresented
;;;*     as being the original software.
;;;*
;;;*     3. This notice may not be removed or altered from any source distribution.
;;;*
;;;**********************************************************************************************/

(in-package #:cl-raylib)
;;#ifndef RAYLIB_H
;;#define RAYLIB_H
;;
;;// Choose your platform here or just define it at compile time: -DPLATFORM_DESKTOP
;;//#define PLATFORM_DESKTOP      // Windows, Linux or OSX
;;//#define PLATFORM_ANDROID      // Android device
;;//#define PLATFORM_RPI          // Raspberry Pi
;;//#define PLATFORM_WEB          // HTML5 (emscripten, asm.js)
;;//#define RLGL_OCULUS_SUPPORT   // Oculus Rift CV1 (complementary to PLATFORM_DESKTOP)
;;
;;// Security check in case no PLATFORM_* defined
;;#if !defined(PLATFORM_DESKTOP) && !defined(PLATFORM_ANDROID) && !defined(PLATFORM_RPI) && !defined(PLATFORM_WEB)
;;    #define PLATFORM_DESKTOP
;;#endif
;;
;;#if defined(_WIN32) && defined(BUILDING_DLL)
;;    #define RLAPI __declspec(dllexport)         // We are building raylib as a Win32 DLL
;;#elif defined(_WIN32) && defined(RAYLIB_DLL)
;;    #define RLAPI __declspec(dllimport)         // We are using raylib as a Win32 DLL
;;#else
;;    #define RLAPI   // We are building or using raylib as a static library (or Linux shared library)
;;#endif
;;
;;//----------------------------------------------------------------------------------
;;// Some basic Defines
;;//----------------------------------------------------------------------------------
;;#ifndef PI
;;    #define PI 3.14159265358979323846f
;;#endif

;;#define DEG2RAD (PI/180.0f)
;;#define RAD2DEG (180.0f/PI)

;;// raylib Config Flags
;;#define FLAG_FULLSCREEN_MODE    1
;;#define FLAG_RESIZABLE_WINDOW   2
;;#define FLAG_SHOW_LOGO          4
;;#define FLAG_SHOW_MOUSE_CURSOR  8
;;#define FLAG_CENTERED_MODE     16
;;#define FLAG_MSAA_4X_HINT      32
;;#define FLAG_VSYNC_HINT        64
;;
;;// Keyboard Function Keys
;;#define KEY_SPACE            32
;;#define KEY_ESCAPE          256
;;#define KEY_ENTER           257
;;#define KEY_BACKSPACE       259
;;#define KEY_RIGHT           262
;;#define KEY_LEFT            263
;;#define KEY_DOWN            264
;;#define KEY_UP              265
;;#define KEY_F1              290
;;#define KEY_F2              291
;;#define KEY_F3              292
;;#define KEY_F4              293
;;#define KEY_F5              294
;;#define KEY_F6              295
;;#define KEY_F7              296
;;#define KEY_F8              297
;;#define KEY_F9              298
;;#define KEY_F10             299
;;#define KEY_F11             300
;;#define KEY_F12             301
;;#define KEY_LEFT_SHIFT      340
;;#define KEY_LEFT_CONTROL    341
;;#define KEY_LEFT_ALT        342
;;#define KEY_RIGHT_SHIFT     344
;;#define KEY_RIGHT_CONTROL   345
;;#define KEY_RIGHT_ALT       346
;;
;;// Keyboard Alpha Numeric Keys
;;#define KEY_ZERO             48
;;#define KEY_ONE              49
;;#define KEY_TWO              50
;;#define KEY_THREE            51
;;#define KEY_FOUR             52
;;#define KEY_FIVE             53
;;#define KEY_SIX              54
;;#define KEY_SEVEN            55
;;#define KEY_EIGHT            56
;;#define KEY_NINE             57
;;#define KEY_A                65
;;#define KEY_B                66
;;#define KEY_C                67
;;#define KEY_D                68
;;#define KEY_E                69
;;#define KEY_F                70
;;#define KEY_G                71
;;#define KEY_H                72
;;#define KEY_I                73
;;#define KEY_J                74
;;#define KEY_K                75
;;#define KEY_L                76
;;#define KEY_M                77
;;#define KEY_N                78
;;#define KEY_O                79
;;#define KEY_P                80
;;#define KEY_Q                81
;;#define KEY_R                82
;;#define KEY_S                83
;;#define KEY_T                84
;;#define KEY_U                85
;;#define KEY_V                86
;;#define KEY_W                87
;;#define KEY_X                88
;;#define KEY_Y                89
;;#define KEY_Z                90
;;
;;#if defined(PLATFORM_ANDROID)
;;    // Android Physical Buttons
;;    #define KEY_BACK              4
;;    #define KEY_MENU             82
;;    #define KEY_VOLUME_UP        24
;;    #define KEY_VOLUME_DOWN      25
;;#endif
;;
;;// Mouse Buttons
;;#define MOUSE_LEFT_BUTTON     0
;;#define MOUSE_RIGHT_BUTTON    1
;;#define MOUSE_MIDDLE_BUTTON   2
;;
;;// Touch points registered
;;#define MAX_TOUCH_POINTS     2
;;
;;// Gamepad Number
;;#define GAMEPAD_PLAYER1       0
;;#define GAMEPAD_PLAYER2       1
;;#define GAMEPAD_PLAYER3       2
;;#define GAMEPAD_PLAYER4       3
;;
;;// Gamepad Buttons/Axis
;;
;;// PS3 USB Controller Buttons
;;#define GAMEPAD_PS3_BUTTON_TRIANGLE 0
;;#define GAMEPAD_PS3_BUTTON_CIRCLE   1
;;#define GAMEPAD_PS3_BUTTON_CROSS    2
;;#define GAMEPAD_PS3_BUTTON_SQUARE   3
;;#define GAMEPAD_PS3_BUTTON_L1       6
;;#define GAMEPAD_PS3_BUTTON_R1       7
;;#define GAMEPAD_PS3_BUTTON_L2       4
;;#define GAMEPAD_PS3_BUTTON_R2       5
;;#define GAMEPAD_PS3_BUTTON_START    8
;;#define GAMEPAD_PS3_BUTTON_SELECT   9
;;#define GAMEPAD_PS3_BUTTON_UP      24
;;#define GAMEPAD_PS3_BUTTON_RIGHT   25
;;#define GAMEPAD_PS3_BUTTON_DOWN    26
;;#define GAMEPAD_PS3_BUTTON_LEFT    27
;;#define GAMEPAD_PS3_BUTTON_PS      12
;;
;;// PS3 USB Controller Axis
;;#define GAMEPAD_PS3_AXIS_LEFT_X     0
;;#define GAMEPAD_PS3_AXIS_LEFT_Y     1
;;#define GAMEPAD_PS3_AXIS_RIGHT_X    2
;;#define GAMEPAD_PS3_AXIS_RIGHT_Y    5
;;#define GAMEPAD_PS3_AXIS_L2         3       // [1..-1] (pressure-level)
;;#define GAMEPAD_PS3_AXIS_R2         4       // [1..-1] (pressure-level)
;;
;;// Xbox360 USB Controller Buttons
;;#define GAMEPAD_XBOX_BUTTON_A       0
;;#define GAMEPAD_XBOX_BUTTON_B       1
;;#define GAMEPAD_XBOX_BUTTON_X       2
;;#define GAMEPAD_XBOX_BUTTON_Y       3
;;#define GAMEPAD_XBOX_BUTTON_LB      4
;;#define GAMEPAD_XBOX_BUTTON_RB      5
;;#define GAMEPAD_XBOX_BUTTON_SELECT  6
;;#define GAMEPAD_XBOX_BUTTON_START   7
;;#define GAMEPAD_XBOX_BUTTON_UP      10
;;#define GAMEPAD_XBOX_BUTTON_RIGHT   11
;;#define GAMEPAD_XBOX_BUTTON_DOWN    12
;;#define GAMEPAD_XBOX_BUTTON_LEFT    13
;;#define GAMEPAD_XBOX_BUTTON_HOME    8
;;
;;// Xbox360 USB Controller Axis
;;// NOTE: For Raspberry Pi, axis must be reconfigured
;;#if defined(PLATFORM_RPI)
;;    #define GAMEPAD_XBOX_AXIS_LEFT_X    0   // [-1..1] (left->right)
;;    #define GAMEPAD_XBOX_AXIS_LEFT_Y    1   // [-1..1] (up->down)
;;    #define GAMEPAD_XBOX_AXIS_RIGHT_X   3   // [-1..1] (left->right)
;;    #define GAMEPAD_XBOX_AXIS_RIGHT_Y   4   // [-1..1] (up->down)
;;    #define GAMEPAD_XBOX_AXIS_LT        2   // [-1..1] (pressure-level)
;;    #define GAMEPAD_XBOX_AXIS_RT        5   // [-1..1] (pressure-level)
;;#else
;;    #define GAMEPAD_XBOX_AXIS_LEFT_X    0   // [-1..1] (left->right)
;;    #define GAMEPAD_XBOX_AXIS_LEFT_Y    1   // [1..-1] (up->down)
;;    #define GAMEPAD_XBOX_AXIS_RIGHT_X   2   // [-1..1] (left->right)
;;    #define GAMEPAD_XBOX_AXIS_RIGHT_Y   3   // [1..-1] (up->down)
;;    #define GAMEPAD_XBOX_AXIS_LT        4   // [-1..1] (pressure-level)
;;    #define GAMEPAD_XBOX_AXIS_RT        5   // [-1..1] (pressure-level)
;;#endif
;;
;;// NOTE: MSC C++ compiler does not support compound literals (C99 feature)
;;// Plain structures in C++ (without constructors) can be initialized from { } initializers.
;;#ifdef __cplusplus
;;    #define CLITERAL
;;#else
;;    #define CLITERAL    (Color)
;;#endif
;;
;;// Some Basic Colors
;;// NOTE: Custom raylib color palette for amazing visuals on WHITE background
;;#define LIGHTGRAY  CLITERAL{ 200, 200, 200, 255 }   // Light Gray
;;#define GRAY       CLITERAL{ 130, 130, 130, 255 }   // Gray
;;#define DARKGRAY   CLITERAL{ 80, 80, 80, 255 }      // Dark Gray
;;#define YELLOW     CLITERAL{ 253, 249, 0, 255 }     // Yellow
;;#define GOLD       CLITERAL{ 255, 203, 0, 255 }     // Gold
;;#define ORANGE     CLITERAL{ 255, 161, 0, 255 }     // Orange
;;#define PINK       CLITERAL{ 255, 109, 194, 255 }   // Pink
;;#define RED        CLITERAL{ 230, 41, 55, 255 }     // Red
;;#define MAROON     CLITERAL{ 190, 33, 55, 255 }     // Maroon
;;#define GREEN      CLITERAL{ 0, 228, 48, 255 }      // Green
;;#define LIME       CLITERAL{ 0, 158, 47, 255 }      // Lime
;;#define DARKGREEN  CLITERAL{ 0, 117, 44, 255 }      // Dark Green
;;#define SKYBLUE    CLITERAL{ 102, 191, 255, 255 }   // Sky Blue
;;#define BLUE       CLITERAL{ 0, 121, 241, 255 }     // Blue
;;#define DARKBLUE   CLITERAL{ 0, 82, 172, 255 }      // Dark Blue
;;#define PURPLE     CLITERAL{ 200, 122, 255, 255 }   // Purple
;;#define VIOLET     CLITERAL{ 135, 60, 190, 255 }    // Violet
;;#define DARKPURPLE CLITERAL{ 112, 31, 126, 255 }    // Dark Purple
;;#define BEIGE      CLITERAL{ 211, 176, 131, 255 }   // Beige
;;#define BROWN      CLITERAL{ 127, 106, 79, 255 }    // Brown
;;#define DARKBROWN  CLITERAL{ 76, 63, 47, 255 }      // Dark Brown
;;
;;#define WHITE      CLITERAL{ 255, 255, 255, 255 }   // White
;;#define BLACK      CLITERAL{ 0, 0, 0, 255 }         // Black
;;#define BLANK      CLITERAL{ 0, 0, 0, 0 }           // Blank (Transparent)
;;#define MAGENTA    CLITERAL{ 255, 0, 255, 255 }     // Magenta
;;#define RAYWHITE   CLITERAL{ 245, 245, 245, 255 }   // My own White (raylib logo)
;;
;;//----------------------------------------------------------------------------------
;;// Types and Structures Definition
;;//----------------------------------------------------------------------------------
;;#ifndef __cplusplus
;;// Boolean type
;;    #ifndef __APPLE__
;;        #if !defined(_STDBOOL_H)
;;            typedef enum { false, true } bool;
;;            #define _STDBOOL_H
;;        #endif
;;    #else
;;        #include <stdbool.h>
;;    #endif
;;#endif
;;
;;// Vector2 type
;;typedef struct Vector2 {
;;    float x;
;;    float y;
;;} Vector2;
;;
;;// Vector3 type
;;typedef struct Vector3 {
;;    float x;
;;    float y;
;;    float z;
;;} Vector3;
;;
;;// Matrix type (OpenGL style 4x4 - right handed, column major)
;;typedef struct Matrix {
;;    float m0, m4, m8, m12;
;;    float m1, m5, m9, m13;
;;    float m2, m6, m10, m14;
;;    float m3, m7, m11, m15;
;;} Matrix;
;;
;;// Color type, RGBA (32bit)
;;typedef struct Color {
;;    unsigned char r;
;;    unsigned char g;
;;    unsigned char b;
;;    unsigned char a;
;;} Color;
;;
;;// Rectangle type
;;typedef struct Rectangle {
;;    int x;
;;    int y;
;;    int width;
;;    int height;
;;} Rectangle;
;;
;;// Image type, bpp always RGBA (32bit)
;;// NOTE: Data stored in CPU memory (RAM)
;;typedef struct Image {
;;    void *data;             // Image raw data
;;    int width;              // Image base width
;;    int height;             // Image base height
;;    int mipmaps;            // Mipmap levels, 1 by default
;;    int format;             // Data format (TextureFormat)
;;} Image;
;;
;;// Texture2D type, bpp always RGBA (32bit)
;;// NOTE: Data stored in GPU memory
;;typedef struct Texture2D {
;;    unsigned int id;        // OpenGL texture id
;;    int width;              // Texture base width
;;    int height;             // Texture base height
;;    int mipmaps;            // Mipmap levels, 1 by default
;;    int format;             // Data format (TextureFormat)
;;} Texture2D;
;;
;;// RenderTexture2D type, for texture rendering
;;typedef struct RenderTexture2D {
;;    unsigned int id;        // Render texture (fbo) id
;;    Texture2D texture;      // Color buffer attachment texture
;;    Texture2D depth;        // Depth buffer attachment texture
;;} RenderTexture2D;
;;
;;// SpriteFont type, includes texture and charSet array data
;;typedef struct SpriteFont {
;;    Texture2D texture;      // Font texture
;;    int size;               // Base size (default chars height)
;;    int numChars;           // Number of characters
;;    int *charValues;        // Characters values array
;;    Rectangle *charRecs;    // Characters rectangles within the texture
;;    Vector2 *charOffsets;   // Characters offsets (on drawing)
;;    int *charAdvanceX;      // Characters x advance (on drawing)
;;} SpriteFont;
;;
;;// Camera type, defines a camera position/orientation in 3d space
;;typedef struct Camera {
;;    Vector3 position;       // Camera position
;;    Vector3 target;         // Camera target it looks-at
;;    Vector3 up;             // Camera up vector (rotation over its axis)
;;    float fovy;             // Camera field-of-view apperture in Y (degrees)
;;} Camera;
;;
;;// Camera2D type, defines a 2d camera
;;typedef struct Camera2D {
;;    Vector2 offset;         // Camera offset (displacement from target)
;;    Vector2 target;         // Camera target (rotation and zoom origin)
;;    float rotation;         // Camera rotation in degrees
;;    float zoom;             // Camera zoom (scaling), should be 1.0f by default
;;} Camera2D;
;;
;;// Bounding box type
;;typedef struct BoundingBox {
;;    Vector3 min;            // minimum vertex box-corner
;;    Vector3 max;            // maximum vertex box-corner
;;} BoundingBox;
;;
;;// Vertex data definning a mesh
;;typedef struct Mesh {
;;    int vertexCount;        // number of vertices stored in arrays
;;    int triangleCount;      // number of triangles stored (indexed or not)
;;    float *vertices;        // vertex position (XYZ - 3 components per vertex) (shader-location = 0)
;;    float *texcoords;       // vertex texture coordinates (UV - 2 components per vertex) (shader-location = 1)
;;    float *texcoords2;      // vertex second texture coordinates (useful for lightmaps) (shader-location = 5)
;;    float *normals;         // vertex normals (XYZ - 3 components per vertex) (shader-location = 2)
;;    float *tangents;        // vertex tangents (XYZ - 3 components per vertex) (shader-location = 4)
;;    unsigned char *colors;  // vertex colors (RGBA - 4 components per vertex) (shader-location = 3)
;;    unsigned short *indices;// vertex indices (in case vertex data comes indexed)
;;
;;    unsigned int vaoId;     // OpenGL Vertex Array Object id
;;    unsigned int vboId[7];  // OpenGL Vertex Buffer Objects id (7 types of vertex data)
;;} Mesh;
;;
;;// Shader type (generic shader)
;;typedef struct Shader {
;;    unsigned int id;        // Shader program id
;;
;;    // Vertex attributes locations (default locations)
;;    int vertexLoc;          // Vertex attribute location point    (default-location = 0)
;;    int texcoordLoc;        // Texcoord attribute location point  (default-location = 1)
;;    int texcoord2Loc;       // Texcoord2 attribute location point (default-location = 5)
;;    int normalLoc;          // Normal attribute location point    (default-location = 2)
;;    int tangentLoc;         // Tangent attribute location point   (default-location = 4)
;;    int colorLoc;           // Color attibute location point      (default-location = 3)
;;
;;    // Uniform locations
;;    int mvpLoc;             // ModelView-Projection matrix uniform location point (vertex shader)
;;    int colDiffuseLoc;      // Diffuse color uniform location point (fragment shader)
;;    int colAmbientLoc;      // Ambient color uniform location point (fragment shader)
;;    int colSpecularLoc;     // Specular color uniform location point (fragment shader)
;;
;;    // Texture map locations (generic for any kind of map)
;;    int mapTexture0Loc;     // Map texture uniform location point (default-texture-unit = 0)
;;    int mapTexture1Loc;     // Map texture uniform location point (default-texture-unit = 1)
;;    int mapTexture2Loc;     // Map texture uniform location point (default-texture-unit = 2)
;;} Shader;
;;
;;// Material type
;;typedef struct Material {
;;    Shader shader;          // Standard shader (supports 3 map textures)
;;
;;    Texture2D texDiffuse;   // Diffuse texture  (binded to shader mapTexture0Loc)
;;    Texture2D texNormal;    // Normal texture   (binded to shader mapTexture1Loc)
;;    Texture2D texSpecular;  // Specular texture (binded to shader mapTexture2Loc)
;;
;;    Color colDiffuse;       // Diffuse color
;;    Color colAmbient;       // Ambient color
;;    Color colSpecular;      // Specular color
;;
;;    float glossiness;       // Glossiness level (Ranges from 0 to 1000)
;;} Material;
;;
;;// Model type
;;typedef struct Model {
;;    Mesh mesh;              // Vertex data buffers (RAM and VRAM)
;;    Matrix transform;       // Local transform matrix
;;    Material material;      // Shader and textures data
;;} Model;
;;
;;// Light type
;;typedef struct LightData {
;;    unsigned int id;        // Light unique id
;;    bool enabled;           // Light enabled
;;    int type;               // Light type: LIGHT_POINT, LIGHT_DIRECTIONAL, LIGHT_SPOT
;;
;;    Vector3 position;       // Light position
;;    Vector3 target;         // Light direction: LIGHT_DIRECTIONAL and LIGHT_SPOT (cone direction target)
;;    float radius;           // Light attenuation radius light intensity reduced with distance (world distance)
;;
;;    Color diffuse;          // Light diffuse color
;;    float intensity;        // Light intensity level
;;
;;    float coneAngle;        // Light cone max angle: LIGHT_SPOT
;;} LightData, *Light;
;;
;;// Light types
;;typedef enum { LIGHT_POINT, LIGHT_DIRECTIONAL, LIGHT_SPOT } LightType;
;;
;;// Ray type (useful for raycast)
;;typedef struct Ray {
;;    Vector3 position;       // Ray position (origin)
;;    Vector3 direction;      // Ray direction
;;} Ray;
;;
;;// Wave type, defines audio wave data
;;typedef struct Wave {
;;    unsigned int sampleCount;   // Number of samples
;;    unsigned int sampleRate;    // Frequency (samples per second)
;;    unsigned int sampleSize;    // Bit depth (bits per sample): 8, 16, 32 (24 not supported)
;;    unsigned int channels;      // Number of channels (1-mono, 2-stereo)
;;    void *data;                 // Buffer data pointer
;;} Wave;
;;
;;// Sound source type
;;typedef struct Sound {
;;    unsigned int source;    // OpenAL audio source id
;;    unsigned int buffer;    // OpenAL audio buffer id
;;    int format;             // OpenAL audio format specifier
;;} Sound;
;;
;;// Music type (file streaming from memory)
;;// NOTE: Anything longer than ~10 seconds should be streamed
;;typedef struct MusicData *Music;
;;
;;// Audio stream type
;;// NOTE: Useful to create custom audio streams not bound to a specific file
;;typedef struct AudioStream {
;;    unsigned int sampleRate;    // Frequency (samples per second)
;;    unsigned int sampleSize;    // Bit depth (bits per sample): 8, 16, 32 (24 not supported)
;;    unsigned int channels;      // Number of channels (1-mono, 2-stereo)
;;
;;    int format;                 // OpenAL audio format specifier
;;    unsigned int source;        // OpenAL audio source id
;;    unsigned int buffers[2];    // OpenAL audio buffers (double buffering)
;;} AudioStream;
;;
;;// Texture formats
;;// NOTE: Support depends on OpenGL version and platform
;;typedef enum {
;;    UNCOMPRESSED_GRAYSCALE = 1,     // 8 bit per pixel (no alpha)
;;    UNCOMPRESSED_GRAY_ALPHA,        // 16 bpp (2 channels)
;;    UNCOMPRESSED_R5G6B5,            // 16 bpp
;;    UNCOMPRESSED_R8G8B8,            // 24 bpp
;;    UNCOMPRESSED_R5G5B5A1,          // 16 bpp (1 bit alpha)
;;    UNCOMPRESSED_R4G4B4A4,          // 16 bpp (4 bit alpha)
;;    UNCOMPRESSED_R8G8B8A8,          // 32 bpp
;;    COMPRESSED_DXT1_RGB,            // 4 bpp (no alpha)
;;    COMPRESSED_DXT1_RGBA,           // 4 bpp (1 bit alpha)
;;    COMPRESSED_DXT3_RGBA,           // 8 bpp
;;    COMPRESSED_DXT5_RGBA,           // 8 bpp
;;    COMPRESSED_ETC1_RGB,            // 4 bpp
;;    COMPRESSED_ETC2_RGB,            // 4 bpp
;;    COMPRESSED_ETC2_EAC_RGBA,       // 8 bpp
;;    COMPRESSED_PVRT_RGB,            // 4 bpp
;;    COMPRESSED_PVRT_RGBA,           // 4 bpp
;;    COMPRESSED_ASTC_4x4_RGBA,       // 8 bpp
;;    COMPRESSED_ASTC_8x8_RGBA        // 2 bpp
;;} TextureFormat;
;;
;;// Texture parameters: filter mode
;;// NOTE 1: Filtering considers mipmaps if available in the texture
;;// NOTE 2: Filter is accordingly set for minification and magnification
;;typedef enum { 
;;    FILTER_POINT = 0,               // No filter, just pixel aproximation
;;    FILTER_BILINEAR,                // Linear filtering
;;    FILTER_TRILINEAR,               // Trilinear filtering (linear with mipmaps)
;;    FILTER_ANISOTROPIC_4X,          // Anisotropic filtering 4x
;;    FILTER_ANISOTROPIC_8X,          // Anisotropic filtering 8x
;;    FILTER_ANISOTROPIC_16X,         // Anisotropic filtering 16x
;;} TextureFilterMode;
;;
;;// Texture parameters: wrap mode
;;typedef enum { WRAP_REPEAT = 0, WRAP_CLAMP, WRAP_MIRROR } TextureWrapMode;
;;
;;// Color blending modes (pre-defined)
;;typedef enum { BLEND_ALPHA = 0, BLEND_ADDITIVE, BLEND_MULTIPLIED } BlendMode;
;;
;;// Gestures type
;;// NOTE: It could be used as flags to enable only some gestures
;;typedef enum {
;;    GESTURE_NONE        = 0,
;;    GESTURE_TAP         = 1,
;;    GESTURE_DOUBLETAP   = 2,
;;    GESTURE_HOLD        = 4,
;;    GESTURE_DRAG        = 8,
;;    GESTURE_SWIPE_RIGHT = 16,
;;    GESTURE_SWIPE_LEFT  = 32,
;;    GESTURE_SWIPE_UP    = 64,
;;    GESTURE_SWIPE_DOWN  = 128,
;;    GESTURE_PINCH_IN    = 256,
;;    GESTURE_PINCH_OUT   = 512
;;} Gestures;
;;
;;// Camera system modes
;;typedef enum { 
;;    CAMERA_CUSTOM = 0, 
;;    CAMERA_FREE, 
;;    CAMERA_ORBITAL, 
;;    CAMERA_FIRST_PERSON, 
;;    CAMERA_THIRD_PERSON 
;;} CameraMode;
;;
;;// Head Mounted Display devices
;;typedef enum {
;;    HMD_DEFAULT_DEVICE = 0,
;;    HMD_OCULUS_RIFT_DK2,
;;    HMD_OCULUS_RIFT_CV1,
;;    HMD_VALVE_HTC_VIVE,
;;    HMD_SAMSUNG_GEAR_VR,
;;    HMD_GOOGLE_CARDBOARD,
;;    HMD_SONY_PLAYSTATION_VR,
;;    HMD_RAZER_OSVR,
;;    HMD_FOVE_VR,
;;} VrDevice;
;;
;;#ifdef __cplusplus
;;extern "C" {            // Prevents name mangling of functions
;;#endif
;;
;;//------------------------------------------------------------------------------------
;;// Global Variables Definition
;;//------------------------------------------------------------------------------------
;;// It's lonely here...
;;
;;//------------------------------------------------------------------------------------
;;// Window and Graphics Device Functions (Module: core)
;;//------------------------------------------------------------------------------------
;;#if defined(PLATFORM_ANDROID)
;;RLAPI void InitWindow(int width, int height, void *state);        // Init Android Activity and OpenGL Graphics (struct android_app)
;;#elif defined(PLATFORM_DESKTOP) || defined(PLATFORM_RPI) || defined(PLATFORM_WEB)
;;RLAPI void InitWindow(int width, int height, const char *title);  // Initialize Window and OpenGL Graphics
;;#endif
(defcfun "InitWindow" :void
"Initialize Window and OpenGL Graphics"
         (width :int)
         (height :int)
         (title :string))

;;RLAPI void CloseWindow(void);                                     // Close Window and Terminate Context
(defcfun "CloseWindow" :void
"Close Window and Terminate Context"
 )

;;RLAPI bool WindowShouldClose(void);                               // Detect if KEY_ESCAPE pressed or Close icon pressed
(defcfun "WindowShouldClose" :boolean
"Detect if KEY_ESCAPE pressed or Close icon pressed"
 )

;;RLAPI bool IsWindowMinimized(void);                               // Detect if window has been minimized (or lost focus)
(defcfun "IsWindowMinimized" :boolean
"Detect if window has been minimized (or lost focus)"
 )

;;RLAPI void ToggleFullscreen(void);                                // Fullscreen toggle (only PLATFORM_DESKTOP)
(defcfun "ToggleFullscreen" :void
"Fullscreen toggle (only PLATFORM_DESKTOP)"
 )

;;RLAPI int GetScreenWidth(void);                                   // Get current screen width
(defcfun "GetScreenWidth" :int
"Get current screen width"
 )

;;RLAPI int GetScreenHeight(void);                                  // Get current screen height
(defcfun "GetScreenHeight" :int
"Get current screen height"
 )

;;#if !defined(PLATFORM_ANDROID)
;;RLAPI void ShowCursor(void);                                      // Shows cursor
(defcfun "ShowCursor" :void
"Shows cursor"
 )

;;RLAPI void HideCursor(void);                                      // Hides cursor
(defcfun "HideCursor" :void
 "Hides cursor"
 )

;;RLAPI bool IsCursorHidden(void);                                  // Returns true if cursor is not visible
(defcfun "IsCursorHidden":boolean
 "Returns true if cursor is not visible"
 )

;;RLAPI void EnableCursor(void);                                    // Enables cursor
(defcfun "EnableCursor" :void
 "Enables cursor"
 )

;;RLAPI void DisableCursor(void);                                   // Disables cursor
;;#endif
(defcfun "DisableCursor" :void
 "Disables cursor"
 )

;;RLAPI void ClearBackground(Color color);                          // Sets Background Color
(defcfun "ClearBackground" :void
 "Sets Background Color"
 (color (:struct %color)))
  
;;RLAPI void BeginDrawing(void);                                    // Setup drawing canvas to start drawing
(defcfun "BeginDrawing" :void
"Setup drawing canvas to start drawing"
 )

;;RLAPI void EndDrawing(void);                                      // End canvas drawing and Swap Buffers (Double Buffering)
(defcfun "EndDrawing" :void
"End canvas drawing and Swap Buffers (Double Buffering)"
 )

;;RLAPI void Begin2dMode(Camera2D camera);                          // Initialize 2D mode with custom camera
(defcfun "Begin2dMode" :void
"Initialize 2D mode with custom camera"
  (camera (:struct %camera2d)))
  
;;RLAPI void End2dMode(void);                                       // Ends 2D mode custom camera usage
(defcfun "End2dMode" :void
"Ends 2D mode custom camera usage"
 )

;;RLAPI void Begin3dMode(Camera camera);                            // Initializes 3D mode for drawing (Camera setup)
(defcfun "Begin3dMode" :void
"Initializes 3D mode for drawing (Camera setup)"
  (camera (:struct %camera)))
  
;;RLAPI void End3dMode(void);                                       // Ends 3D mode and returns to default 2D orthographic mode
(defcfun "End3dMode" :void
"Ends 3D mode and returns to default 2D orthographic mode"
 )

;;RLAPI void BeginTextureMode(RenderTexture2D target);              // Initializes render texture for drawing
(defcfun "BeginTextureMode" :void
"Initializes render texture for drawing"
  (target (:struct %render-texture2d)))
  
;;RLAPI void EndTextureMode(void);                                  // Ends drawing to render texture
(defcfun "EndTextureMode" :void
"Ends drawing to render texture"
 )

;;RLAPI Ray GetMouseRay(Vector2 mousePosition, Camera camera);      // Returns a ray trace from mouse position
(defcfun "GetMouseRay" (:struct %ray)
"Returns a ray trace from mouse position"
  (mouse-position (:struct %vector2))
  (camera (:struct %camera)))
  
;;RLAPI Vector2 GetWorldToScreen(Vector3 position, Camera camera);  // Returns the screen space position from a 3d world space position
(defcfun "GetWorldToScreen" (:struct %vector2)
"Returns the screen space position from a 3d world space position"
  (position (:struct %vector3))
  (camera (:struct %camera)))

;;RLAPI Matrix GetCameraMatrix(Camera camera);                      // Returns camera transform matrix (view matrix)
(defcfun "GetCameraMatrix" (:struct %matrix)
"Returns camera transform matrix (view matrix)"
  (camera (:struct %camera)))

;;RLAPI void SetTargetFPS(int fps);                                 // Set target FPS (maximum)
(defcfun "SetTargetFPS" :void
"Set target FPS (maximum)"
 (fps :int))
 
;;RLAPI float GetFPS(void);                                         // Returns current FPS
(defcfun "GetFPS" :float
"Returns current FPS"
 )

;;RLAPI float GetFrameTime(void);                                   // Returns time in seconds for one frame
(defcfun "GetFrameTime" :float
"Returns time in seconds for one frame"
 )

;;RLAPI Color GetColor(int hexValue);                               // Returns a Color struct from hexadecimal value
(defcfun "GetColor" (:struct %color)
"Returns a Color struct from hexadecimal value"
  (hex-value :int))

;;RLAPI int GetHexValue(Color color);                               // Returns hexadecimal value for a Color
(defcfun "GetHexValue" :int
"Returns hexadecimal value for a Color"
  (color (:struct %color)))

;;RLAPI float *ColorToFloat(Color color);                           // Converts Color to float array and normalizes
(defcfun "ColorToFloat" (:pointer :float)
"Converts Color to float array and normalizes"
  (color (:struct %color)))

;;RLAPI float *VectorToFloat(Vector3 vec);                          // Converts Vector3 to float array
(defcfun "VectorToFloat" (:pointer :float)
"Converts Vector3 to float array"
  (vec (:struct %vector3)))

;;RLAPI float *MatrixToFloat(Matrix mat);                           // Converts Matrix to float array
(defcfun "MatrixToFloat" (:pointer :float)
"Converts Matrix to float array"
  (mat (:struct %matrix)))

;RLAPI int GetRandomValue(int min, int max);                       // Returns a random value between min and max (both included)
(defcfun "GetRandomValue" :int
"Returns a random value between min and max (both included)"
  (min :int)
  (max :int))

;;RLAPI Color Fade(Color color, float alpha);                       // Color fade-in or fade-out, alpha goes from 0.0f to 1.0f
(defcfun "Fade" (:struct %color)
  (color (:struct %color))
  (alpha :float))

;;RLAPI void SetConfigFlags(char flags);                            // Setup some window configuration flags
(defcfun "SetConfigFlags" :void
  (flags :char))

;;RLAPI void ShowLogo(void);                                        // Activates raylib logo at startup (can be done with flags)
(defcfun "ShowLogo" :void)

;;RLAPI bool IsFileDropped(void);                                   // Check if a file have been dropped into window
(defcfun "IsFileDropped" :boolean)

;;RLAPI char **GetDroppedFiles(int *count);                         // Retrieve dropped files into window
(defcfun "GetFileDropped" (:pointer :string)
  (count :pointer :int))

;;RLAPI void ClearDroppedFiles(void);                               // Clear dropped files paths buffer
(defcfun "ClearDroppedFiles" :void)

;;RLAPI void StorageSaveValue(int position, int value);             // Storage save integer value (to defined position)
(defcfun "StorageSaveValue" :void
  (position :int)
  (value :int))

;;RLAPI int StorageLoadValue(int position);                         // Storage load integer value (from defined position)
(defcfun "StorageLoadValue" :int
  (position :int))

;;//------------------------------------------------------------------------------------
;;// Input Handling Functions (Module: core)
;;//------------------------------------------------------------------------------------
;;RLAPI bool IsKeyPressed(int key);                             // Detect if a key has been pressed once
(defcfun "IsKeyPressed":boolean
  (key :int))

;;RLAPI bool IsKeyDown(int key);                                // Detect if a key is being pressed
(defcfun "IsKeyDown":boolean
  (key :int))

;;RLAPI bool IsKeyReleased(int key);                            // Detect if a key has been released once
(defcfun "IsKeyReleased":boolean
  (key :int))

;;RLAPI bool IsKeyUp(int key);                                  // Detect if a key is NOT being pressed
(defcfun "IsKeyUp":boolean
  (key :int))

;;RLAPI int GetKeyPressed(void);                                // Get latest key pressed
(defcfun "GetKeyPressed" :int)

;;RLAPI void SetExitKey(int key);                               // Set a custom key to exit program (default is ESC)
(defcfun "SetExitKey" :void
  (key :int))

;;RLAPI bool IsGamepadAvailable(int gamepad);                   // Detect if a gamepad is available
(defcfun "IsGamepadAvailable":boolean
  (gamepad :int))

;;RLAPI bool IsGamepadName(int gamepad, const char *name);      // Check gamepad name (if available)
(defcfun "IsGamepadName":boolean
  (gamepad :int)
  (name :string))

;;RLAPI const char *GetGamepadName(int gamepad);                // Return gamepad internal name id
(defcfun "GetGamepadName" :string
  (gamepad :int))

;;RLAPI bool IsGamepadButtonPressed(int gamepad, int button);   // Detect if a gamepad button has been pressed once
(defcfun "IsGamepadButtonPressed":boolean
  (gamepad :int)
  (button :int))

;;RLAPI bool IsGamepadButtonDown(int gamepad, int button);      // Detect if a gamepad button is being pressed
(defcfun "IsGamepadButtonDown":boolean
  (gamepad :int)
  (button :int))

;;RLAPI bool IsGamepadButtonReleased(int gamepad, int button);  // Detect if a gamepad button has been released once
(defcfun "IsGamepadButtonReleased":boolean
  (gamepad :int)
  (button :int))

;;RLAPI bool IsGamepadButtonUp(int gamepad, int button);        // Detect if a gamepad button is NOT being pressed
(defcfun "IsGamepadButtonUp":boolean
  (gamepad :int)
  (button :int))

;;RLAPI int GetGamepadButtonPressed(void);                      // Get the last gamepad button pressed
(defcfun "GetGamepadButtonPressed" :int)

;;RLAPI int GetGamepadAxisCount(int gamepad);                   // Return gamepad axis count for a gamepad
(defcfun "GetGamepadAxisCount" :int
  (gamepad :int))

;;RLAPI float GetGamepadAxisMovement(int gamepad, int axis);    // Return axis movement value for a gamepad axis
(defcfun "GetGamepadAxisMovement" :float
  (gamepad :int)
  (axis :int))

;;RLAPI bool IsMouseButtonPressed(int button);                  // Detect if a mouse button has been pressed once
(defcfun "IsMouseButtonPressed":boolean
  (button :int))

;;RLAPI bool IsMouseButtonDown(int button);                     // Detect if a mouse button is being pressed
(defcfun "IsMouseButtonDown":boolean
  (button :int))

;;RLAPI bool IsMouseButtonReleased(int button);                 // Detect if a mouse button has been released once
(defcfun "IsMouseButtonReleased":boolean
  (button :int))

;;RLAPI bool IsMouseButtonUp(int button);                       // Detect if a mouse button is NOT being pressed
(defcfun "IsMouseButtonUp":boolean
  (button :int))

;;RLAPI int GetMouseX(void);                                    // Returns mouse position X
(defcfun "GetMouseX" :int)

;;RLAPI int GetMouseY(void);                                    // Returns mouse position Y
(defcfun "GetMouseY" :int)

;;RLAPI Vector2 GetMousePosition(void);                         // Returns mouse position XY
(defcfun "GetMousePosition" (:struct %vector2))

;;RLAPI void SetMousePosition(Vector2 position);                // Set mouse position XY
(defcfun "SetMousePosition" :void
  (position (:struct %vector2)))

;;RLAPI int GetMouseWheelMove(void);                            // Returns mouse wheel movement Y
(defcfun "GetMouseWheelMove" :int)

;;RLAPI int GetTouchX(void);                                    // Returns touch position X for touch point 0 (relative to screen size)
(defcfun "GetTouchX" :int)

;;RLAPI int GetTouchY(void);                                    // Returns touch position Y for touch point 0 (relative to screen size)
(defcfun "GetTouchY" :int)

;;RLAPI Vector2 GetTouchPosition(int index);                    // Returns touch position XY for a touch point index (relative to screen size)
(defcfun "GetTouchPosition" (:struct %vector2)
 (index :int))

;;//------------------------------------------------------------------------------------
;;// Gestures and Touch Handling Functions (Module: gestures)
;;//------------------------------------------------------------------------------------
;;RLAPI void SetGesturesEnabled(unsigned int gestureFlags);     // Enable a set of gestures using flags
(defcfun "SetGesturesEnabled" :void
 (gestureFlags :unsigned-int))

;;RLAPI bool IsGestureDetected(int gesture);                    // Check if a gesture have been detected
(defcfun "IsGestureDetected":boolean
 (gesture :int))

;;RLAPI int GetGestureDetected(void);                           // Get latest detected gesture
(defcfun "GetGestureDetected" :int)

;;RLAPI int GetTouchPointsCount(void);                          // Get touch points count
(defcfun "GetTouchPointsCount" :int)

;;RLAPI float GetGestureHoldDuration(void);                     // Get gesture hold time in milliseconds
(defcfun "GetGestureHoldDuration" :float)

;;RLAPI Vector2 GetGestureDragVector(void);                     // Get gesture drag vector
(defcfun "GetGestureDragVector" (:struct %vector2))

;;RLAPI float GetGestureDragAngle(void);                        // Get gesture drag angle
(defcfun "GetGestureDragAngle" :float)

;;RLAPI Vector2 GetGesturePinchVector(void);                    // Get gesture pinch delta
(defcfun "GetGesturePinchVector" (:struct %vector2))

;;RLAPI float GetGesturePinchAngle(void);                       // Get gesture pinch angle
(defcfun "GetGesturePinchAngle" :float)

;;//------------------------------------------------------------------------------------
;;// Camera System Functions (Module: camera)
;;//------------------------------------------------------------------------------------
;;RLAPI void SetCameraMode(Camera camera, int mode);                // Set camera mode (multiple camera modes available)
(defcfun "SetCameraMode" :void
 (camera (:struct %camera))
 (mode :int))

;;RLAPI void UpdateCamera(Camera *camera);                          // Update camera position for selected mode
(defcfun "UpdateCamera" :void
 (camera (:pointer (:struct %camera))))

;;RLAPI void SetCameraPanControl(int panKey);                       // Set camera pan key to combine with mouse movement (free camera)
(defcfun "SetCameraPanControl" :void
 (pan-key :int))

;;RLAPI void SetCameraAltControl(int altKey);                       // Set camera alt key to combine with mouse movement (free camera)
(defcfun "SetCameraAltControl" :void
 (alt-key :int))

;;RLAPI void SetCameraSmoothZoomControl(int szKey);                 // Set camera smooth zoom key to combine with mouse (free camera)
(defcfun "SetCameraSmoothZoomControl" :void
 (sz-key :int))

;;RLAPI void SetCameraMoveControls(int frontKey, int backKey,
;;                                 int rightKey, int leftKey,
;;                                 int upKey, int downKey);         // Set camera move controls (1st person and 3rd person cameras)
(defcfun "SetCameraMoveControls" :void
 (front-key :int)
 (back-key :int)
 (right-key :int)
 (left-key :int)
 (up-key :int)
 (down-key :int))

;;//------------------------------------------------------------------------------------
;;// Basic Shapes Drawing Functions (Module: shapes)
;;//------------------------------------------------------------------------------------
;;RLAPI void DrawPixel(int posX, int posY, Color color);                                                   // Draw a pixel
(defcfun "DrawPixel" :void
 (pos-x :int)
 (pos-y :int)
 (color (:struct %color)))

;;RLAPI void DrawPixelV(Vector2 position, Color color);                                                    // Draw a pixel (Vector version)
(defcfun "DrawPixelV" :void
 (position (:struct %vector2))
 (color (:struct %color)))

;;RLAPI void DrawLine(int startPosX, int startPosY, int endPosX, int endPosY, Color color);                // Draw a line
(defcfun "DrawLine" :void
 (start-pos-x :int)
 (start-pos-y :int)
 (end-pos-x :int)
 (end-pos-y :int)
 (color (:struct %color)))

;;RLAPI void DrawLineV(Vector2 startPos, Vector2 endPos, Color color);                                     // Draw a line (Vector version)
(defcfun "DrawLineV" :void
 (start-pos (:struct %vector2))
 (end-pos (:struct %vector2))
 (color (:struct %color)))

;;RLAPI void DrawCircle(int centerX, int centerY, float radius, Color color);                              // Draw a color-filled circle
(defcfun "DrawCircle" :void
 (center-x :int)
 (center-y :int)
 (radius :float)
 (color (:struct %color)))

;;RLAPI void DrawCircleGradient(int centerX, int centerY, float radius, Color color1, Color color2);       // Draw a gradient-filled circle
(defcfun "DrawCircleGradient" :void
 (center-x :int)
 (center-y :int)
 (radius :float)
 (color1 (:struct %color))
 (color2 (:struct %color)))

;;RLAPI void DrawCircleV(Vector2 center, float radius, Color color);                                       // Draw a color-filled circle (Vector version)
(defcfun "DrawCircleV" :void
 (center (:struct %vector2))
 (radius :float)
 (color (:struct %color)))

;;RLAPI void DrawCircleLines(int centerX, int centerY, float radius, Color color);                         // Draw circle outline
(defcfun "DrawCircleLines" :void
 (center-x :int)
 (center-y :int)
 (radius :float)
 (color (:struct %color)))

;;RLAPI void DrawRectangle(int posX, int posY, int width, int height, Color color);                        // Draw a color-filled rectangle
(defcfun "DrawRectangle" :void
 (pos-x :int)
 (pos-y :int)
 (width :int)
 (height :int)
 (color (:struct %color)))

;;RLAPI void DrawRectangleRec(Rectangle rec, Color color);                                                 // Draw a color-filled rectangle
(defcfun "DrawRectangleRec" :void
 (rec (:struct %rectangle))
 (color (:struct %color)))

;;RLAPI void DrawRectangleGradient(int posX, int posY, int width, int height, Color color1, Color color2); // Draw a gradient-filled rectangle
(defcfun "DrawRectangleGradient" :void
 (pos-x :int)
 (pos-y :int)
 (width :int)
 (height :int)
 (color1 (:struct %color))
 (color2 (:struct %color)))

;;RLAPI void DrawRectangleV(Vector2 position, Vector2 size, Color color);                                  // Draw a color-filled rectangle (Vector version)
(defcfun "DrawRectangleV" :void
 (position (:struct %vector2))
 (size (:struct %vector2))
 (color (:struct %color)))

;;RLAPI void DrawRectangleLines(int posX, int posY, int width, int height, Color color);                   // Draw rectangle outline
(defcfun "DrawRectangleLines" :void
 (pos-x :int)
 (pos-y :int)
 (width :int)
 (height :int)
 (color (:struct %color)))

;;RLAPI void DrawTriangle(Vector2 v1, Vector2 v2, Vector2 v3, Color color);                                // Draw a color-filled triangle
(defcfun "DrawTriangle" :void
 (v1 (:struct %vector2))
 (v2 (:struct %vector2))
 (v3 (:struct %vector2))
 (color (:struct %color)))

;;RLAPI void DrawTriangleLines(Vector2 v1, Vector2 v2, Vector2 v3, Color color);                           // Draw triangle outline
(defcfun "DrawTriangleLines" :void
 (v1 (:struct %vector2))
 (v2 (:struct %vector2))
 (v3 (:struct %vector2))
 (color (:struct %color)))

;;RLAPI void DrawPoly(Vector2 center, int sides, float radius, float rotation, Color color);               // Draw a regular polygon (Vector version)
(defcfun "DrawPoly" :void
 (center (:struct %vector2))
 (sides :int)
 (radius :float)
 (rotation :float)
 (color (:struct %color)))

;;RLAPI void DrawPolyEx(Vector2 *points, int numPoints, Color color);                                      // Draw a closed polygon defined by points
(defcfun "DrawPolyEx" :void
 (points (:pointer (:struct %vector2)))
 (num-points :int)
 (color (:struct %color)))

;;RLAPI void DrawPolyExLines(Vector2 *points, int numPoints, Color color);                                 // Draw polygon lines
(defcfun "DrawPolyExLines" :void
 (points (:pointer (:struct %vector2)))
 (num-points :int)
 (color (:struct %color)))

;;RLAPI bool CheckCollisionRecs(Rectangle rec1, Rectangle rec2);                                           // Check collision between two rectangles
(defcfun "CheckCollisionRecs" bool
 (rec1 (:struct %rectangle))
 (rec2 (:struct %rectangle)))

;;RLAPI bool CheckCollisionCircles(Vector2 center1, float radius1, Vector2 center2, float radius2);        // Check collision between two circles
(defcfun "CheckCollisionCircles" bool
 (center1 (:struct %vector2))
 (radius1 :float)
 (center2 (:struct %vector2))
 (radius2 :float))

;;RLAPI bool CheckCollisionCircleRec(Vector2 center, float radius, Rectangle rec);                         // Check collision between circle and rectangle
(defcfun "CheckCollisionCircleRec" bool
 (center (:struct %vector2))
 (radius :float)
 (rec (:struct %rectangle)))

;;RLAPI Rectangle GetCollisionRec(Rectangle rec1, Rectangle rec2);                                         // Get collision rectangle for two rectangles collision
(defcfun "GetCollisionRec" (:struct %rectangle)
 (rec1 (:struct %rectangle))
 (rec2 (:struct %rectangle)))

;;RLAPI bool CheckCollisionPointRec(Vector2 point, Rectangle rec);                                         // Check if point is inside rectangle
(defcfun "CheckCollisionPointRec" bool
 (point (:struct %vector2))
 (rec (:struct %rectangle)))

;;RLAPI bool CheckCollisionPointCircle(Vector2 point, Vector2 center, float radius);                       // Check if point is inside circle
(defcfun "CheckCollisionPointCircle" bool
 (point (:struct %vector2))
 (center (:struct %vector2))
 (radius :float))

;;RLAPI bool CheckCollisionPointTriangle(Vector2 point, Vector2 p1, Vector2 p2, Vector2 p3);               // Check if point is inside a triangle
(defcfun "CheckCollisionPointTriangle" bool
 (point (:struct %vector2))
 (p1 (:struct %vector2))
 (p2 (:struct %vector2))
 (p3 (:struct %vector2)))

;;//------------------------------------------------------------------------------------
;;// Texture Loading and Drawing Functions (Module: textures)
;;//------------------------------------------------------------------------------------
;;RLAPI Image LoadImage(const char *fileName);                                                             // Load an image into CPU memory (RAM)
(defcfun "LoadImage" (:struct %image)
 (file-name :string))

;;RLAPI Image LoadImageEx(Color *pixels, int width, int height);                                           // Load image data from Color array data (RGBA - 32bit)
(defcfun "LoadImageEx" (:struct %image)
 (pixels (:pointer (:struct %color)))
 (width :int)
 (height :int))

;;RLAPI Image LoadImageRaw(const char *fileName, int width, int height, int format, int headerSize);       // Load image data from RAW file
(defcfun "LoadImageRaw" (:struct %image)
 (file-name :string)
 (width :int)
 (height :int)
 (format :int)
 (header-size :int))

;;RLAPI Image LoadImageFromRES(const char *rresName, int resId);                                           // Load an image from rRES file (raylib Resource)
(defcfun "LoadImageFromRES" (:struct %image)
 (rres-name :string)
 (res-id :int))

;;RLAPI Texture2D LoadTexture(const char *fileName);                                                       // Load an image as texture into GPU memory
(defcfun "LoadTexture" (:struct %texture2d)
 (file-name :string))

;;RLAPI Texture2D LoadTextureEx(void *data, int width, int height, int textureFormat);                     // Load a texture from raw data into GPU memory
(defcfun "LoadTextureEx" (:struct %texture2d)
 (data :pointer)
 (width :int)
 (height :int)
 (texture-format :int))

;;RLAPI Texture2D LoadTextureFromRES(const char *rresName, int resId);                                     // Load an image as texture from rRES file (raylib Resource)
(defcfun "LoadTextureFromRES" (:struct %texture2d)
 (rres-name :string)
 (res-id :int))

;;RLAPI Texture2D LoadTextureFromImage(Image image);                                                       // Load a texture from image data
(defcfun "LoadTextureFromImage" (:struct %texture2d)
 (image (:struct %image)))

;;RLAPI RenderTexture2D LoadRenderTexture(int width, int height);                                          // Load a texture to be used for rendering
(defcfun "LoadRenderTexture" (:struct %render-texture2d)
 (width :int)
 (height :int))

;;RLAPI void UnloadImage(Image image);                                                                     // Unload image from CPU memory (RAM)
(defcfun "UnloadImage" :void
 (image (:struct %image)))

;;RLAPI void UnloadTexture(Texture2D texture);                                                             // Unload texture from GPU memory
(defcfun "UnloadTexture" :void
 (texture (:struct %texture2d)))

;;RLAPI void UnloadRenderTexture(RenderTexture2D target);                                                  // Unload render texture from GPU memory
(defcfun "UnloadRenderTexture" :void
 (target (:struct %render-texture2d)))

;;RLAPI Color *GetImageData(Image image);                                                                  // Get pixel data from image as a Color struct array
(defcfun "GetImageData" (:pointer (:struct %color))
 (image (:struct %image)))

;;RLAPI Image GetTextureData(Texture2D texture);                                                           // Get pixel data from GPU texture and return an Image
(defcfun "GetTextureData" (:struct %image)
 (texture (:struct %texture2d)))

;;RLAPI void UpdateTexture(Texture2D texture, void *pixels);                                               // Update GPU texture with new data
(defcfun "UpdateTexture" :void
 (texture (:struct %texture2d))
 (pixels :pointer))

;;RLAPI void ImageToPOT(Image *image, Color fillColor);                                                    // Convert image to POT (power-of-two)
(defcfun "ImageToPOT" :void
 (image (:pointer (:struct %image)))
 (fill-color (:struct %color)))

;;RLAPI void ImageFormat(Image *image, int newFormat);                                                     // Convert image data to desired format
(defcfun "ImageFormat" :void
 (image (:pointer (:struct %image)))
 (new-format :int))

;;RLAPI void ImageAlphaMask(Image *image, Image alphaMask);                                                // Apply alpha mask to image
(defcfun "ImageAlphaMask" :void
 (image (:pointer (:struct %image)))
 (alpha-mask (:struct %image)))

;;RLAPI void ImageDither(Image *image, int rBpp, int gBpp, int bBpp, int aBpp);                            // Dither image data to 16bpp or lower (Floyd-Steinberg dithering)
(defcfun "ImageDither" :void
 (image (:pointer (:struct %image)))
 (r-bpp :int)
 (g-bpp :int)
 (b-bpp :int)
 (a-bpp :int))

;;RLAPI Image ImageCopy(Image image);                                                                      // Create an image duplicate (useful for transformations)
(defcfun "ImageCopy" (:struct %image)
 (image (:struct %image)))

;;RLAPI void ImageCrop(Image *image, Rectangle crop);                                                      // Crop an image to a defined rectangle
(defcfun "ImageCrop" :void
 (image (:pointer (:struct %image)))
 (crop (:struct %rectangle)))

;;RLAPI void ImageResize(Image *image, int newWidth, int newHeight);                                       // Resize and image (bilinear filtering)
(defcfun "ImageResize" :void
 (image (:pointer (:struct %image)))
 (new-width :int)
 (new-height :int))

;;RLAPI void ImageResizeNN(Image *image,int newWidth,int newHeight);                                       // Resize and image (Nearest-Neighbor scaling algorithm)
(defcfun "ImageResizeNN" :void
 (image (:pointer (:struct %image)))
 (new-width :int)
 (new-height :int))

;;RLAPI Image ImageText(const char *text, int fontSize, Color color);                                      // Create an image from text (default font)
(defcfun "ImageText" (:struct %image)
 (text :string)
 (font-size :int)
 (color (:struct %color)))

;;RLAPI Image ImageTextEx(SpriteFont font, const char *text, float fontSize, int spacing, Color tint);     // Create an image from text (custom sprite font)
(defcfun "ImageTextEx" (:struct %image)
 (sprite-font (:struct %sprite-font))
 (text :string)
 (font-size :float)
 (spacing :int)
 (tint (:struct %color)))

;;RLAPI void ImageDraw(Image *dst, Image src, Rectangle srcRec, Rectangle dstRec);                         // Draw a source image within a destination image
(defcfun "ImageDraw" :void
 (dst (:pointer (:struct %image)))
 (src (:struct %image))
 (src-rec (:struct %rectangle))
 (dst-rec (:struct %rectangle)))

;;RLAPI void ImageDrawText(Image *dst, Vector2 position, const char *text, int fontSize, Color color);     // Draw text (default font) within an image (destination)
(defcfun "ImageDrawText" :void
 (dst (:pointer (:struct %image)))
 (position (:struct %vector2))
 (text :string)
 (font-size :int)
 (color (:struct %color)))

;;RLAPI void ImageDrawTextEx(Image *dst, Vector2 position, SpriteFont font, const char *text, float fontSize, int spacing, Color color); // Draw text (custom sprite font) within an image (destination)
(defcfun "ImageDrawTextEx" :void
 (dst (:pointer (:struct %image)))
 (position (:struct %vector2))
 (sprite-font (:struct %sprite-font))
 (text :string)
 (font-size :int)
 (spacing :int)
 (color (:struct %color)))

;;RLAPI void ImageFlipVertical(Image *image);                                                              // Flip image vertically
(defcfun "ImageFlipVertical" :void
 (image (:pointer (:struct %image))))

;;RLAPI void ImageFlipHorizontal(Image *image);                                                            // Flip image horizontally
(defcfun "ImageFlipHorizontal" :void
 (image (:pointer (:struct %image))))

;;RLAPI void ImageColorTint(Image *image, Color color);                                                    // Modify image color: tint
(defcfun "ImageColorTint" :void
 (image (:pointer (:struct %image)))
 (color (:struct %color)))

;;RLAPI void ImageColorInvert(Image *image);                                                               // Modify image color: invert
(defcfun "ImageColorInvert" :void
 (image (:pointer (:struct %image))))

;;RLAPI void ImageColorGrayscale(Image *image);                                                            // Modify image color: grayscale
(defcfun "ImageColorGrayscale" :void
 (image (:pointer (:struct %image))))

;;RLAPI void ImageColorContrast(Image *image, float contrast);                                             // Modify image color: contrast (-100 to 100)
(defcfun "ImageColorContrast" :void
 (image (:pointer (:struct %image)))
 (contrast :float))

;;RLAPI void ImageColorBrightness(Image *image, int brightness);                                           // Modify image color: brightness (-255 to 255)
(defcfun "ImageColorBrightness" :void
 (image (:pointer (:struct %image)))
 (brightness :int))

;;RLAPI void GenTextureMipmaps(Texture2D *texture);                                                        // Generate GPU mipmaps for a texture
(defcfun "GenTextureMipmaps" :void
 (texture (:pointer (:struct %texture2d))))

;;RLAPI void SetTextureFilter(Texture2D texture, int filterMode);                                          // Set texture scaling filter mode
(defcfun "SetTextureFilter" :void
 (texture (:struct %texture2d))
 (filter-mode :int))

;;RLAPI void SetTextureWrap(Texture2D texture, int wrapMode);                                              // Set texture wrapping mode
(defcfun "SetTextureWrap" :void
 (texture (:struct %texture2d))
 (wrap-mode :int))

;;RLAPI void DrawTexture(Texture2D texture, int posX, int posY, Color tint);                               // Draw a Texture2D
(defcfun "DrawTexture" :void
 (texture (:struct %texture2d))
 (pos-x :int)
 (pos-y :int)
 (tint (:struct %color)))

;;RLAPI void DrawTextureV(Texture2D texture, Vector2 position, Color tint);                                // Draw a Texture2D with position defined as Vector2
(defcfun "DrawTextureV" :void
 (texture (:struct %texture2d))
 (position (:struct %vector2))
 (tint (:struct %color)))

;;RLAPI void DrawTextureEx(Texture2D texture, Vector2 position, float rotation, float scale, Color tint);  // Draw a Texture2D with extended parameters
(defcfun "DrawTextureEx" :void
 (texture (:struct %texture2d))
 (position (:struct %vector2))
 (rotation :float)
 (scale :float)
 (tint (:struct %color)))

;;RLAPI void DrawTextureRec(Texture2D texture, Rectangle sourceRec, Vector2 position, Color tint);         // Draw a part of a texture defined by a rectangle
(defcfun "DrawTextureRec" :void
 (texture (:struct %texture2d))
 (source-rec (:struct %rectangle))
 (position (:struct %vector2))
 (tint (:struct %color)))

;;RLAPI void DrawTexturePro(Texture2D texture, Rectangle sourceRec, Rectangle destRec, Vector2 origin,     // Draw a part of a texture defined by a rectangle with 'pro' parameters
;;                    float rotation, Color tint);
(defcfun "DrawTexturePro" :void
 (texture (:struct %texture2d))
 (source-rec (:struct %rectangle))
 (dst-rec (:struct %rectangle))
 (origin (:struct %vector2))
 (rotation :float)
 (tint (:struct %color)))

;;//------------------------------------------------------------------------------------
;;// Font Loading and Text Drawing Functions (Module: text)
;;//------------------------------------------------------------------------------------
;;RLAPI SpriteFont GetDefaultFont(void);                                                                   // Get the default SpriteFont
(defcfun "GetDefaultFont" (:struct %sprite-font))

;;RLAPI SpriteFont LoadSpriteFont(const char *fileName);                                                   // Load a SpriteFont image into GPU memory
(defcfun "LoadSpriteFont" (:struct %sprite-font)
 (file-name :string))

;;RLAPI SpriteFont LoadSpriteFontTTF(const char *fileName, int fontSize, int numChars, int *fontChars);    // Load a SpriteFont from TTF font with parameters
(defcfun "LoadSpriteFontTTF" (:struct %sprite-font)
 (file-name :string)
 (font-size :int)
 (num-chars :int)
 (font-chars (:pointer :int)))

;;RLAPI void UnloadSpriteFont(SpriteFont spriteFont);                                                      // Unload SpriteFont from GPU memory
(defcfun "UnloadSpriteFont" :void
 (sprite-font (:struct %sprite-font)))

;;RLAPI void DrawText(const char *text, int posX, int posY, int fontSize, Color color);                    // Draw text (using default font)
(defcfun "DrawText" :void
 (text :string)
 (pos-x :int)
 (pos-y :int)
 (font-size :int)
 (color (:struct %color)))

;;RLAPI void DrawTextEx(SpriteFont spriteFont, const char* text, Vector2 position,                         // Draw text using SpriteFont and additional parameters
;;                float fontSize, int spacing, Color tint);
(defcfun "DrawTextEx" :void
 (sprite-font (:struct %sprite-font))
 (text :string)
 (position (:struct %vector2))
 (font-size :float)
 (spacing :int)
 (tint (:struct %color)))

;;RLAPI int MeasureText(const char *text, int fontSize);                                                   // Measure string width for default font
(defcfun "MeasureText" :int
 (text :string)
 (font-size :float))

;;RLAPI Vector2 MeasureTextEx(SpriteFont spriteFont, const char *text, float fontSize, int spacing);       // Measure string size for SpriteFont
(defcfun "MeasureTextEx" (:struct %vector2)
 (text :string)
 (font-size :float))

;;RLAPI void DrawFPS(int posX, int posY);                                                                  // Shows current FPS on top-left corner
(defcfun "DrawFPS" :void
 (pos-x :int)
 (pos-y :int))

;;RLAPI const char *FormatText(const char *text, ...);                                                     // Formatting of text with variables to 'embed'
(defcfun "FormatText" :string
 (text :string)
 &rest)

;;RLAPI const char *SubText(const char *text, int position, int length);                                   // Get a piece of a text string
(defcfun "SubText" :string
 (text :string)
 (position :int)
 (length :int))

;;//------------------------------------------------------------------------------------
;;// Basic 3d Shapes Drawing Functions (Module: models)
;;//------------------------------------------------------------------------------------
;;RLAPI void DrawLine3D(Vector3 startPos, Vector3 endPos, Color color);                                    // Draw a line in 3D world space
(defcfun "DrawLine3D" :void
 (start-pos (:struct %vector3))
 (end-pos (:struct %vector3))
 (color (:struct %color)))

;;RLAPI void DrawCircle3D(Vector3 center, float radius, Vector3 rotationAxis, float rotationAngle, Color color); // Draw a circle in 3D world space
(defcfun "DrawCircle3D" :void
 (position (:struct %vector3))
 (radius :float)
 (rotation-axis (:struct %vector3))
 (rotation-angle :float)
 (color (:struct %color)))

;;RLAPI void DrawCube(Vector3 position, float width, float height, float length, Color color);             // Draw cube
(defcfun "DrawCube" :void
 (position (:struct %vector3))
 (width :float)
 (height :float)
 (length :float)
 (color (:struct %color)))

;;RLAPI void DrawCubeV(Vector3 position, Vector3 size, Color color);                                       // Draw cube (Vector version)
(defcfun "DrawCubeV" :void
 (position (:struct %vector3))
 (size (:struct %vector3))
 (color (:struct %color)))

;;RLAPI void DrawCubeWires(Vector3 position, float width, float height, float length, Color color);        // Draw cube wires
(defcfun "DrawCubeWires" :void
 (position (:struct %vector3))
 (width :float)
 (height :float)
 (length :float)
 (color (:struct %color)))

;;RLAPI void DrawCubeTexture(Texture2D texture, Vector3 position, float width, float height, float length, Color color); // Draw cube textured
(defcfun "DrawCubeTexture" :void
 (texture (:struct %texture2d))
 (position (:struct %vector3))
 (width :float)
 (height :float)
 (length :float)
 (color (:struct %color)))

;;RLAPI void DrawSphere(Vector3 centerPos, float radius, Color color);                                     // Draw sphere
(defcfun "DrawSphere" :void
 (center-pos (:struct %vector3))
 (radius :float)
 (color (:struct %color)))

;;RLAPI void DrawSphereEx(Vector3 centerPos, float radius, int rings, int slices, Color color);            // Draw sphere with extended parameters
(defcfun "DrawSphereEx" :void
 (center-pos (:struct %vector3))
 (radius :float)
 (rings :int)
 (slices :int)
 (color (:struct %color)))

;;RLAPI void DrawSphereWires(Vector3 centerPos, float radius, int rings, int slices, Color color);         // Draw sphere wires
(defcfun "DrawSphereWires" :void
 (center-pos (:struct %vector3))
 (radius :float)
 (rings :int)
 (slices :int)
 (color (:struct %color)))

;;RLAPI void DrawCylinder(Vector3 position, float radiusTop, float radiusBottom, float height, int slices, Color color); // Draw a cylinder/cone
(defcfun "DrawCylinder" :void
 (position (:struct %vector3))
 (radius-top :float)
 (radius-bottom :float)
 (height :float)
 (slices :int)
 (color (:struct %color)))

;;RLAPI void DrawCylinderWires(Vector3 position, float radiusTop, float radiusBottom, float height, int slices, Color color); // Draw a cylinder/cone wires
(defcfun "DrawCylinderWires" :void
 (position (:struct %vector3))
 (radius-top :float)
 (radius-bottom :float)
 (height :float)
 (slices :int)
 (color (:struct %color)))

;;RLAPI void DrawPlane(Vector3 centerPos, Vector2 size, Color color);                                      // Draw a plane XZ
(defcfun "DrawPlance" :void
 (current-pos (:struct %vector3))
 (size  (:struct %vector2))
 (color (:struct %color)))

;;RLAPI void DrawRay(Ray ray, Color color);                                                                // Draw a ray line
(defcfun "DrawRay" :void
 (ray (:struct %ray))
 (color (:struct %color)))

;;RLAPI void DrawGrid(int slices, float spacing);                                                          // Draw a grid (centered at (0, 0, 0))
(defcfun "DrawGrid" :void
 (slices :int)
 (spacing :float))

;;RLAPI void DrawGizmo(Vector3 position);                                                                  // Draw simple gizmo
(defcfun "DrawGizmo" :void
 (position (:struct %vector3)))

;;RLAPI void DrawLight(Light light);                                                                       // Draw light in 3D world
(defcfun "DrawLight" :void
 (light :pointer))

;;//DrawTorus(), DrawTeapot() could be useful?
;;
;;//------------------------------------------------------------------------------------
;;// Model 3d Loading and Drawing Functions (Module: models)
;;//------------------------------------------------------------------------------------
;;RLAPI Model LoadModel(const char *fileName);                          // Load a 3d model (.OBJ)
(defcfun "LoadModel" (:struct %model)
 (file-name :string))

;;RLAPI Model LoadModelEx(Mesh data, bool dynamic);                     // Load a 3d model (from mesh data)
(defcfun "LoadModelEx" (:struct %model)
 (data (:struct %mesh))
 (bynamic bool))

;;RLAPI Model LoadModelFromRES(const char *rresName, int resId);        // Load a 3d model from rRES file (raylib Resource)
(defcfun "LoadModelFromRES" (:struct %model)
 (rres-name :string)
 (res-id :int))

;;RLAPI Model LoadHeightmap(Image heightmap, Vector3 size);             // Load a heightmap image as a 3d model
(defcfun "LoadHeightmap" (:struct %model)
 (heightmap (:struct %image))
 (size (:struct %vector3)))

;;RLAPI Model LoadCubicmap(Image cubicmap);                             // Load a map image as a 3d model (cubes based)
(defcfun "LoadCubicmap" (:struct %model)
 (cubicmap (:struct %image)))

;;RLAPI void UnloadModel(Model model);                                  // Unload 3d model from memory
(defcfun "UnloadModel" :void
 (model (:struct %model)))

;;RLAPI Material LoadMaterial(const char *fileName);                    // Load material data (.MTL)
(defcfun "LoadMaterial" (:struct %material)
 (file-name :string))

;;RLAPI Material LoadDefaultMaterial(void);                             // Load default material (uses default models shader)
(defcfun "LoadDefaultMaterialardMaterial" (:struct %material))

;;RLAPI Material LoadStandardMaterial(void);                            // Load standard material (uses material attributes and lighting shader)
(defcfun "LoadStandardMaterial" (:struct %material))

;;RLAPI void UnloadMaterial(Material material);                         // Unload material textures from VRAM
(defcfun "UnloadMaterial" :void
  (material (:struct %material)))

;;RLAPI void DrawModel(Model model, Vector3 position, float scale, Color tint);                            // Draw a model (with texture if set)
(defcfun "DrawModel" :void
  (model (:struct %model))
  (position (:struct %vector3))
  (scale (:struct %vector3))
  (tint (:struct %color)))

;;RLAPI void DrawModelEx(Model model, Vector3 position, Vector3 rotationAxis, float rotationAngle, Vector3 scale, Color tint);      // Draw a model with extended parameters
(defcfun "DrawModelEx" :void
  (model (:struct %model))
  (position (:struct %vector3))
  (rotation-axis (:struct %vector3))
  (rotation-angle :float)
  (scale (:struct %vector3))
  (tint (:struct %color)))

;;RLAPI void DrawModelWires(Model model, Vector3 position, float scale, Color tint);                      // Draw a model wires (with texture if set)
(defcfun "DrawModelWires" :void
  (model (:struct %model))
  (position (:struct %vector3))
  (scale (:struct %vector3))
  (tint (:struct %color)))

;;RLAPI void DrawModelWiresEx(Model model, Vector3 position, Vector3 rotationAxis, float rotationAngle, Vector3 scale, Color tint); // Draw a model wires (with texture if set) with extended parameters
(defcfun "DrawModelWiresEx" :void
  (model (:struct %model))
  (position (:struct %vector3))
  (rotation-axis (:struct %vector3))
  (rotation-angle :float)
  (scale (:struct %vector3))
  (tint (:struct %color)))

;;RLAPI void DrawBoundingBox(BoundingBox box, Color color);                                                // Draw bounding box (wires)
(defcfun "DrawBoundingBox" :void
  (box (:struct %bounding-box))
  (color (:struct %color)))

;;RLAPI void DrawBillboard(Camera camera, Texture2D texture, Vector3 center, float size, Color tint);                         // Draw a billboard texture
(defcfun "DrawBillboard" :void
  (camera (:struct %camera))
  (texture (:struct %texture2d))
  (center (:struct %vector3))
  (size :float)
  (tint (:struct %color)))

;;RLAPI void DrawBillboardRec(Camera camera, Texture2D texture, Rectangle sourceRec, Vector3 center, float size, Color tint); // Draw a billboard texture defined by sourceRec
(defcfun "DrawBillboardRec" :void
  (camera (:struct %camera))
  (texture (:struct %texture2d))
  (source-rec (:struct %rectangle))
  (center (:struct %vector3))
  (size :float)
  (tint (:struct %color)))

;;
;;RLAPI BoundingBox CalculateBoundingBox(Mesh mesh);                                                                    // Calculate mesh bounding box limits
(defcfun "CalculateBoundingBox" (:struct %bounding-box)
  (mesh (:struct %mesh)))

;;RLAPI bool CheckCollisionSpheres(Vector3 centerA, float radiusA, Vector3 centerB, float radiusB);                     // Detect collision between two spheres
(defcfun "CheckCollisionSpheres" bool
  (center-a (:struct %vector3))
  (radius-a :float)
  (center-b (:struct %vector3))
  (radius-b :float))

;;RLAPI bool CheckCollisionBoxes(BoundingBox box1, BoundingBox box2);                                                   // Detect collision between two bounding boxes
(defcfun "CheckCollisionBoxes" bool
  (box1 (:struct %bounding-box))
  (box2 (:struct %bounding-box)))

;;RLAPI bool CheckCollisionBoxSphere(BoundingBox box, Vector3 centerSphere, float radiusSphere);                        // Detect collision between box and sphere
(defcfun "CheckCollisionBoxSphere" bool
  (box (:struct %bounding-box))
  (center-sphere (:struct %vector3))
  (sphere-radius :float))

;;RLAPI bool CheckCollisionRaySphere(Ray ray, Vector3 spherePosition, float sphereRadius);                              // Detect collision between ray and sphere
(defcfun "CheckCollisionRaySphere" bool
  (ray (:struct %ray))
  (sphere-position (:struct %vector3))
  (sphere-radius :float))

;;RLAPI bool CheckCollisionRaySphereEx(Ray ray, Vector3 spherePosition, float sphereRadius, Vector3 *collisionPoint);   // Detect collision between ray and sphere with extended parameters and collision point detection
(defcfun "CheckCollisionRaySphereEx" bool
  (ray (:struct %ray))
  (sphere-position (:struct %vector3))
  (sphere-radius :float)
  (collision-point (:pointer (:struct %vector3))))

;;RLAPI bool CheckCollisionRayBox(Ray ray, BoundingBox box);                                                            // Detect collision between ray and box
(defcfun "CheckCollisionRayBox" bool
  (ray (:struct %ray))
  (box (:struct %bounding-box)))

;;//------------------------------------------------------------------------------------
;;// Shaders System Functions (Module: rlgl)
;;// NOTE: This functions are useless when using OpenGL 1.1
;;//------------------------------------------------------------------------------------
;;RLAPI Shader LoadShader(char *vsFileName, char *fsFileName);              // Load a custom shader and bind default locations
(defcfun "LoadShader" (:struct %shader)
  (vs-file-name :string)
  (fs-file-name :string))

;;RLAPI void UnloadShader(Shader shader);                                   // Unload a custom shader from memory
(defcfun "UnloadShader" :void
  (shader (:struct %shader)))

;;RLAPI Shader GetDefaultShader(void);                                      // Get default shader
(defcfun "GetDefaultShader" (:struct %shader))

;;RLAPI Shader GetStandardShader(void);                                     // Get standard shader
(defcfun "GetStandardShader" (:struct %shader))

;;RLAPI Texture2D GetDefaultTexture(void);                                  // Get default texture
(defcfun "GetDefaultTexture" (:struct %texture2d))

;;RLAPI int GetShaderLocation(Shader shader, const char *uniformName);              // Get shader uniform location
(defcfun "GetShaderLocation" :int
  (shader (:struct %shader))
  (uniform-name :string))

;;RLAPI void SetShaderValue(Shader shader, int uniformLoc, float *value, int size); // Set shader uniform value (float)
(defcfun "SetShaderValue" :void
  (shader (:struct %shader))
  (uniform-loc :int)
  (value (:pointer :float))
  (size :int))

;;RLAPI void SetShaderValuei(Shader shader, int uniformLoc, int *value, int size);  // Set shader uniform value (int)
(defcfun "SetShaderValuei" :void
  (shader (:struct %shader))
  (uniform-loc :int)
  (value (:pointer :int))
  (size :int))

;;RLAPI void SetShaderValueMatrix(Shader shader, int uniformLoc, Matrix mat);       // Set shader uniform value (matrix 4x4)
(defcfun "SetShaderValueMatrix" :void
  (shader (:struct %shader))
  (uniform-loc :int)
  (mat (:struct %matrix)))

;;RLAPI void SetMatrixProjection(Matrix proj);                              // Set a custom projection matrix (replaces internal projection matrix)
(defcfun "SetMatrixProjection" :void
  (proj (:struct %matrix)))

;;RLAPI void SetMatrixModelview(Matrix view);                               // Set a custom modelview matrix (replaces internal modelview matrix)
(defcfun "SetMatrixModelview" :void
  (view (:struct %matrix)))

;;RLAPI void BeginShaderMode(Shader shader);                                // Begin custom shader drawing
(defcfun "BeginShaderMode" :void
  (shader (:struct %shader)))

;;RLAPI void EndShaderMode(void);                                           // End custom shader drawing (use default shader)
(defcfun "EndShaderMode" :void)

;;RLAPI void BeginBlendMode(int mode);                                      // Begin blending mode (alpha, additive, multiplied)
(defcfun "BeginBlendMode" :void
  (mode :int))

;;RLAPI void EndBlendMode(void);                                            // End blending mode (reset to default: alpha blending)
(defcfun "EndBlendMode" :void)

;;RLAPI Light CreateLight(int type, Vector3 position, Color diffuse);       // Create a new light, initialize it and add to pool
(defcfun "CreateLight" :pointer
  (type :int)
  (position (:struct %vector3))
  (diffuse (:struct %color)))

;;RLAPI void DestroyLight(Light light);                                     // Destroy a light and take it out of the list
(defcfun "DestroyLight" :void
  (light :pointer))

;;//------------------------------------------------------------------------------------
;;// VR experience Functions (Module: rlgl)
;;// NOTE: This functions are useless when using OpenGL 1.1
;;//------------------------------------------------------------------------------------
;;RLAPI void InitVrDevice(int vdDevice);            // Init VR device
(defcfun "InitVrDevice" :void
  (vd-device :int))

;;RLAPI void CloseVrDevice(void);                   // Close VR device
(defcfun "CloseVrDevice" :void)

;;RLAPI bool IsVrDeviceReady(void);                 // Detect if VR device is ready
(defcfun "IsVrDeviceReady" bool)

;;RLAPI bool IsVrSimulator(void);                   // Detect if VR simulator is running
(defcfun "IsVrSimulator" bool)

;;RLAPI void UpdateVrTracking(Camera *camera);      // Update VR tracking (position and orientation) and camera
(defcfun "UpdateVrTracking" :void
  (camera (:pointer (:struct %camera))))

;;RLAPI void ToggleVrMode(void);                    // Enable/Disable VR experience (device or simulator)
(defcfun "ToggleVrMode" :void)

;;//------------------------------------------------------------------------------------
;;// Audio Loading and Playing Functions (Module: audio)
;;//------------------------------------------------------------------------------------
;;RLAPI void InitAudioDevice(void);                                     // Initialize audio device and context
(defcfun "InitAudioDevice" :void)

;;RLAPI void CloseAudioDevice(void);                                    // Close the audio device and context
(defcfun "CloseAudioDevice" :void)

;;RLAPI bool IsAudioDeviceReady(void);                                  // Check if audio device has been initialized successfully
(defcfun "IsAudioDeviceReady" bool)

;;RLAPI Wave LoadWave(const char *fileName);                            // Load wave data from file into RAM
(defcfun "LoadWave" (:struct %wave)
  (file-name :string))

;;RLAPI Wave LoadWaveEx(float *data, int sampleCount, int sampleRate, int sampleSize, int channels); // Load wave data from float array data (32bit)
(defcfun "LoadWaveEx" (:struct %wave)
  (data (:pointer :float))
  (sample-count :int)
  (sample-rate :int)
  (sample-size :int)
  (channels :int))

;;RLAPI Sound LoadSound(const char *fileName);                          // Load sound to memory
(defcfun "LoadSound" (:struct %sound)
  (file-name :string))

;;RLAPI Sound LoadSoundFromWave(Wave wave);                             // Load sound to memory from wave data
(defcfun "LoadSoundFromWave" (:struct %sound)
  (wave (:struct %wave)))

;;RLAPI Sound LoadSoundFromRES(const char *rresName, int resId);        // Load sound to memory from rRES file (raylib Resource)
(defcfun "LoadSoundFromRES" (:struct %sound)
  (rres-name :string)
  (res-id :int))

;;RLAPI void UpdateSound(Sound sound, void *data, int numSamples);      // Update sound buffer with new data
(defcfun "UpdateSound" :void
  (sound (:struct %sound))
  (data :pointer)
  (num-samples :int))

;;RLAPI void UnloadWave(Wave wave);                                     // Unload wave data
(defcfun "UnloadWave" :void
  (wave (:struct %wave)))

;;RLAPI void UnloadSound(Sound sound);                                  // Unload sound
(defcfun "UnloadSound" :void
  (sound (:struct %sound)))

;;RLAPI void PlaySound(Sound sound);                                    // Play a sound
(defcfun "PlaySound" :void
  (sound (:struct %sound)))

;;RLAPI void PauseSound(Sound sound);                                   // Pause a sound
(defcfun "PauseSound" :void
  (sound (:struct %sound)))

;;RLAPI void ResumeSound(Sound sound);                                  // Resume a paused sound
(defcfun "ResumeSound" :void
  (sound (:struct %sound)))

;;RLAPI void StopSound(Sound sound);                                    // Stop playing a sound
(defcfun "StopSound" :void
  (sound (:struct %sound)))

;;RLAPI bool IsSoundPlaying(Sound sound);                               // Check if a sound is currently playing
(defcfun "IsSoundPlaying" bool
  (sound (:struct %sound)))

;;RLAPI void SetSoundVolume(Sound sound, float volume);                 // Set volume for a sound (1.0 is max level)
(defcfun "SetSoundVolume" :void
  (sound (:struct %sound))
  (volume :float))

;;RLAPI void SetSoundPitch(Sound sound, float pitch);                   // Set pitch for a sound (1.0 is base level)
(defcfun "SetSoundPitch" :void
  (sound (:struct %sound))
  (pitch :float))

;;RLAPI void WaveFormat(Wave *wave, int sampleRate, int sampleSize, int channels);  // Convert wave data to desired format
(defcfun "WaveFormat" :void
  (wave (:pointer (:struct %wave)))
  (sample-rate :int)
  (sample-size :int)
  (channels :int))
  
;;RLAPI Wave WaveCopy(Wave wave);                                       // Copy a wave to a new wave
(defcfun "WaveCopy" (:struct %wave)
  (wave (:pointer (:struct %wave)))
  (init-sample :int)
  (final-sample :int))
  
;;RLAPI void WaveCrop(Wave *wave, int initSample, int finalSample);     // Crop a wave to defined samples range
(defcfun "WaveCrop" :void
  (wave (:pointer (:struct %wave)))
  (init-sample :int)
  (final-sample :int))
  
;;RLAPI float *GetWaveData(Wave wave);                                  // Get samples data from wave as a floats array
(defcfun "GetWaveData" (:pointer :float)
  (wave (:struct %wave)))
  
;;RLAPI Music LoadMusicStream(const char *fileName);                    // Load music stream from file
(defcfun "LoadMusicStream" :pointer
  (file-name :string))
  
;;RLAPI void UnloadMusicStream(Music music);                            // Unload music stream
(defcfun "UnloadMusicStream" :void
  (music :pointer))
  
;;RLAPI void PlayMusicStream(Music music);                              // Start music playing
(defcfun "PlayMusicStream" :void
  (music :pointer))
  
;;RLAPI void UpdateMusicStream(Music music);                            // Updates buffers for music streaming
(defcfun "UpdateMusicStream" :void
  (music :pointer))
  
;;RLAPI void StopMusicStream(Music music);                              // Stop music playing
(defcfun "StopMusicStream" :void
  (music :pointer))
  
;;RLAPI void PauseMusicStream(Music music);                             // Pause music playing
(defcfun "PauseMusicStream" :void
  (music :pointer))
  
;;RLAPI void ResumeMusicStream(Music music);                            // Resume playing paused music
(defcfun "ResumeMusicStream" :void
  (music :pointer))
  
;;RLAPI bool IsMusicPlaying(Music music);                               // Check if music is playing
(defcfun "IsMusicPlaying" :boolean
  (music :pointer))
  
;;RLAPI void SetMusicVolume(Music music, float volume);                 // Set volume for music (1.0 is max level)
(defcfun "SetMusicVolume" :void
  (music :pointer)
  (volume :float))
  
;;RLAPI void SetMusicPitch(Music music, float pitch);                   // Set pitch for a music (1.0 is base level)
(defcfun "SetMusicPitch" :void
  (music :pointer)
  (pitch :float))
  
;;RLAPI float GetMusicTimeLength(Music music);                          // Get music time length (in seconds)
(defcfun "GetMusicTimeLength" :float
  (music :pointer))
  
;;RLAPI float GetMusicTimePlayed(Music music);                          // Get current music time played (in seconds)
(defcfun "GetMusicTimePlayed" :float
  (music :pointer))
  
;;RLAPI AudioStream InitAudioStream(unsigned int sampleRate,
;;                                  unsigned int sampleSize,
;;                                  unsigned int channels);             // Init audio stream (to stream raw audio pcm data)
(defcfun "InitAudioStream" (:struct %audio-stream)
  (sample-rate :unsigned-int)
  (sample-size :unsigned-int)
  (channels :unsigned-int))
  
;;RLAPI void UpdateAudioStream(AudioStream stream, void *data, int numSamples); // Update audio stream buffers with data
(defcfun "UpdateAudioStream" :void
  (stream (:struct %audio-stream))
  (data :pointer)
  (num-samples :int))
  
;;RLAPI void CloseAudioStream(AudioStream stream);                      // Close audio stream and free memory
(defcfun "CloseAudioStream" :void
  (stream (:struct %audio-stream)))
  
;;;RLAPI bool IsAudioBufferProcessed(AudioStream stream);                // Check if any audio stream buffers requires refill
(defcfun "IsAudioBufferProcessed" bool
  (stream (:struct %audio-stream)))
  
;;RLAPI void PlayAudioStream(AudioStream stream);                       // Play audio stream
(defcfun "PlayAudioStream" :void
  (stream (:struct %audio-stream)))
  
;;RLAPI void PauseAudioStream(AudioStream stream);                      // Pause audio stream
(defcfun "PauseAudioStream" :void
  (stream (:struct %audio-stream)))
  
;;RLAPI void ResumeAudioStream(AudioStream stream);                     // Resume audio stream
(defcfun "ResumeAudioStream" :void
"Resume audio stream"
 )

;;RLAPI void StopAudioStream(AudioStream stream);                       // Stop audio stream
(defcfun "StopAudioStream" :void
"Stop audio stream"
  (stream (:struct %audio-stream)))
  
;;#ifdef __cplusplus
;;}
;;#endif
;;
;;#endif // RAYLIB_H

