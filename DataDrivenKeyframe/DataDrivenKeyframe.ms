
--Set the animation keyframes of an object from a text file
--If the object has keyframes already outside the range the file has, they will be kept
	
fn setAnimToObject GivenObject = 
(
	--pbar.value = 0 	--print spin_fromx.value
	i = 0
	errorState = false
		
	Gobject = GivenObject

	Gobject.material = standard() --diffuse:red opacity:20
	Gobject.material.name = Gobject.name
	Gobject.material.diffuse = color 255 255 255		
	Gobject.material.selfIllumAmount = 100
	select Gobject

	--Get the file with the animation sequence...try to contain errors
	f1 = getOpenFileName types:"Text(*.csv)|*.csv|All files|*.*|"
	--print f1
	
	f2 = openFile f1 mode:"rt"
	try (
		while not eof f2 AND not errorState do 
			(
				inputData = readLine f2 
				--print inputData
				
				inputArray = filterString inputData ","
				
				print inputArray
				print inputArray[1]
				print inputArray[2]
				print inputArray[3]
				print inputArray[4]
			)		
	) catch ()
		
	try (
			deleteKey Gobject.pos.controller 1
			deleteKey Gobject.pos.controller 1
		
			deleteKey Gobject.rotation.controller 1
			deleteKey Gobject.material.diffuse.controller 1
			--deleteKey Gobject.scale.controller 1

	) catch()

)

try(destroyDialog setAnimToObjectPanel) catch()
rollout setAnimToObjectPanel "Animation From Data set Version 0.0.1 by NJSTUDIO" width:288 height:288
(
	pickbutton chooseit "Pick Object to animate" pos:[12,27] width:253 height:46
	progressBar pbar "Progression" pos:[11,80] width:254 height:10 color:[255,255,255]
	GroupBox grp1 "General option" pos:[6,7] width:272 height:93
	label lbl1 "www.njstudio.co.kr" pos:[10,263] width:266 height:16
	label lbl2 "Developed by NJ, Version 0.0.5" pos:[9,246] width:266 height:16

	on chooseit picked GivenObject do with undo "undo" on
	(
		setAnimToObject GivenObject
	)
)

createdialog setAnimToObjectPanel 288 288 

