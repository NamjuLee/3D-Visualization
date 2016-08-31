--NJ Namju Lee, www.njstudio.co.kr // nj.namju@gmail.com
fn MoveLocal theObj thePos = (
	in coordsys local theObj.pos = thePos
	return theObj
	) 
fn GetDuplicate theObj = (
	newObj = instance theObj
	return newObj
	)
fn GetArrayObj theObj offset = (
	objArray =  #()
	vecArray = #()
	append vecArray [-offset , -offset, 0 ]
	append vecArray [ 0 , -offset , 0 ]
	append vecArray [offset , -offset , 0 ]
	append vecArray [-offset , 0 , 0 ]
	append vecArray [0 , 0 , 0 ]
	append vecArray [offset , 0 , 0 ]
	append vecArray [-offset , offset , 0 ]
	append vecArray [0 , offset , 0 ]
	append vecArray [offset, offset , 0 ]
	for i in vecArray do( 
		print i
		c1 = GetDuplicate theObj
		c1 = MoveLocal c1 i 
		append objArray c1
		)
	return objArray
	)
	
cams = GetArrayObj $ 150
print cams
	
	
-- render
fn snapCam theCamera label size:[320, 240] frames: folder:"z:\project\\" = (
	
	local fname = folder + label + "-" + theCamera.name
	local renderinWindow 
	if frames == unsupplied then(
		renderinWindow = render camera: theCamera outputFile:(fname + ".jpg") outputSize:size
	)else(
		renderinWindow = render camera: theCamera frameRange: #current outputFile: (fname + ".avi") outputSize: size
		print("Thats not right!")
	)
	close renderinWindow
)

fn GetRenderFromCameras theCameras = (
	
	for c in theCameras do(
		snapCam c  "Phase1" --size:[640,480] 
	)
)

GetRenderFromCameras cams
delete cams



