import sys, os, json

#################################### Utilty
def SaveTxt(path, data):		
	text_file = open(path, "w")
	for d in data:
		text_file.write(d)
	text_file.close()
def SaveJson(path, data): # "source\\K-town_streetviews.json"
    with open(path, 'w') as f:
        f.write(json.dumps(data, indent=4, ensure_ascii=False, encoding="latin1"))
        f.close()
def SaveJsonFromClass(path, data): # "source\\K-town_streetviews.json"
    with open(path, 'w') as f:
    	for d in data:
        	f.write(json.dumps(d.__dict__, indent=4, ensure_ascii=False, encoding="latin1"))
        f.close()

#################################### for 3ds max
def GetPosWithBound(posA, posB, x,y,z):
	theOutPos = []
	xd = (posB['x'] - posA['x']) / float(x) 
	yd = (posB['y'] - posA['y']) / float(y) 
	zd = (posB['z'] - posA['z']) / float(z) 
	print "the interval is x= ", xd ," y= ", yd," y= ", zd

	for theZ in range(z+1): # include the last num
		for theY in range(y+1):
			for theX in range(x+1):
				p = [theX * xd, theY * yd, theZ * zd]
				theOutPos.append(p)
	return theOutPos


def GetPos(x,y,z):
	theOutPos = []
	for theZ in range(z):
		for theY in range(y):
			for theX in range(x):
				p = [theX, theY, theZ]
				theOutPos.append(p)
	return theOutPos
def GetDegreeFromNumber(num):
	out = []
	degree = 360 / num
	for i in range(num):
		d = degree * i
		out.append(d)
	return out
def GetAngleFromNumber(n=2, angle=15):
	out = []
	for i in range(n):
		out.append(angle * i)
		out.append(-angle * i)
	return out[1:]


######################################### execute type A
def SaveTheCameraPosWithXYZ():
	x = 10
	y = 10
	z = 30
	posList = GetPos(x,y,z)
	rotList = GetDegreeFromNumber(5)
	angList = GetAngleFromNumber(n=2, angle=7)

	cameraDataList = []
	numID = 0
	for pos in posList:
		for rot in rotList:
			for ang in angList:
				cameraDataList.append({
						'id'  : numID,
						'name': "CameraDataFromPython", 
						'pos' : pos,
						'rot' : rot,
						'ang' : ang
						})
				numID += 1

	SaveJson("z:\\dd.json", cameraDataList)
	print "done"

def GetTxtFromJSon(d):
	txt = []
	for i in d:
		txt.append(str(i));
	return txt;

######################################### execute type B
def SaveTheCameraPosWithBound():
	posA = {'x': -10.1 ,'y': -10 ,'z': -10}
	posB = {'x': 23.23 ,'y': 20 ,'z': 15}
	x = 10
	y = 10
	z = 10
	posList = GetPosWithBound(posA, posB, x, y, z)
	rotList = GetDegreeFromNumber(5)
	angList = GetAngleFromNumber(n=2, angle=7)

	cameraDataList = []
	numID = 0
	for pos in posList:
		for rot in rotList:
			for ang in angList:
				cameraDataList.append({
						'id'  : numID,
						'name': "CameraDataFromPython", 
						'pos' : pos,
						'rot' : rot,
						'ang' : ang
						})
				numID += 1

	txt = GetTxtFromJSon(cameraDataList)
	SaveTxt("Z:/ThesisProject/2016_[Thesis] MLForVisualization/script/dd.txt", txt)
	# SaveJson("Z:/ThesisProject/2016_[Thesis] MLForVisualization/script/dd.json", cameraDataList)
	print "done"


# SaveTheCameraPosWithXYZ()
SaveTheCameraPosWithBound()
