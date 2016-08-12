# NJ Namju Lee [www.njstudio.co.kr] 
# nj.namju@gmailc.om

import sys, os, json

def SaveJson(path, data): # "source\\K-town_streetviews.json"
    with open(path, 'w') as f:
        f.write(json.dumps(data, indent=4, ensure_ascii=False, encoding="latin1"))
        f.close()
def OpenTxt(path):
	txtFile = open(path, 'r')
	return txtFile.read()
def GetJsonFromMaterialFrom3dsMax(data, fileName):
	data = data.split('__')
	tempList = [];
	for j in data:
		tempDic = {}
		j = j.split(',')
		for i in j:
			i = i.split(':')
			try:
				tempDic[i[0]] = float(i[1])
			except:
				pass
		tempList.append(tempDic);
	SaveJson( "z:\\" + fileName + ".json", tempList)

theFileName = "theFileName"

txt = OpenTxt( theFileName + ".txt")
GetJsonFromMaterialFrom3dsMax(txt, theFileName);