

fn snapCam theCamera label size:[320, 240] frames: folder:"Z:\ThesisProject\2016_[Thesis] MLForVisualization\script\img\\" = (
	
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



fn GetCamera  pos rotY rotZ id = (
	c = Freecamera();
	c.position= pos
	c.fov =24
	theRotation =rotZ - 90
	rotate c (angleaxis 90 [1,0,0]);
	in coordsys local rotate c (angleaxis rotY [1,0,0]);
	rotate c (angleaxis theRotation [0,0,1]);
	c.name = c.position as string + id as string
	return c
)



fn OpenTxt = (
	--Get the file with the animation sequence...try to contain errors
	errorState = false
	f1 = getOpenFileName types:"Text(*.txt)|*.txt|All files|*.*|"

	
	f2 = openFile f1 mode:"rt"
	try (
		while not eof f2 AND not errorState do 
			(
				inputData = readLine f2 
				inputArray = filterString inputData "{"
				
				
					for data in inputArray do(
						---------------------- rot
						rot =  filterString data ":"
						rot = filterString rot[2] ","
						rot = rot[1] as float
						---------------------- ang
						ang =  filterString data ":"
						ang =  filterString ang[6] "}"
						ang = ang[1] as float
						---------------------- rot
						pos =  filterString data ":"
						pos =  filterString pos[4] "["
						pos =  filterString pos[2] "]"
						pos = filterString pos[1]","
						xPos = pos [1] as float
						yPos = pos [2] as float
						zPos = pos [3] as float
						pos =  [xPos, yPos, zPos]
						---------------------- rot						
						
						id = filterString data ":"
						id = filterString id[5] ","	
						id = id[1] -- this should be string for name of camera
						print id
						theCamera = GetCamera pos rot ang id
						snapCam theCamera id
						
						print "-----------------------"
						break
						
						)
				--print inputArray[6]
				--Create pos rot ang
				--break


			)		
	) catch ()

)


OpenTxt ()