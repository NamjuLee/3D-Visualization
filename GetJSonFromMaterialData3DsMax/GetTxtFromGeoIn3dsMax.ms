/*
* Copyright (c) 2004 NJ Namju Lee [www.njstudio.co.kr] 
*
* nj.namju@gmailc.om
*
* This software is provided 'as-is', without any express or implied
* warranty. In no event will the authors be held liable for any damages
* arising from the use of this software.
*
* Permission is granted to anyone to use this software for any purpose,
* including commercial applications, and to alter it and redistribute it
* freely, subject to the following restrictions:
*
*    1. The origin of this software must not be misrepresented; you must not
*    claim that you wrote the original software. If you use this software
*    in a product, an acknowledgment in the product documentation would be
*    appreciated but is not required.
*
*    2. Altered source versions must be plainly marked as such, and must not
*    be misrepresented as being the original software.
*
*    3. This notice may not be removed or altered from any source
*    distribution.
*/


struct MatJson (
	
	nameObject = "null",
	nameMaterial = "null",

	--Diffuse
	diffuse_roughness = 0,
 	reflectionValue = 0,

	-- Reflect
	reflection_subdivs = 0,
	reflection_lockGlossiness = 0 ,
	hilight_glossiness ,

	reflection_glossiness ,
	reflection_fresnel ,

	-- Refract
	refractionValue,
	refraction_subdivs ,
	refraction_glossiness,
	refraction_ior ,

	--Fog
	refraction_fogColor,
	refraction_fogBias,
	refraction_fogMult,

	-- maps
	texmap_diffuse_multiplier, 

	texmap_bump_multiplier,
	texmap_displacement_multiplier,
	texmap_opacity_multiplier, 

	json,

	fn GetMaterial obj =(

	--general info
	nameObject = obj.name
	nameMaterial = obj.material
		
	--Diffuse
	diffuse_roughness = obj.material.diffuse_roughness
	Reflection = obj.material.Reflection  

	--Reflect
	reflection_subdivs = obj.material.reflection_subdivs
	reflection_lockGlossiness = obj.material.reflection_lockGlossiness 
	hilight_glossiness = obj.material.hilight_glossiness  

	reflection_glossiness = obj.material.reflection_glossiness 
	reflection_fresnel = obj.material.reflection_fresnel 

	--Refract
	Refraction = obj.material.Refraction
	refraction_subdivs = obj.material.refraction_subdivs 
	refraction_glossiness = obj.material.refraction_glossiness
	refraction_ior = obj.material.refraction_ior

	--Fog
	refraction_fogColor = obj.material.refraction_fogColor
	refraction_fogBias = obj.material.refraction_fogBias
	refraction_fogMult = obj.material.refraction_fogMult

	-- maps
	texmap_diffuse_multiplier = obj.material.texmap_diffuse_multiplier 

	texmap_bump_multiplier = obj.material.texmap_bump_multiplier 
	texmap_displacement_multiplier = obj.material.texmap_displacement_multiplier 
	texmap_opacity_multiplier = obj.material.texmap_opacity_multiplier

	),

	fn GetJson = (
		json = "nameObject:"  + nameObject as string + "," + 
				"nameMaterial:" + nameMaterial as string+ "," + 
				"diffuse_roughness:"  + diffuse_roughness as string + "," + 
				"reflectionValue:" + reflectionValue  as string + "," + 
				"reflection_subdivs:"  + reflection_subdivs as string+ "," + 
				"reflection_lockGlossiness:" + reflection_lockGlossiness as string+ "," + 
				"hilight_glossiness:"  + hilight_glossiness as string+ "," + 
				"reflection_glossiness:"  + reflection_glossiness as string + "," + 	
				"reflection_fresnel:" + reflection_fresnel as string + "," + 
				"refractionValue:"  + refractionValue as string + "," + 
				"refraction_subdivs:" + refraction_subdivs as string + "," +  
				"refraction_glossiness:"  + refraction_glossiness as string + "," + 	
				"refraction_ior:" + refraction_ior as string +  "," + 
				"refraction_fogColor:"  + refraction_fogColor as string+ "," + 
				"refraction_fogBias:" + refraction_fogBias as string + "," +  
				"refraction_fogMult:"  + refraction_fogMult as string + "," + 	
				"texmap_diffuse_multiplier:" + texmap_diffuse_multiplier as string + "," +  
				"texmap_bump_multiplier:"  + texmap_bump_multiplier as string + "," + 
				"texmap_displacement_multiplier:" + texmap_displacement_multiplier as string +"," +  
				"texmap_opacity_multiplier:"  + texmap_opacity_multiplier as string
		return json
	) 
);
fn ComputeGeo theFile= (
	temp = #()
	textAll = "";
	for o in geometry do (
		
		if classof o.material == VRayMtl do (
			m = MatJson();
			m.GetMaterial(o)
			textJson = m.GetJson()
			append temp m
			textAll += textJson
			textAll += "__"
		)
	)
	--f1 = getOpenFileName types:"Text(*.txt)|*.txt|All files|*.*|" -- this is for a manual way
	f1 = theFile
	fsadd = openFile f1 mode:"a+"
	skipToString fsadd "Some text"
	print textAll to:fsadd
	close fsadd
)
fn GetRidOfQuotation pathName = (
	textAllPageage = ""
	fsadd = openFile pathName mode:"rt"
	while not eof fsadd  do 
	(
		inputData = readLine fsadd 				
		inputArray = filterString inputData "\""
		print inputArray[1]
		try(
		textAllPageage += inputArray[1]
		)catch(
			try(
			textAllPageage += inputArray[2]
			)catch()
		)
	)
	close fsadd
	newTxt = createFile pathName mode:"r+"
	format textAllPageage to:newTxt
	close newTxt
)
fn openMaxFiles thePath theFile = (
maxFiles = getFiles( thePath +"//*.max")
for f in maxFiles do(
	if isMaxFile(f) then(
		if loadMaxFile f useFileUnits:true quiet:true then(
			ComputeGeo(theFile)
			)
		)
	)
	resetMaxFile #noPrompt
	GetRidOfQuotation(theFile)
)
-- entry point!!!
thePath = "V://3dsMaxFolder//" -- the folder for 3ds max files
theFile = "z://MaterialData.txt" -- the file name to save
openMaxFiles thePath theFile