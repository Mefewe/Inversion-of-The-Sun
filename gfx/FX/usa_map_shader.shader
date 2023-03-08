Includes = {
}

PixelShader =
{
	Samplers =
	{
		TextureOne =
		{
			Index = 0
			MagFilter = "Point"
			MinFilter = "Point"
			MipFilter = "None"
			AddressU = "Wrap"
			AddressV = "Wrap"
		}
		TextureTwo =
		{
			Index = 1
			MagFilter = "Point"
			MinFilter = "Point"
			MipFilter = "None"
			AddressU = "Wrap"
			AddressV = "Wrap"
		}
	}
}


VertexStruct VS_INPUT
{
    float4 vPosition  : POSITION;
    float2 vTexCoord  : TEXCOORD0;
};

VertexStruct VS_OUTPUT
{
    float4  vPosition : PDX_POSITION;
    float2  vTexCoord0 : TEXCOORD0;
};


ConstantBuffer( 0, 0 )
{
	float4x4 WorldViewProjectionMatrix; 
	float4 vFirstColor;
	float4 vSecondColor;
	float CurrentState;
};


VertexShader =
{
	MainCode VertexShader
	[[
		
		VS_OUTPUT main(const VS_INPUT v )
		{
			VS_OUTPUT Out;
		   	Out.vPosition  = mul( WorldViewProjectionMatrix, v.vPosition );
			Out.vTexCoord0  = v.vTexCoord;
			Out.vTexCoord0.y = -Out.vTexCoord0.y;
		
			return Out;
		}
		
	]]
}

PixelShader =
{
	MainCode PixelColor
	[[
		
		float4 main( VS_OUTPUT v ) : PDX_COLOR
		{
			if( v.vTexCoord0.x <= CurrentState )
				return vFirstColor;
			else
				return vSecondColor;
		}
		
	]]

	MainCode PixelTexture
	[[
		
		float4 main( VS_OUTPUT v ) : PDX_COLOR
		{
			float value = CurrentState * 100000.f;
			float part1 = floor((value / 1000.f) + 0.5) * 1000.f;
			float progress = value - part1;
			float part2 = floor((part1 / 10000.f) + 0.5);
			float part3 = (part1/10000.f) - part2;
			if (part3 < 0) {
				part2 = part2 - 1.f;
				part3 = part3 + 1.f;
			}
			float firstParty = part2;
			float secondParty = part3 * 10.f;
			
			float4 firstPartyColour = tex2D(TextureTwo, float2(((firstParty / 8.f) - 0.001f), 0.0f));
			float4 secondPartyColour = tex2D(TextureTwo, float2(((secondParty / 8.f) - 0.001f), 0.0f));
			
			float4 texColor =  tex2D( TextureOne, v.vTexCoord0.xy );
			if (texColor.a == 0) {
				return float4(0, 0, 0, 0);
			}
			
			float progVar = progress/100.f;
			if (texColor.r == 0 && texColor.g == 0 && progVar > 0.149f) {
				return float4(secondPartyColour.r, secondPartyColour.g, secondPartyColour.b, 0.58f);
			} else if (texColor.r == 0.2 && texColor.g == 0 && progVar > 0.299f) {
				return float4(secondPartyColour.r, secondPartyColour.g, secondPartyColour.b, 0.58f);
			} else if (texColor.r == 0.4 && texColor.g == 0 && progVar > 0.399f) {
				return float4(secondPartyColour.r, secondPartyColour.g, secondPartyColour.b, 0.58f);
			}else if (texColor.r == 0.6 && texColor.g == 0 && progVar > 0.499f) {
				return float4(secondPartyColour.r, secondPartyColour.g, secondPartyColour.b, 0.58f);
			}else if (texColor.r == 0.8 && texColor.g == 0 && progVar > 0.599f) {
				return float4(secondPartyColour.r, secondPartyColour.g, secondPartyColour.b, 0.58f);
			}else if (texColor.r == 1 && texColor.g == 0 && progVar > 0.699f) {
				return float4(secondPartyColour.r, secondPartyColour.g, secondPartyColour.b, 0.58f);
			}else if (texColor.r == 0.0 && texColor.g == 0.2 && progVar > 0.799f) {
				return float4(secondPartyColour.r, secondPartyColour.g, secondPartyColour.b, 0.58f);
			}else if (texColor.r == 0.0 && texColor.g == 0.4 && progVar > 0.899f) {
				return float4(secondPartyColour.r, secondPartyColour.g, secondPartyColour.b, 0.58f);
			}else {
				return float4(firstPartyColour.r, firstPartyColour.g, firstPartyColour.b, 0.58f);
			}
		}
		
	]]
}


BlendState BlendState
{
	BlendEnable = yes
	SourceBlend = "SRC_ALPHA"
	DestBlend = "INV_SRC_ALPHA"
}


Effect Color
{
	VertexShader = "VertexShader"
	PixelShader = "PixelColor"
}

Effect Texture
{
	VertexShader = "VertexShader"
	PixelShader = "PixelTexture"
}

