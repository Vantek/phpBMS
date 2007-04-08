<?php 
/*
 $Rev$ | $LastChangedBy$
 $LastChangedDate$
 +-------------------------------------------------------------------------+
 | Copyright (c) 2004 - 2007, Kreotek LLC                                  |
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

	require_once("../../include/session.php");
	require_once("../../include/common_functions.php");
	require_once("../../include/fields.php");
	require_once("snapshot_ajax.php");

	require_once("include/notes_addedit_include.php");

	$attachedtableinfo=getAttachedTableDefInfo($therecord["attachedtabledefid"]);

	$pageTitle="Note/Task/Event"	
?><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title><?php echo $pageTitle ?></title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<?php require("../../head.php")?>
<link href="../../common/stylesheet/<?php echo $_SESSION["stylesheet"] ?>/pages/notes.css" rel="stylesheet" type="text/css" />
<script language="JavaScript" src="../../common/javascript/fields.js" type="text/javascript"></script>
<script language="JavaScript" src="../../common/javascript/autofill.js" type="text/javascript"></script>
<script language="JavaScript" src="../../common/javascript/choicelist.js" type="text/javascript"></script>
<script language="JavaScript" src="../../common/javascript/datepicker.js" type="text/javascript"></script>
<script language="JavaScript" src="../../common/javascript/timepicker.js" type="text/javascript"></script>
<script language="JavaScript" src="javascript/notes.js" type="text/javascript"></script>
</head>
<body ><?php include("../../menu.php")?>

<form action="<?php echo htmlQuotes($_SERVER["REQUEST_URI"]) ?>" method="post" name="record" onsubmit="return validateForm(this);"><div id="dontSubmit"><input type="submit" value=" " onclick="return false;" /></div>
<div class="bodyline">
	<div id="topButtons"><?php showSaveCancel(1); ?></div>
	<h1 id="topTitle"><span><?php echo $pageTitle ?></span></h1>

	<fieldset id="fsTop">
		<legend>Attributes</legend>
		<p id="idP">
			<label for="id">id</label><br/>
			<input name="id" id="id"  type="text" value="<?php echo $therecord["id"]; ?>" size="8" maxlength="8" readonly="readonly" class="uneditable"/>
			<input name="parentid" id="parentid" type="hidden" value="<?php echo $therecord["parentid"]; ?>" />
			<input name="thebackurl" id="thebackurl" type="hidden" value="<?php if(isset($_GET["backurl"])) echo $_GET["backurl"]; ?>" />
		</p>
		
		<p>
			<label for="thetype" class="important">type</label><br />
			<?php fieldBasicList("thetype",$therecord["type"],array(array("value"=>"NT","name"=>"Note"),array("value"=>"TS","name"=>"Task"),array("value"=>"EV","name"=>"Event"),array("value"=>"SM","name"=>"System Message")),Array("class"=>"important","onchange"=>"changeType();"));?>
			<input type="hidden" id="typeCheck" name="typeCheck" value="<?php echo $therecord["type"]?>" />		
		</p>
		
		<p>
			<label for="subject">title</label><br />
			<?php fieldText("subject",$therecord["subject"],0,"","",Array("size"=>"28","maxlength"=>"128","class"=>"important")); ?>
		</p>				
	</fieldset>
	
	<div id="leftSideDiv">
		<fieldset>
			<legend><label for="importance">importance / privacy</label></legend>
			<p>
				<?php fieldBasicList("importance",$therecord["importance"],array(array("value"=>"3","name"=>"Highest"),array("value"=>"2","name"=>"High"),array("value"=>"1","name"=>"Medium"),array("value"=>"0","name"=>"Normal"),array("value"=>"-1","name"=>"Low"),array("value"=>"-2","name"=>"Lowest")),Array("onclick"=>"changeType();")); ?>
				<?php fieldCheckbox("private",$therecord["private"])?><label for="private">private</label>
			</p>
		</fieldset>

		<fieldset id="thedates">
			<legend>dates</legend>
			<p>
				<label for="startdate" id="starttext">start</label><br />
				<input name="dostart" id="startcheck" type="checkbox" value="1" <?php if($therecord["startdate"]) echo "checked=\"checked\"" ?> onclick="dateChecked('start')" class="radiochecks" />
				&nbsp;<?php fieldDatePicker("startdate",$therecord["startdate"],0,"",Array("size"=>"11","maxlength"=>"15","onchange"=>"checkEndDate();setEnglishDates()"));?>	
				&nbsp;<?php fieldTimePicker("starttime",$therecord["starttime"],0,"",Array("size"=>"11","maxlength"=>"15","onchange"=>"checkEndDate()"));?>
			</p>
			<p>
				<label for="enddate" id="endtext">end</label><br />
				<input name="doend" id="endcheck" type="checkbox" value="1" <?php if($therecord["enddate"]) echo "checked=\"checked\"" ?> onclick="dateChecked('end')" class="radiochecks" />
				&nbsp;<?php fieldDatePicker("enddate",$therecord["enddate"],0,"",Array("size"=>"11","maxlength"=>"15"));?>			
				&nbsp;<?php fieldTimePicker("endtime",$therecord["endtime"],0,"",Array("size"=>"11","maxlength"=>"15"));?>			
			</p>
		</fieldset>
		
		<div id="thecompleted" class="fauxP">
			<p>
				<input type="hidden" name="completedChange" id="completedChange" value="<?php echo $therecord["completed"]?>" />
				<?php fieldCheckbox("completed",$therecord["completed"],false,Array("onclick"=>"completedCheck()"))?>&nbsp;<label for="completed" id="completedtext">completed</label>
				&nbsp;<?php fieldDatePicker("completeddate",$therecord["completeddate"],0,"",Array("size"=>"11","maxlength"=>"15","readonly"=>"readonly"));?>
			</p>
			<p id="thestatus">
				<label for="status">status</label><br />
				<?php fieldChoiceList("status",$therecord["status"],"notestatus"); ?>				
			</p>			
		</div>
		
		<fieldset>
			<legend><label for="ds-assignedtoid">assigned to</label></legend>
			<p>
				<?php fieldAutofill("assignedtoid",$therecord["assignedtoid"],9,"users.id","concat(users.firstname,\" \",users.lastname)","\"\"","users.revoked=0",Array("size"=>"20","maxlength"=>"32")) ?>
				<input type="hidden" id="assignedtochange" name="assignedtochange" value="<?php echo $therecord["assignedtoid"] ?>" />
			</p>

			<?php if($therecord["assignedbyid"]!=0){ ?>
			<p>
				<label for="assignedbyid">assigned by</label><br />
				<input id="assignedbydisplay" value="<?php echo getUserName($therecord["assignedbyid"])?>" readonly="readonly" class="uneditable" />
			</p>
			<?php if($therecord["assignedbyid"]==$_SESSION["userinfo"]["id"]){?>
			<p>
				<button type="button" id="sendemailnotice" class="Buttons" onclick="sendEmailNotice('<?php echo $_SESSION["app_path"]?>')">send e-mail notice</button>
			</p>
			<?php } }?>
			<p>
				<label for="assignedtodate">follow up date</label><br />
				<?php fieldDatePicker("assignedtodate",$therecord["assignedtodate"],0,"Follow up date must be a valid date",Array("size"=>"11","maxlength"=>"15"),1);?>
				&nbsp;<?php fieldTimePicker("assignedtotime",$therecord["assignedtotime"],0,"Follow up time must be a valid time",Array("size"=>"11","maxlength"=>"15"),1);?>
			</p>
		</fieldset>
		
		<input id="attachedtabledefid" name="attachedtabledefid" type="hidden" value="<?php echo $therecord["attachedtabledefid"]?>" />
		<fieldset id="theassociated">
			<legend>associated with</legend>
				<p>
					<label for="assocarea">area</label><br />
					<input id="assocarea" type="text" readonly="readonly" class="uneditable" value="<?php echo $attachedtableinfo["displayname"];?>" />
				</p>
				
				
				<p>
					<label for="attachedid">record id</label><br />
					<input id="attachedid" name="attachedid" type="text" readonly="readonly" class="uneditable" value="<?php echo $therecord["attachedid"]?>" size="6" />&nbsp;
					<input name="link" type="button" class="Buttons" value=" go to record " onclick="document.location='<?php echo $_SESSION["app_path"]?><?php echo $attachedtableinfo["editfile"]."?id=".$therecord["attachedid"]; ?>'" />
				</p>
		</fieldset>


		<fieldset>
			<p>
				<label for="location">location</label><br />
				<input name="location" id="location" type="text" value="<?php echo $therecord["location"]?>"/>
			</p>
			
			<p>
				<label for="category">category</label><br />
				<?php fieldChoiceList("category",$therecord["category"],"notecategories"); ?>
			</p>
			
		</fieldset>
	</div>

	<div id="rightSideDiv">
		<fieldset>
			<legend><label for="content">memo</label></legend>
			<p align="right" id="timeStampDiv">
				<button id="timeStampButton" type="button" class="graphicButtons buttonTimeStamp" onclick="timeStamp();">Time Stamp</button>
			</p>
			<p>
				<textarea name="content" cols="45" rows="23" id="content"><?php echo htmlQuotes($therecord["content"])?></textarea>
				<input name="username" type="hidden" value="<?php echo $_SESSION["userinfo"]["firstname"]." ".$_SESSION["userinfo"]["lastname"]?>" />
			</p>
		</fieldset>
	</div>

	
	<div <?php if($therecord["parentid"]) echo "style=\"display:none;\""?>>
		<fieldset id="therepeat">
			<legend>recurrence</legend>
			<div class="fauxP">
				<input type="hidden" id="repeatchange" name="repeatChanges" value="<?php echo $therecord["repeatdays"]."*".$therecord["repeatfrequency"]."*".$therecord["repeattimes"]."*".$therecord["repeattype"]."*".$therecord["repeatuntildate"]?>" />
				<?php fieldCheckbox("repeat",$therecord["repeat"],false,array("onclick"=>"doRepeat()"))?><label for="repeat">repeat every</label>
				&nbsp;&nbsp;
				<div id="repeatoptions">						
					<?php fieldText("repeatfrequency",$therecord["repeatfrequency"],false,$message="The repeat frequency must be a valid integer","integer",array("size"=>"2","maxlength"=>"3","onkeyup"=>"addS(this)"))?>
					<?php 
						$plural="";
						if($therecord["repeatfrequency"]>1) $plural="s";
					?>
					<select id="repeattype" name="repeattype" onchange="changeRepeatType();">
						<option value="Daily" <?php if ($therecord["repeattype"]=="repeatDaily") echo "selected=\"selected\""?>>Day<?php echo $plural?></option>
						<option value="Weekly" <?php if ($therecord["repeattype"]=="repeatWeekly") echo "selected=\"selected\""?>>Week<?php echo $plural?></option>
						<option value="Monthly" <?php if (substr($therecord["repeattype"],0,13)=="repeatMonthly") echo "selected=\"selected\""?>>Month<?php echo $plural?></option>
						<option value="Yearly" <?php if ($therecord["repeattype"]=="repeatYearly") echo "selected=\"selected\""?>>Year<?php echo $plural?></option>
					</select><br />&nbsp;<br />
					
					<p id="weeklyoptions" <?php if ($therecord["repeattype"]!="repeatweekly"){?>style="display:none;"<?php }?>>
						<span id="wos" class="repeatWeekChecks"><input name="wosc" type="checkbox" value="s" <?php if(strpos(" ".$therecord["repeatdays"],"s",0)) echo "checked=\"checked\""?> class="radiochecks" />Sun</span>
						<span id="wom" class="repeatWeekChecks"><input name="womc" type="checkbox" value="m" <?php if(strpos(" ".$therecord["repeatdays"],"m",0)) echo "checked=\"checked\""?> class="radiochecks" />Mon</span>
						<span id="wot" class="repeatWeekChecks"><input name="wotc" type="checkbox" value="t" <?php if(strpos(" ".$therecord["repeatdays"],"t",0)) echo "checked=\"checked\""?> class="radiochecks" />Tue</span>
						<span id="wow" class="repeatWeekChecks"><input name="wowc" type="checkbox" value="w" <?php if(strpos(" ".$therecord["repeatdays"],"w",0)) echo "checked=\"checked\""?> class="radiochecks" />Wed</span>
						<span id="wor" class="repeatWeekChecks"><input name="worc" type="checkbox" value="r" <?php if(strpos(" ".$therecord["repeatdays"],"r",0)) echo "checked=\"checked\""?> class="radiochecks" />Thu</span>
						<span id="wof" class="repeatWeekChecks"><input name="wofc" type="checkbox" value="f" <?php if(strpos(" ".$therecord["repeatdays"],"f",0)) echo "checked=\"checked\""?> class="radiochecks" />Fri</span>
						<span id="woa" class="repeatWeekChecks"><input name="woac" type="checkbox" value="a" <?php if(strpos(" ".$therecord["repeatdays"],"a",0)) echo "checked=\"checked\""?> class="radiochecks" />Sat</span>
					</p>
					<p id="monthlyoptions" style=" <?php if (substr($therecord["repeattype"],0,13)!="repeatMonthly"){?>display:none;<?php }?>margin-bottom:5px;">
						<input type="radio" class="radiochecks" name="rpmo" id="rpmobdt" value="byDate" <?php if (substr($therecord["repeattype"],13)=="byDate"){?>checked<?php }?>/>On the <span id="rpmobydate"></span> of the month.<br />
						<input type="radio" class="radiochecks" name="rpmo" id="rpmobda" value="byDay" <?php if (substr($therecord["repeattype"],13)=="byDay"){?>checked<?php }?>/><span id="rpmobyday"></span> of the month.
					</p>
					<p id="rpuntilforever">
						<input id="rprduntilforever" class="radiochecks" name="rpuntil" type="radio" <?php if($therecord["repeattimes"]==0) echo "checked=\"checked\"" ?> value="0" onclick="updateRepeatUntil()"/> <label for="rprduntilforever">forever</label>
					</p>
					<p id="rpuntiltimes">
						<input id="rprduntilftimes" class="radiochecks" name="rpuntil" type="radio" <?php if($therecord["repeattimes"]>0) echo "checked=\"checked\"" ?> value="1" onclick="updateRepeatUntil()" /> <label for="rprduntilftimes">number of times</label>&nbsp;&nbsp;
						<?php 
						$tempvalue="";
						$attribs=array("size"=>"2","maxlength"=>"3");				
						if($therecord["repeattimes"]<1){
							$attribs["class"]="uneditable";
							$attribs["readonly"]="readonly";					
						}
						if($therecord["repeattimes"]>0) $tempvalue=$therecord["repeattimes"];
						fieldText("repeattimes",$tempvalue,false,$message="The number of times to repeat must be a valid integer","integer",$attribs)?>
					</p>
					<p id="rpuntildate">
						<input id="rprduntildate" class="radiochecks" name="rpuntil" type="radio" <?php if($therecord["repeattimes"]==-1) echo "checked=\"checked\"" ?> value="-1" onclick="updateRepeatUntil()"/> <label for="rprduntildate">until</label>&nbsp;&nbsp;
						<?php fieldDatePicker("repeatuntildate",$therecord["repeatuntildate"],0,"",Array("size"=>"11","maxlength"=>"15"));?>
					</p>
				</div>
			</div>

		</fieldset>
	</div>
	<fieldset id="hasparent" class="box small" <?php if(!$therecord["parentid"]) echo "style=\"display:none;\""?>>
		<legend>recurrence</legend>
		<div>
		This task/event was created from a repeated task/event.  <br />
		Click the <strong>Edit Repeating Options</strong> button to edit the options for the repeatable parent record. 
		<br />
		(Any unsaved changes with the current record will be lost.)
		</div>
		<div><input id="goparent" name="goparent" type="button" value="Edit Repeating Options..." onclick="goParent('<?php echo getAddEditFile(12) ?>')" class="Buttons" /></div>
	</fieldset>
	<?php include("../../include/createmodifiedby.php"); ?>
</div>
<?php include("../../footer.php")?>
</form>
</body>
</html>