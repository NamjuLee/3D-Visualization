// NJ Namju Lee [www.njstudio.co.kr] 
// nj.namju@gmailc.om

function GetListFromVrayMatFromMax(theStrings){
	let theList = [];
	let temp = theStrings.split("__");
	for(let i = 0, c = temp.length; i < c; ++i){
		let result = GetJSonFromVrayMatFromMax(temp[i]);
		if(result.nameObject != null) theList.push(result)
	}
	return theList;
}
function GetJSonFromVrayMatFromMax(theString){
	let temp = theString.split(",")
	let theDic = {}
	for(let i of temp ){
		let txt = i.split(":")
		if(!isNaN(Number(txt[1]))) theDic[txt[0]] = Number(txt[1]);
		else theDic[txt[0]] = txt[1];
	}
	return theDic
}

let theData
GetListFromVrayMatFromMax(theData)