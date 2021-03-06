/*
 $Rev$ | $LastChangedBy$
 $LastChangedDate$
 +-------------------------------------------------------------------------+
 | Copyright (c) 2004 - 2010, Kreotek LLC                                  |
 | All rights reserved.                                                    |
 +-------------------------------------------------------------------------+
 |                                                                         |
 | Redistribution and use in source and binary forms, with or without      |
 | modification, are permitted provided that the following conditions are  |
 | met:                                                                    |
 |                                                                         |
 | - Redistributions of source code must retain the above copyright        |
 |   notice, this list of conditions and the following disclaimer.         |
 |                                                                         |
 | - Redistributions in binary form must reproduce the above copyright     |
 |   notice, this list of conditions and the following disclaimer in the   |
 |   documentation and/or other materials provided with the distribution.  |
 |                                                                         |
 | - Neither the name of Kreotek LLC nor the names of its contributore may |
 |   be used to endorse or promote products derived from this software     |
 |   without specific prior written permission.                            |
 |                                                                         |
 | THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS     |
 | "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT       |
 | LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A |
 | PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT      |
 | OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,   |
 | SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT        |
 | LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,   |
 | DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY   |
 | THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT     |
 | (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE   |
 | OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.    |
 |                                                                         |
 +-------------------------------------------------------------------------+
*/

MLsets= new Array();

function setInitialML(thelist){
	MLsets[thelist.id]=thelist.selectedIndex;
}

function changeChoiceList(thelist,base,listname,blankvalue){
	if(thelist.value=="*mL*"){
		thelist.selectedIndex=MLsets[thelist.id];
		modifyList(thelist,base,listname,blankvalue);
	} else {
		MLsets[thelist.id]=thelist.selectedIndex;
		if(thelist.onchange2)
			thelist.onchange2();
	} 
}


function  modifyList(thelist,base,listname,blankvalue){
	var content="<div align=\"center\"><img src=\""+base+"common/image/spinner.gif\" alt=\"0\" width=\"16\" height=\"16\" align=\"absmiddle\"> <strong>Loading...</strong></div>";
	showModal(content,"Modify List",300);
	var modalContent=getObjectFromID("modalContent");
		
	var theURL=base+"choicelist.php?cm=shw";
	theURL+="&ln="+encodeURIComponent(listname);
	theURL+="&bv="+encodeURIComponent(blankvalue);
	theURL+="&lid="+thelist.id;
	loadXMLDoc(theURL,null,false);
	
	modalContent.innerHTML=req.responseText;
}

function closeBox(listid){
	var thelist=getObjectFromID(listid);
	thelist.disabled=false;
	closeModal();
}

function clickOK(base,listid,listname){
	saveList(base,listname);
	var thelist=getObjectFromID(listid);
	loadList(base,thelist,listname);
	closeModal();
}

function saveList(base,listname){
	var thelist=getObjectFromID("MLlist");
	var thestatus=getObjectFromID("MLStatus");
	var i;

	thestatus.innerHTML="<img src=\""+base+"common/image/spinner.gif\" alt=\"0\" width=\"16\" height=\"16\" align=\"absmiddle\"> <strong>Processing...</strong>";

	//delete current list
	var theURL=base+"choicelist.php?cm=del";
	theURL+="&ln="+encodeURIComponent(listname);
	loadXMLDoc(theURL,null,false);
	if (req.responseText!="ok")
		alert(theURL+"\n\n"+req.responseText);
	
	//add each new item in.
	for(i=0;i<thelist.options.length;i++){
		theURL=base+"choicelist.php?cm=add";
		theURL+="&ln="+encodeURIComponent(listname);
		theURL+="&val="+encodeURIComponent(thelist.options[i].value);			
		loadXMLDoc(theURL,null,false);
		if (req.responseText!="ok")
			alert(theURL+"\n\n"+req.responseText);
	}
}

function loadList(base,thelist,listname){
	//remove current list
	var selValue=thelist.options[thelist.selectedIndex].value;
	var selText=thelist.options[thelist.selectedIndex].text;
	
	for(i=thelist.options.length-1;i>0;i--){
		thelist.options[0]=null;
	}
	var newlist=getObjectFromID("MLlist");
	
	//copy the new list over to the drop down
	var inList=false;
	for(i=0;i<newlist.options.length;i++){
		thelist.options[thelist.options.length]=new Option(newlist.options[i].text,newlist.options[i].value);
		if (thelist.options[thelist.options.length-1].value=="")
			thelist.options[thelist.options.length-1].className="choiceListBlank";
		if(thelist.options[thelist.options.length-1].value==selValue) {
			thelist.options[thelist.options.length-1].selected=true;
			inList=true;
		}
	}
	//if the previously selected value was not in the list, add it back in
	if(!inList){
		thelist.options[thelist.options.length]=new Option(selText,selValue);
		if (thelist.options[thelist.options.length-1].value=="")
			thelist.options[thelist.options.length-1].className="choiceListBlank";
		thelist.options[thelist.options.length-1].selected=true;
	}
	
	thelist.options[thelist.options.length]=new Option (thelist.options[0].text,thelist.options[0].value);
	thelist.options[thelist.options.length-1].className=thelist.options[0].className;
	thelist.options[0]=null;
	
}

function updateML(thelist){
	var delbutton=getObjectFromID("MLDelete");
	var addeditbutton=getObjectFromID("MLaddeditbutton");	
	var addedit=getObjectFromID("MLaddedit");	
	addeditbutton.value="edit";
	delbutton.disabled=false;
	addedit.value=thelist.value;
}

function insertML(){
	var thelist=getObjectFromID("MLlist");
	var delbutton=getObjectFromID("MLDelete");
	var addeditbutton=getObjectFromID("MLaddeditbutton");	
	var addedit=getObjectFromID("MLaddedit");	
	addeditbutton.value="add";
	delbutton.disabled=true;
	addedit.value="";
	thelist.selectedIndex=-1;
	addedit.focus();
}

function addeditML(blankvalue){
	var thelist=getObjectFromID("MLlist");
	var delbutton=getObjectFromID("MLDelete");
	var addeditbutton=getObjectFromID("MLaddeditbutton");	
	var addedit=getObjectFromID("MLaddedit");
	
	var newValue=addedit.value;
	var newText=newValue;
	
	//check for blank values;
	if(newValue==blankvalue || newValue=="<"+blankvalue+">" || newValue==""){
		newValue="";
		newText="<"+blankvalue+">";
	}

	if (addeditbutton.value=="add"){
		thelist.options[thelist.options.length]= new Option(newText,newValue);
		if(thelist.options[thelist.options.length-1].value=="")
			thelist.options[thelist.options.length-1].className="choiceListBlank";
	} else{
		thelist.options[thelist.selectedIndex].value=newValue;
		thelist.options[thelist.selectedIndex].text=newText;
		if(thelist.options[thelist.selectedIndex].value=="")
			thelist.options[thelist.selectedIndex].className="choiceListBlank";
	}
}

function delML(){
	var thelist=getObjectFromID("MLlist");
	var delbutton=getObjectFromID("MLDelete");
	var addeditbutton=getObjectFromID("MLaddeditbutton");	
	var addedit=getObjectFromID("MLaddedit");	
	thelist.options[thelist.selectedIndex]=null;
	addeditbutton.value="add";
	delbutton.disabled=true;
	addedit.value="";
	thelist.selectedIndex=-1;
}
