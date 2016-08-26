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
geo = GetArrayObj $ 150
print geo