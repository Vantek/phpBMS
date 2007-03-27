UPDATE menu SET link="", parentid=0, displayorder=4, accesslevel=90 WHERE id="15";
INSERT INTO `menu` (name,link,parentid,displayorder,createdby,modifiedby,creationdate,modifieddate,accesslevel) VALUES ('settings','modules/base/adminsettings.php',15,10,2,2,'2006-10-16 05:19:30','2006-10-19 21:32:14',90);
INSERT INTO `menu` (name,link,parentid,displayorder,createdby,modifiedby,creationdate,modifieddate,accesslevel) VALUES ('modules','search.php?id=21',15,99,2,2,'2006-10-16 05:20:31','2006-10-19 21:32:53',90);
INSERT INTO `menu` (name,link,parentid,displayorder,createdby,modifiedby,creationdate,modifieddate,accesslevel) VALUES ('menu','search.php?id=19',15,30,2,2,'2006-10-16 05:21:14','2006-10-19 21:33:14',90);
INSERT INTO `menu` (name,link,parentid,displayorder,createdby,modifiedby,creationdate,modifieddate,accesslevel) VALUES ('table definitions','search.php?id=11',15,80,2,2,'2006-10-16 05:21:59','2006-10-19 21:33:59',90);
INSERT INTO `menu` (name,link,parentid,displayorder,createdby,modifiedby,creationdate,modifieddate,accesslevel) VALUES ('files','search.php?id=26',15,30,2,2,'2006-10-16 05:22:31','2006-10-19 21:34:08',90);
INSERT INTO `menu` (name,link,parentid,displayorder,createdby,modifiedby,creationdate,modifieddate,accesslevel) VALUES ('users','search.php?id=9',15,20,2,2,'2006-10-16 05:23:27','2006-10-19 21:32:36',90);
INSERT INTO `menu` (name,link,parentid,displayorder,createdby,modifiedby,creationdate,modifieddate,accesslevel) VALUES ('----','N/A',15,15,2,2,'2006-10-19 15:26:58','2006-10-19 21:33:32',90);
INSERT INTO `menu` (name,link,parentid,displayorder,createdby,modifiedby,creationdate,modifieddate,accesslevel) VALUES ('reports','search.php?id=16',15,50,2,2,'2006-10-19 15:42:58','2006-10-19 21:43:19',-90);
INSERT INTO `menu` (name,link,parentid,displayorder,createdby,modifiedby,creationdate,modifieddate,accesslevel) VALUES ('relationships','search.php?id=10',15,60,2,2,'2006-10-19 15:44:10','2006-10-19 21:44:10',90);
INSERT INTO `menu` (name,link,parentid,displayorder,createdby,modifiedby,creationdate,modifieddate,accesslevel) VALUES ('Saved Searchs/Sorts','search.php?id=17',15,40,2,2,'2006-10-19 15:44:54','2006-10-19 21:44:54',90);
INSERT INTO `menu` (name,link,parentid,displayorder,createdby,modifiedby,creationdate,modifieddate,accesslevel) VALUES ('----','N/A',15,45,2,2,'2006-10-19 15:45:18','2006-10-19 21:45:18',90);
ALTER TABLE tablecolumns CHANGE COLUMN `format` `format` enum('date','time','currency','boolean','datetime','filelink','noencoding') default NULL;
UPDATE tablecolumns SET format="noencoding" WHERE `column` like "%<%";
UPDATE tablecolumns SET name="inherent" WHERE id=93;
ALTER TABLE users ADD COLUMN admin tinyint(4) NOT NULL DEFAULT 0;
ALTER TABLE users ADD COLUMN portalaccess tinyint(4) NOT NULL DEFAULT 0;
CREATE TABLE `roles` (`id` INTEGER UNSIGNED DEFAULT NULL AUTO_INCREMENT, `name` VARCHAR(64) NOT NULL,`description` TEXT,`inactive` tinyint(4) NOT NULL,`createdby` INTEGER UNSIGNED,`creationdate` DATETIME,`modifiedby` INTEGER UNSIGNED,`modifieddate` TIMESTAMP,PRIMARY KEY(`id`))TYPE = MyISAM;
INSERT INTO `roles` (`id`,`name`,`description`,`inactive`,`createdby`,`creationdate`,`modifiedby`) VALUES (10,'shipping','Basic user access only.',0,1,NOW(),1);
INSERT INTO `roles` (`id`,`name`,`description`,`inactive`,`createdby`,`creationdate`,`modifiedby`) VALUES (20,'sales','Power User.',0,1,NOW(),1);
INSERT INTO `roles` (`id`,`name`,`description`,`inactive`,`createdby`,`creationdate`,`modifiedby`) VALUES (30,'sales manager','',0,1,NOW(),1);
INSERT INTO `roles` (`id`,`name`,`description`,`inactive`,`createdby`,`creationdate`,`modifiedby`) VALUES (50,'upper manager','',0,1,NOW(),1);
CREATE TABLE `rolestousers` (`id` INTEGER UNSIGNED NOT NULL AUTO_INCREMENT, `userid` INTEGER UNSIGNED NOT NULL, `roleid` INTEGER UNSIGNED NOT NULL, PRIMARY KEY(`id`)) TYPE = MYISAM;
UPDATE users SET admin=1 WHERE accesslevel>=90;
UPDATE users SET portalaccess=1 WHERE accesslevel<0;
UPDATE users set accesslevel=0 WHERE  accesslevel<0 or accesslevel>=90;
ALTER TABLE menu CHANGE accesslevel roleid int(11) NOT NULL default '0';
UPDATE tablecolumns SET name='access', `column`='if(menu.roleid=0,\'EVERYONE\',if(menu.roleid=-100,\'Administrators\',roles.name))',sortorder='' WHERE id=88;
UPDATE tabledefs SET querytable="((menu LEFT JOIN menu as parentmenu on menu.parentid=parentmenu.id) LEFT JOIN roles on menu.roleid=roles.id)" WHERE id=19;
UPDATE menu SET roleid=0 WHERE roleid<0;
UPDATE menu SET roleid=-100 WHERE roleid>=90;
UPDATE menu SET roleid=-100 WHERE parentid=15;
UPDATE menu SET roleid=0 WHERE parentid=14 or id=14;
ALTER TABLE tabledefs ADD COLUMN searchroleid int(11) NOT NULL DEFAULT 0;
ALTER TABLE tabledefs ADD COLUMN addroleid int(11) NOT NULL DEFAULT 0;
ALTER TABLE tabledefs ADD COLUMN editroleid int(11) NOT NULL DEFAULT 0;
ALTER TABLE tabledefs ADD COLUMN advsearchroleid int(11) NOT NULL DEFAULT -100;
ALTER TABLE tabledefs ADD COLUMN viewsqlroleid int(11) NOT NULL DEFAULT -100;
UPDATE tabledefs set searchroleid=-100,addroleid=-100,editroleid=-100 WHERE moduleid=1 AND id IN(21,26,19,10,11,9,200,17);
UPDATE tableoptions set accesslevel=0 WHERE accesslevel <0;
UPDATE tableoptions set accesslevel=-100 WHERE accesslevel >=90;
ALTER TABLE tableoptions CHANGE accesslevel roleid int(11) NOT NULL default '0';
UPDATE tablefindoptions set accesslevel=0 WHERE accesslevel <0;
UPDATE tablefindoptions set accesslevel=0 WHERE accesslevel =11;
UPDATE tablefindoptions set accesslevel=-100 WHERE accesslevel >=90;
ALTER TABLE tablefindoptions CHANGE accesslevel roleid int(11) NOT NULL default '0';
UPDATE files set accesslevel=0 WHERE accesslevel <0;
UPDATE files set accesslevel=-100 WHERE accesslevel >=90;
ALTER TABLE files CHANGE accesslevel roleid int(11) NOT NULL default '0';
UPDATE usersearches set accesslevel=0 WHERE accesslevel <0;
UPDATE usersearches set accesslevel=-100 WHERE accesslevel >=90;
ALTER TABLE usersearches CHANGE accesslevel roleid int(11) NOT NULL default '0';
UPDATE reports set accesslevel=0 WHERE accesslevel <0;
UPDATE reports set accesslevel=-100 WHERE accesslevel >=90;
ALTER TABLE reports CHANGE accesslevel roleid int(11) NOT NULL default '0';
INSERT INTO `settings` (`name`, `value`) VALUES ('phone_format','US - Loose');
UPDATE `menu` SET `name` ='configuration', `roleid` =90 WHERE `name` ='settings';
UPDATE `menu` SET `name` ='Settings', `roleid` =0 WHERE `name` ='Admin';
INSERT INTO `menu` (`name`, `link`, `parentid`, `displayorder`, `createdby`, `modifiedby`, `creationdate`, `modifieddate`, `roleid`) VALUES ('my account','modules/base/myaccount.php',15,-10,1,1,NOW(),NOW(),0);
INSERT INTO `menu` (`name`, `link`, `parentid`, `displayorder`, `createdby`, `modifiedby`, `creationdate`, `modifieddate`, `roleid`) VALUES ('----','',15,-5,1,1,NOW(),NOW(),90);
INSERT INTO `settings` (`name`, `value`) VALUES ('date_format','English, US');
INSERT INTO `settings` (`name`, `value`) VALUES ('time_format','12 Hour');
INSERT INTO `settings` (`name`, `value`) VALUES ('currency_accuracy','2');
INSERT INTO `settings` (`name`, `value`) VALUES ('currency_symbol','$');
INSERT INTO `settings` (`name`, `value`) VALUES ('decimal_symbol','.');
INSERT INTO `settings` (`name`, `value`) VALUES ('thousands_separator',',');
INSERT INTO `settings` (`name`, `value`) VALUES ('demo_enabled','false');
CREATE TABLE `scheduler` (`id` INTEGER UNSIGNED NOT NULL AUTO_INCREMENT, `name` varchar(45) default NULL, `job` varchar(128) default NULL, `crontab` varchar(64) default NULL, `lastrun` datetime default NULL, `startdatetime` datetime NOT NULL, `enddatetime` datetime default NULL, `description` text, `inactive` tinyint(3) unsigned NOT NULL default '0', `createdby` int(10) unsigned default NULL, `creationdate` datetime default NULL, `modifiedby` int(10) unsigned default NULL, `modifieddate` timestamp NOT NULL, PRIMARY KEY  (`id`), KEY `inactivated` (`inactive`), KEY `startdate` (`startdatetime`), KEY `enddate` (`enddatetime`));
INSERT INTO `tabledefs` (`id`, `displayname`, `type`, `moduleid`, `maintable`, `querytable`, `editfile`, `editroleid`, `addfile`, `addroleid`, `searchroleid`, `advsearchroleid`, `viewsqlroleid`, `deletebutton`, `defaultwhereclause`, `defaultsortorder`, `defaultsearchtype`, `defaultcriteriafindoptions`, `defaultcriteriaselection`, `createdby`, `creationdate`, `modifiedby`, `modifieddate`) VALUES (201,'Scheduler','system',1,'scheduler','scheduler','modules/base/scheduler_addedit.php',-100,'modules/base/scheduler_addedit.php',-100,-100,-100,-100,'delete','scheduler.id!=0','scheduler.name','','','',1,NOW(),1,NOW());
INSERT INTO `tablefindoptions` (`tabledefid`, `name`, `search`, `displayorder`, `roleid`) VALUES (201,'all records','scheduler.id!=0',0,0);
INSERT INTO `tableoptions` (`tabledefid`, `name`, `option`, `othercommand`, `roleid`) VALUES (201,'new','1',0,0);
INSERT INTO `tableoptions` (`tabledefid`, `name`, `option`, `othercommand`, `roleid`) VALUES (201,'select','1',0,0);
INSERT INTO `tableoptions` (`tabledefid`, `name`, `option`, `othercommand`, `roleid`) VALUES (201,'edit','1',0,0);
INSERT INTO `tableoptions` (`tabledefid`, `name`, `option`, `othercommand`, `roleid`) VALUES (201,'printex','0',0,0);
INSERT INTO `tableoptions` (`tabledefid`, `name`, `option`, `othercommand`, `roleid`) VALUES (201,'inactivate','inactivate',1,0);
INSERT INTO `tableoptions` (`tabledefid`, `name`, `option`, `othercommand`, `roleid`) VALUES (201,'runSelected','run job(s)',1,0);
INSERT INTO `tablecolumns` (`tabledefid`, `name`, `column`, `align`, `footerquery`, `displayorder`, `sortorder`, `wrap`, `size`, `format`) VALUES (201,'name','scheduler.name','left','',0,'',0,'95%',NULL);
INSERT INTO `tablecolumns` (`tabledefid`, `name`, `column`, `align`, `footerquery`, `displayorder`, `sortorder`, `wrap`, `size`, `format`) VALUES (201,'cron interval','scheduler.crontab','left','',1,'',0,'',NULL);
INSERT INTO `tablecolumns` (`tabledefid`, `name`, `column`, `align`, `footerquery`, `displayorder`, `sortorder`, `wrap`, `size`, `format`) VALUES (201,'inactive','scheduler.inactive','center','',2,'',0,'','boolean');
INSERT INTO `tablesearchablefields` (`tabledefid`, `field`, `name`, `displayorder`, `type`) VALUES (201,'scheduler.name','name',0,'field');
INSERT INTO `menu` (`name`, `link`, `parentid`, `displayorder`, `createdby`, `modifiedby`, `creationdate`, `modifieddate`, `roleid`) VALUES ('scheduler','search.php?id=201',15,32,1,1,NOW(),NOW(),-100);
CREATE TABLE `log` (`id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT, `type` VARCHAR(25), `userid` INTEGER UNSIGNED, `ip` VARCHAR(45), `value` TEXT, `stamp` TIMESTAMP, PRIMARY KEY(`id`));
INSERT INTO `users` (`id`, `login`, `password`, `firstname`, `lastname`, `creationdate`, `revoked`, `createdby`, `modifiedby`, `lastlogin`, `modifieddate`, `email`, `phone`, `department`, `employeenumber`, `admin`, `portalaccess`) VALUES (-2,'Scheduler','�t%�B�Tv:$�Rt�`','phpBMS','Scheduler',NOW(),0,1,1,NULL,NOW(),'','','','',0,1);
INSERT INTO `menu` (`name`, `link`, `parentid`, `displayorder`, `createdby`, `modifiedby`, `creationdate`, `modifieddate`, `roleid`) VALUES ('system log','search.php?id=202',15,11,1,1,NOW(),NOW(),-100);
INSERT INTO `tabledefs` (`id`, `displayname`, `type`, `moduleid`, `maintable`, `querytable`, `editfile`, `editroleid`, `addfile`, `addroleid`, `searchroleid`, `advsearchroleid`, `viewsqlroleid`, `deletebutton`, `defaultwhereclause`, `defaultsortorder`, `defaultsearchtype`, `defaultcriteriafindoptions`, `defaultcriteriaselection`, `createdby`, `creationdate`, `modifiedby`, `modifieddate`) VALUES (202,'System Log','system',1,'log','log LEFT JOIN users ON log.userid=users.id','N/A',-100,'N/A',-100,-100,-100,-100,'delete','log.stamp> DATE_SUB(CURDATE(),INTERVAL 1 DAY)','log.stamp','','','',1,NOW(),1,NOW());
INSERT INTO `tablecolumns` (`tabledefid`, `name`, `column`, `align`, `footerquery`, `displayorder`, `sortorder`, `wrap`, `size`, `format`) VALUES (202,'time','log.stamp','left','',1,'',0,'','datetime');
INSERT INTO `tablecolumns` (`tabledefid`, `name`, `column`, `align`, `footerquery`, `displayorder`, `sortorder`, `wrap`, `size`, `format`) VALUES (202,'id','log.id','left','',0,'',0,'',NULL);
INSERT INTO `tablecolumns` (`tabledefid`, `name`, `column`, `align`, `footerquery`, `displayorder`, `sortorder`, `wrap`, `size`, `format`) VALUES (202,'type','log.type','left','',2,'',0,'',NULL);
INSERT INTO `tablecolumns` (`tabledefid`, `name`, `column`, `align`, `footerquery`, `displayorder`, `sortorder`, `wrap`, `size`, `format`) VALUES (202,'value','log.value','left','',3,'',1,'90%',NULL);
INSERT INTO `tablecolumns` (`tabledefid`, `name`, `column`, `align`, `footerquery`, `displayorder`, `sortorder`, `wrap`, `size`, `format`) VALUES (202,'user','concat(users.firstname,\" \",users.lastname)','left','',4,'',0,'',NULL);
INSERT INTO `tablecolumns` (`tabledefid`, `name`, `column`, `align`, `footerquery`, `displayorder`, `sortorder`, `wrap`, `size`, `format`) VALUES (202,'ip address','log.ip','left','',5,'',0,'',NULL);
INSERT INTO `tablefindoptions` (`tabledefid`, `name`, `search`, `displayorder`, `roleid`) VALUES (202,'entries within last day','log.stamp> DATE_SUB(CURDATE(),INTERVAL 1 DAY)',0,0);
INSERT INTO `tablefindoptions` (`tabledefid`, `name`, `search`, `displayorder`, `roleid`) VALUES (202,'entries within last week','log.stamp> DATE_SUB(CURDATE(),INTERVAL 1 WEEK)',1,0);
INSERT INTO `tablefindoptions` (`tabledefid`, `name`, `search`, `displayorder`, `roleid`) VALUES (202,'all entries','lg.id!=-1',2,0);
INSERT INTO `tableoptions` (`tabledefid`, `name`, `option`, `othercommand`, `roleid`) VALUES (202,'new','0',0,0);
INSERT INTO `tableoptions` (`tabledefid`, `name`, `option`, `othercommand`, `roleid`) VALUES (202,'select','1',0,0);
INSERT INTO `tableoptions` (`tabledefid`, `name`, `option`, `othercommand`, `roleid`) VALUES (202,'edit','0',0,0);
INSERT INTO `tableoptions` (`tabledefid`, `name`, `option`, `othercommand`, `roleid`) VALUES (202,'printex','0',0,0);
INSERT INTO `tablesearchablefields` (`tabledefid`, `field`, `name`, `displayorder`, `type`) VALUES (202,'log.type','type',0,'field');
INSERT INTO `tablesearchablefields` (`tabledefid`, `field`, `name`, `displayorder`, `type`) VALUES (202,'log.ip','ip address',1,'field');