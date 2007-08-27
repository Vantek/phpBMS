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

function showSystemMessages($db){
	$querystatement="SELECT notes.id,subject,content,concat(users.firstname,\" \",users.lastname) as createdby,
					notes.creationdate
					FROM notes INNER JOIN users ON notes.createdby=users.id
					WHERE type=\"SM\" ORDER BY importance DESC,notes.creationdate";
					
	$queryresult=$db->query($querystatement);
		
	if($db->numRows($queryresult)){ 
	?>
	<div class="box" id="systemMessageContainer">	
		<h2>System Messages</h2>
		<?php while($therecord=$db->fetchArray($queryresult)) {
				$therecord["content"]=str_replace("\n","<br />",htmlQuotes($therecord["content"]));
		?>
		<h3 class="systemMessageLinks"><?php echo htmlQuotes($therecord["subject"])?> <span>[ <?php echo htmlQuotes(formatFromSQLDateTime($therecord["creationdate"]))?> <?php echo htmlQuotes($therecord["createdby"])?>]</span></h3>			
		<div class="systemMessages">
			<p><?php echo $therecord["content"]?></p>
		</div>						
		<?php }//end while ?>
	</div>
	<?php } 
}


function showTasks($db,$userid,$type="Tasks"){

	global $phpbms;

	$querystatement="SELECT id,type,subject, completed, if(enddate < CURDATE(),1,0) as ispastdue, startdate, enddate, private, assignedbyid, assignedtoid
				FROM notes
				WHERE ";
	switch($type){
		case "Tasks":
			$querystatement.=" type=\"TS\" AND (private=0 or (private=1 and createdby=".$userid.")) 
							   AND (completed=0 or (completed=1 and completeddate=CURDATE()))
							   AND (assignedtoid is null or assignedtoid=0)";
			$title="Tasks";
			$sec=3;
		break;
		case "ReceivedAssignments":
			$querystatement.=" assignedtoid=".$userid." AND (completed=0 or (completed=1 and completeddate=CURDATE()))";
			$title="Assignments";
			$sec=1;
		break;
		case "GivenAssignments":
			$querystatement.=" assignedbyid=".$userid." AND (completed=0 or (completed=1 and completeddate=CURDATE()))";
			$title="Delegations";
			$sec=2;
		break;
	}
	$querystatement.="AND (
					(startdate is null AND enddate is null) OR
					(startdate is not null AND startdate <= DATE_ADD(CURDATE(),INTERVAL 7 DAY)) OR
					(enddate is not null AND enddate <= DATE_ADD(CURDATE(),INTERVAL 7 DAY)) 
				   )";

	$querystatement.=" ORDER BY importance DESC,notes.enddate,notes.endtime,notes.startdate DESC,notes.starttime DESC,notes.creationdate DESC";


	$queryresult=$db->query($querystatement);
	
	?>
	<h3 class="tasksLinks"><?php echo $title; if($db->numRows($queryresult)) {?> <span class="small">(<?php echo $db->numRows($queryresult)?>)</span><?php } ?></h3>
	<div class="tasksDivs"><div>
	<?php
	
	if($db->numRows($queryresult)){ 	
		while($therecord=$db->fetchArray($queryresult)) {
		$className="task";		
		if($therecord["completed"]) 
			$className.=" taskCompleted";
		else if($therecord["ispastdue"]) 
			$className.=" taskPastDue";
		if($therecord["private"]) $className.=" taskPrivate";
		
	?>
	<p id="TS<?php echo $therecord["id"]?>" class="small <?php echo $className?>">
		<input type="hidden" id="TSprivate<?php echo $therecord["id"]?>" value="<?php echo $therecord["private"]?>"/>
		<input type="hidden" id="TSispastdue<?php echo $therecord["id"]?>" value="<?php echo $therecord["ispastdue"]?>"/>
		<input class="radiochecks" id="TSC<?php echo $therecord["id"]?>" name="TSC<?php echo $therecord["id"]?>" type="checkbox" value="1" <?php if($therecord["completed"]) echo "checked=\"checked\""?> onclick="checkTask(<?php echo $therecord["id"]?>,'<?php echo $therecord["type"]?>')" align="middle"/>
		<a href="<?php echo getAddEditFile($db,12)."?id=".$therecord["id"]?>&amp;backurl=snapshot.php"><?php echo htmlQuotes($therecord["subject"])?></a>
		<?php if($type=="Tasks") if($therecord["enddate"]) {?><em class="small">(<?php echo htmlQuotes(formatFromSQLDate($therecord["enddate"])) ?>)</em><?php } ?>
		<?php if($type!="Tasks"){?> <em>(<?php if($type=="ReceivedAssignments") $tid=$therecord["assignedbyid"]; else $tid=$therecord["assignedtoid"]; echo htmlQuotes($phpbms->getUserName($tid))?>)</em><?php } ?>
	</p>
	<?php } } else {
	?><p class="small disabledtext">no <?php echo strtolower($title)?></p><?php
	}?></div></div> <?php 
}

function showSevenDays($userid,$db){
	
	$theday=mktime(0,0,0);
	
	$repeatArray =getRepeatableInTime($theday,strtotime("7 days",$theday),$userid,$db);
	
	$today="Today - (";
	$rownum=0;
	?><table border="0" cellspacing="0" cellpadding="0" width="100%"><?php
	for($i=0;$i<7;$i++){
		?><tr><td colspan="2" class="eventDayName"><?php echo $today.strftime("%A",$theday); if($today){echo ")"; $today="";}?></td></tr><?php 
		$donext=true;

		$queryresult=getEventsForDay($theday,$userid,$repeatArray[$theday],$db);
		if ($db->numRows($queryresult)){
			while($therecord=$db->fetchArray($queryresult)){
				$times=formatFromSQLTime($therecord["starttime"])."&nbsp;";
				if($therecord["endtime"]){
					$times.= "- ";
					if($therecord["startdate"]!=$therecord["enddate"])
						$times.=formatFromSQLDate($therecord["enddate"])." ";
					$times.=formatFromSQLTime($therecord["endtime"])." ";
				}
				?><tr>
					<td class="small event" nowrap="nowrap" valign="top"><?php echo $times?></td>
					<td class="small event" valign="top" width="100%"><a href="<?php echo getAddEditFile($db,12)."?id=".$therecord["id"]?>&amp;backurl=snapshot.php"><?php echo htmlQuotes($therecord["subject"])?></a></td>
				</tr><?php
			}
		} else {
			?><tr><td colspan="2" class="small event disabledtext">no events</td></tr><?php		
		}		
						
		$theday=strtotime("tomorrow",$theday);
	}//end for
	?></table><?php
	
}

function getRepeatableInTime($fromdate,$todate,$userid,$db){
	
	//first we create the array
	$theday=$fromdate;
	$repeatList=false;
	while ($theday<$todate){
		$repeatList[$theday]=array();
		$theday=strtotime("tomorrow",$theday);
	}
	
	$querystatement="SELECT id,startdate,repeatdays,repeatfrequency,repeattimes,repeattype,repeatuntildate FROM notes WHERE `repeat`=1 AND type=\"EV\" AND (private=0 or (private=1 and createdby=".$userid."))";
	$queryresult=$db->query($querystatement);
	
	while($therecord=$db->fetchArray($queryresult)){		
		$startdate=stringToDate($therecord["startdate"],"SQL");
		$repeatuntil=stringToDate($therecord["repeatuntildate"],"SQL");

		foreach($repeatList as $targetdate=>$unused){
			if($therecord["repeattimes"]!=-1 || $repeatuntil>=$targetdate){
				$rpTimes=0;				
				$testdate=$startdate;
				switch($therecord["repeattype"]){
					case "repeatDaily":
						while($testdate<$targetdate && ($therecord["repeattimes"]<=0 || $therecord["repeattimes"]>$rpTimes)){
							$testdate=strtotime($therecord["repeatfrequency"]." days",$testdate);
							if($testdate==$targetdate)
								$repeatList[$targetdate][]=$therecord["id"];
							$rpTimes++;
						}
					break;
					case "repeatYearly":
						while($testdate<$targetdate && ($therecord["repeattimes"]<=0 || $therecord["repeattimes"]>$rpTimes)){
							$testdate=strtotime($therecord["repeatfrequency"]." years",$testdate);
							if($testdate==$targetdate)
								$repeatList[$targetdate][]=$therecord["id"];
							$rpTimes++;
						}
					break;
					case "repeatMonthlybyDate":
						while($testdate<$targetdate && ($therecord["repeattimes"]<=0 || $therecord["repeattimes"]>$rpTimes)){
							$testdate=strtotime($therecord["repeatfrequency"]." months",$testdate);
							if($testdate==$targetdate)
								$repeatList[$targetdate][]=$therecord["id"];
							$rpTimes++;
						}
					case "repeatMonthlybyDay":
						$testWeekNum=ceil(strftime("%d",$startdate)/7);
						$targetLastDay=date("t",$targetdate);
						while($testdate<$targetdate && ($therecord["repeattimes"]<=0 || $therecord["repeattimes"]>$rpTimes)){
							$testdate=strtotime($therecord["repeatfrequency"]." months",$testdate);
							$targetWeekNum=ceil(strftime("%d",$targetdate)/7);
														
							if(strftime("%m %Y",$testdate)==strftime("%m %Y",$targetdate) && ($testWeekNum==$targetWeekNum || ($testWeekNum==5 && strftime("%d",$targetdate)+7>$targetLastDay)) && strftime("%A",$startdate)==strftime("%A",$targetdate))
								$repeatList[$targetdate][]=$therecord["id"];
							$rpTimes++;
						}
					case "repeatWeekly":
						while($testdate<$targetdate && ($therecord["repeattimes"]<=0 || $therecord["repeattimes"]>$rpTimes)){
							$testdate=strtotime($therecord["repeatfrequency"]." weeks",$testdate);
							
							if(strftime("%W %Y",$testdate)==strftime("%W %Y",$targetdate)){
								$dayAbbrev="";
								switch(strftime("%A",$targetdate)){
									case "Sunday":
										$dayAbbrev="s";
									break;
									case "Monday":
										$dayAbbrev="m";
									break;
									case "Tuesday":
										$dayAbbrev="t";
									break;
									case "Wednesday":
										$dayAbbrev="w";
									break;
									case "Thursday":
										$dayAbbrev="r";
									break;
									case "Friday":
										$dayAbbrev="f";
									break;
									case "Saturday":
										$dayAbbrev="a";
									break;
									
								}
								if (strpos(" ".$therecord["repeatdays"],$dayAbbrev))
									$repeatList[$targetdate][]=$therecord["id"];
							}
							$rpTimes++;
						}
					break;
				}//end switch
			}//end if
		}//end foreach (day)
	}//end while (record)
	return $repeatList;
}

function getEventsForDay($day,$userid,$repeatArray,$db){
	
	$repeatIDs="";
	if(count($repeatArray)){
		$repeatIDs=" OR notes.id in(";
		foreach($repeatArray as $id)
			$repeatIDs.=$id.", ";
		$repeatIDs=substr($repeatIDs,0,strlen($repeatIDs)-2);
		$repeatIDs.=") ";
	}
	$querystatement="SELECT DISTINCT id,subject, startdate,enddate,
				starttime,
				endtime
				FROM notes
				WHERE type=\"EV\" AND (startdate=\"".dateToString($day,"SQL")."\" ".$repeatIDs.") AND (private=0 or (private=1 and createdby=".$userid.")) 
				ORDER BY notes.starttime,notes.endtime,importance DESC";

	$queryresult=$db->query($querystatement);
	
	return $queryresult;
}
?>

