ALTER TABLE `attachments` ENGINE=INNODB;
ALTER TABLE `choices` ENGINE=INNODB;
ALTER TABLE `files` ENGINE=INNODB;
ALTER TABLE `log` ENGINE=INNODB;
ALTER TABLE `menu` ENGINE=INNODB;
ALTER TABLE `menu` ADD COlUMN `uuid` varchar(64) NOT NULL, MODIFY COLUMN `parentid` varchar(64) NOT NULL DEFAULT '0';
ALTER TABLE `modules` ENGINE=INNODB;
ALTER TABLE `notes` ENGINE=INNODB;
ALTER TABLE `notes` MODIFY COLUMN `type` CHAR(2) NOT NULL DEFAULT 'NT';
ALTER TABLE `relationships` ENGINE=INNODB;
ALTER TABLE `reports` ENGINE=INNODB;
ALTER TABLE `reports` MODIFY COLUMN `reportfile` VARCHAR(128) NOT NULL;
UPDATE `reports` SET `description` = 'This report will generate a comma-delimited text file. Values are encapsulated in quotes, and the first line lists the field names.' WHERE `name` = 'Raw Table Export';
ALTER TABLE `roles` ENGINE=INNODB;
ALTER TABLE `roles` MODIFY COLUMN `inactive` TINYINT(4) NOT NULL DEFAULT 0;
ALTER TABLE `rolestousers` ENGINE=INNODB;
ALTER TABLE `scheduler` ENGINE=INNODB;
INSERT INTO `scheduler` (`name`, `job`, `crontab`, `lastrun`, `startdatetime`, `enddatetime`, `description`, `inactive`, `createdby`, `creationdate`, `modifiedby`, `modifieddate`) VALUES ('Clean Import Files', './scheduler_delete_tempimport.php', '30::*::*::*::*', NULL, NOW(), NULL, 'This will delete any temporary import files that are present (for whatever reason) after 30 minutes of their creation.', '0', 1, NOW(), 1, NOW());
INSERT INTO `scheduler` (`id`, `name`, `job`, `crontab`, `lastrun`, `startdatetime`, `enddatetime`, `description`, `inactive`, `createdby`, `creationdate`, `modifiedby`, `modifieddate`) VALUES ('4', 'Remove Excess System Log Records', './scheduler_delete_logs.php', '*::24::*::*::*', NULL, '2009-03-31 12:00:00', NULL, 'This script will trim the system log when there are more than 2000 records present at the time of its calling (default will be every 24 hours).', '0', 1, NOW(), 1, NOW());
ALTER TABLE `settings` ENGINE=INNODB;
ALTER TABLE `smartsearches` ENGINE=INNODB;
ALTER TABLE `tablecolumns` ENGINE=INNODB;
ALTER TABLE `tabledefs` ENGINE=INNODB;
ALTER TABLE `tabledefs` ADD COLUMN `importfile` VARCHAR(128) DEFAULT NULL AFTER `addroleid`, ADD COLUMN `importroleid` int(11) NOT NULL DEFAULT '-100' AFTER `importfile`, ADD COLUMN `canpost` tinyint(4) NOT NULL default '0' AFTER `deletebutton`, ADD COLUMN `hascustomfields` tinyint(4) NOT NULL default '0' AFTER `canpost`;
ALTER TABLE `tabledefs` MODIFY COLUMN `defaultwhereclause` TEXT DEFAULT NULL, MODIFY COLUMN `defaultsortorder` TEXT;
ALTER TABLE `tablefindoptions` ENGINE=INNODB;
ALTER TABLE `tablefindoptions` MODIFY COLUMN `search` TEXT NOT NULL;
ALTER TABLE `tablegroupings` ENGINE=INNODB;
ALTER TABLE `tableoptions` ENGINE=INNODB;
ALTER TABLE `tableoptions` ADD COLUMN `needselect` BOOLEAN NOT NULL DEFAULT 1 AFTER `option`;
UPDATE `tableoptions` SET `needselect` = 0 WHERE `name` IN('massEmail','new','printex','select') AND `tabledefid` IN (9,10,11,12,16,17,19,21,23,24,26,27,200,201,202,203,204);
INSERT INTO `tableoptions` (`tabledefid`, `name`, `option`, `needselect`, `othercommand`, `roleid`, `displayorder`) VALUES ('9', 'import', '1', '0', '0', '-100', '0');
INSERT INTO `tableoptions` (`tabledefid`, `name`, `option`, `needselect`, `othercommand`, `roleid`, `displayorder`) VALUES ('10', 'import', '0', '0', '0', '-100', '0');
INSERT INTO `tableoptions` (`tabledefid`, `name`, `option`, `needselect`, `othercommand`, `roleid`, `displayorder`) VALUES ('11', 'import', '0', '0', '0', '-100', '0');
INSERT INTO `tableoptions` (`tabledefid`, `name`, `option`, `needselect`, `othercommand`, `roleid`, `displayorder`) VALUES ('12', 'import', '1', '0', '0', '-100', '0');
INSERT INTO `tableoptions` (`tabledefid`, `name`, `option`, `needselect`, `othercommand`, `roleid`, `displayorder`) VALUES ('16', 'import', '0', '0', '0', '-100', '0');
INSERT INTO `tableoptions` (`tabledefid`, `name`, `option`, `needselect`, `othercommand`, `roleid`, `displayorder`) VALUES ('17', 'import', '1', '0', '0', '-100', '0');
INSERT INTO `tableoptions` (`tabledefid`, `name`, `option`, `needselect`, `othercommand`, `roleid`, `displayorder`) VALUES ('19', 'import', '0', '0', '0', '-100', '0');
INSERT INTO `tableoptions` (`tabledefid`, `name`, `option`, `needselect`, `othercommand`, `roleid`, `displayorder`) VALUES ('21', 'import', '0', '0', '0', '-100', '0');
INSERT INTO `tableoptions` (`tabledefid`, `name`, `option`, `needselect`, `othercommand`, `roleid`, `displayorder`) VALUES ('23', 'import', '0', '0', '0', '-100', '0');
INSERT INTO `tableoptions` (`tabledefid`, `name`, `option`, `needselect`, `othercommand`, `roleid`, `displayorder`) VALUES ('24', 'import', '0', '0', '0', '-100', '0');
INSERT INTO `tableoptions` (`tabledefid`, `name`, `option`, `needselect`, `othercommand`, `roleid`, `displayorder`) VALUES ('26', 'import', '1', '0', '0', '-100', '0');
INSERT INTO `tableoptions` (`tabledefid`, `name`, `option`, `needselect`, `othercommand`, `roleid`, `displayorder`) VALUES ('27', 'import', '0', '0', '0', '-100', '0');
INSERT INTO `tableoptions` (`tabledefid`, `name`, `option`, `needselect`, `othercommand`, `roleid`, `displayorder`) VALUES ('200', 'import', '1', '0', '0', '-100', '0');
INSERT INTO `tableoptions` (`tabledefid`, `name`, `option`, `needselect`, `othercommand`, `roleid`, `displayorder`) VALUES ('201', 'import', '0', '0', '0', '-100', '0');
INSERT INTO `tableoptions` (`tabledefid`, `name`, `option`, `needselect`, `othercommand`, `roleid`, `displayorder`) VALUES ('202', 'import', '0', '0', '0', '-100', '0');
INSERT INTO `tableoptions` (`tabledefid`, `name`, `option`, `needselect`, `othercommand`, `roleid`, `displayorder`) VALUES ('203', 'import', '0', '0', '0', '-100', '0');
INSERT INTO `tableoptions` (`tabledefid`, `name`, `option`, `needselect`, `othercommand`, `roleid`, `displayorder`) VALUES ('204', 'import', '0', '0', '0', '-100', '0');
ALTER TABLE `tablesearchablefields` ENGINE=INNODB;
ALTER TABLE `tablesearchablefields` MODIFY COLUMN `field` TEXT NOT NULL;
ALTER TABLE `tabs` ENGINE=INNODB;
ALTER TABLE `users` ENGINE=INNODB;
ALTER TABLE `users` ADD COLUMN `lastip` VARCHAR(45) NOT NULL DEFAULT '' AFTER `lastname`;
ALTER TABLE `usersearches` ENGINE=INNODB;
UPDATE `tablefindoptions` SET `search` = 'notes.type=\'TS\' AND notes.private=0' WHERE `tabledefid` = 23 AND `name` = 'Public Tasks';
UPDATE `tablefindoptions` SET `search` = 'notes.type=\'TS\' and notes.assignedbyid={{$_SESSION[\'userinfo\'][\'id\']}} and notes.completed=0' WHERE `tabledefid` = 23 AND `name` = 'Uncomplete Tasks Assigned By Me';
UPDATE `menu` SET `link` = 'N/A' WHERE name = '----';
CREATE TABLE `widgets` (`id` int(10) unsigned NOT NULL AUTO_INCREMENT, `uuid` varchar(64) NOT NULL, `type` varchar(64) NOT NULL, `title` varchar(128) NOT NULL, `file` varchar(255) NOT NULL, `roleid` int(11) NOT NULL default '0', `moduleid` int(11) NOT NULL default '0', `default` tinyint(4) NOT NULL default '0', `createdby` int(11) default NULL, `creationdate` datetime default NULL, `modifiedby` int(10) unsigned default NULL, `modifieddate` timestamp, PRIMARY KEY  (`id`), KEY `uniqueid` (`uuid`)) ENGINE=INNODB;
CREATE TABLE `userpreferences` (`id` int(10) unsigned NOT NULL AUTO_INCREMENT, `userid` int(120) NOT NULL, `name` varchar(64) NOT NULL, `value` TEXT, PRIMARY KEY  (`id`), KEY `thename` (`name`)) ENGINE=INNODB;
INSERT INTO `tabledefs` (`id`, `displayname`, `type`, `moduleid`, `maintable`, `querytable`, `editfile`, `editroleid`, `addfile`, `addroleid`, `importfile`, `importroleid`, `searchroleid`, `advsearchroleid`, `viewsqlroleid`, `deletebutton`, `canpost`, `defaultwhereclause`, `defaultsortorder`, `defaultsearchtype`, `defaultcriteriafindoptions`, `defaultcriteriaselection`, `createdby`, `creationdate`, `modifiedby`, `modifieddate`) VALUES ('205', 'Snapshot Widgets', 'system', '1', 'widgets', '((widgets INNER JOIN modules ON widgets.moduleid = modules.id) LEFT JOIN roles ON widgets.roleid = roles.id) ', 'modules/base/widgets_addedit.php', '-100', 'modules/base/widgets_addedit.php', '-100', NULL, '-100', '-100', '-100', '-100', 'delete', '0', 'widgets.id != -1', 'widgets.title', NULL, NULL, NULL, 1, NOW(), 1, NOW());
DELETE FROM `tabledefs` WHERE `id` = '19';
INSERT INTO `tabledefs` (`id`, `displayname`, `type`, `moduleid`, `maintable`, `querytable`, `editfile`, `editroleid`, `addfile`, `addroleid`, `importfile`, `importroleid`, `searchroleid`, `advsearchroleid`, `viewsqlroleid`, `deletebutton`, `canpost`, `defaultwhereclause`, `defaultsortorder`, `defaultsearchtype`, `defaultcriteriafindoptions`, `defaultcriteriaselection`, `createdby`, `creationdate`, `modifiedby`, `modifieddate`) VALUES ('19', 'Menu', 'system', '1', 'menu', '((menu LEFT JOIN menu as parentmenu on menu.parentid=parentmenu.uuid) LEFT JOIN roles on menu.roleid=roles.id)', 'modules/base/menu_addedit.php', '-100', 'modules/base/menu_addedit.php', '-100', NULL, '-100', '-100', '-100', '-100', 'delete', '0', 'menu.id!=0', 'if(parentmenu.name is null,menu.displayorder,parentmenu.displayorder+(menu.displayorder+1)/10000)', NULL, NULL, NULL, 1, NOW(), 1, NOW());
INSERT INTO `tablecolumns` (`tabledefid`, `name`, `column`, `align`, `footerquery`, `displayorder`, `sortorder`, `wrap`, `size`, `format`, `roleid`) VALUES ('205', 'widget', 'concat(\'[b]\', widgets.title, \'[/b][br]\', widgets.uuid)', 'left', '', '0', 'widgets.title', '0', '100%', 'bbcode', '0');
INSERT INTO `tablecolumns` (`tabledefid`, `name`, `column`, `align`, `footerquery`, `displayorder`, `sortorder`, `wrap`, `size`, `format`, `roleid`) VALUES ('205', 'role', 'IF(widgets.roleid != 0, IF(widgets.roleid != -100, roles.name, \'Administrator\'), \'EVERYONE\')', 'left', '', '2', '', '0', '', NULL, '0');
INSERT INTO `tablecolumns` (`tabledefid`, `name`, `column`, `align`, `footerquery`, `displayorder`, `sortorder`, `wrap`, `size`, `format`, `roleid`) VALUES ('205', 'file', 'widgets.file', 'left', '', '1', '', '0', '', NULL, '0');
DELETE FROM `tablecolumns` WHERE `tabledefid` = '19';
INSERT INTO `tablecolumns` (`tabledefid`, `name`, `column`, `align`, `footerquery`, `displayorder`, `sortorder`, `wrap`, `size`, `format`, `roleid`) VALUES ('19', 'link', 'menu.link', 'left', '', '1', '', '1', '', NULL, '0');
INSERT INTO `tablecolumns` (`tabledefid`, `name`, `column`, `align`, `footerquery`, `displayorder`, `sortorder`, `wrap`, `size`, `format`, `roleid`) VALUES ('19', 'access', 'if(menu.roleid=0,\'EVERYONE\',if(menu.roleid=-100,\'Administrators\',roles.name))', 'left', '', '2', '', '0', '', NULL, '0');
INSERT INTO `tablecolumns` (`tabledefid`, `name`, `column`, `align`, `footerquery`, `displayorder`, `sortorder`, `wrap`, `size`, `format`, `roleid`) VALUES ('19', 'Item', 'IF(menu.parentid = \'0\', CONCAT(\'[b]\', menu.name,\' [/b]\'), menu.name)', 'left', '', '0', '', '0', '100%', 'bbcode', '0');
INSERT INTO `tablecolumns` (`tabledefid`, `name`, `column`, `align`, `footerquery`, `displayorder`, `sortorder`, `wrap`, `size`, `format`, `roleid`) VALUES ('19', 'display order', 'menu.displayorder', 'right', '', '3', '', '0', '', NULL, '0');
INSERT INTO `tablefindoptions` (`tabledefid`, `name`, `search`, `displayorder`, `roleid`) VALUES ('205', 'All Records', 'widgets.id!=-1', '0', '0');
INSERT INTO `tablegroupings` (`tabledefid`, `field`, `displayorder`, `ascending`, `name`, `roleid`) VALUES ('205', 'modules.name', '1', '1', 'Module', '0');
INSERT INTO `tablegroupings` (`tabledefid`, `field`, `displayorder`, `ascending`, `name`, `roleid`) VALUES ('205', 'widgets.type', '2', '1', 'Area', '0');
DELETE FROM `tablegroupings` WHERE `tabledefid` = '19';
INSERT INTO `tablegroupings` (`tabledefid`, `field`, `displayorder`, `ascending`, `name`, `roleid`) VALUES ('19', 'if(menu.parentid=\'0\',concat( lpad(menu.displayorder,3,\"0\"), \" - \" ,menu.name )  , concat( lpad(parentmenu.displayorder,3,\"0\") , \" - \",parentmenu.name))', '1', '1', '', '0');
INSERT INTO `tableoptions` (`tabledefid`, `name`, `option`, `needselect`, `othercommand`, `roleid`, `displayorder`) VALUES ('205', 'new', '1', '0', '0', '0', '0');
INSERT INTO `tableoptions` (`tabledefid`, `name`, `option`, `needselect`, `othercommand`, `roleid`, `displayorder`) VALUES ('205', 'edit', '1', '1', '0', '0', '0');
INSERT INTO `tableoptions` (`tabledefid`, `name`, `option`, `needselect`, `othercommand`, `roleid`, `displayorder`) VALUES ('205', 'printex', '1', '0', '0', '0', '0');
INSERT INTO `tableoptions` (`tabledefid`, `name`, `option`, `needselect`, `othercommand`, `roleid`, `displayorder`) VALUES ('205', 'select', '1', '0', '0', '0', '0');
INSERT INTO `tableoptions` (`tabledefid`, `name`, `option`, `needselect`, `othercommand`, `roleid`, `displayorder`) VALUES ('205', 'import', '1', '0', '0', '-100', '0');
INSERT INTO `tablesearchablefields` (`tabledefid`, `field`, `name`, `displayorder`, `type`) VALUES ('205', 'widgets.id', 'id', '1', 'field');
INSERT INTO `widgets` (`uuid`, `type`, `title`, `file`, `roleid`, `moduleid`, `default`, `createdby`, `creationdate`, `modifiedby`, `modifieddate`) VALUES ('wdgt:a1aec114-954b-37c1-0474-7d4e851c728c', 'little', 'Workload', 'widgets/workload/class.php', '0', '1', '1', 1, NOW(), 1, NOW());
INSERT INTO `widgets` (`uuid`, `type`, `title`, `file`, `roleid`, `moduleid`, `default`, `createdby`, `creationdate`, `modifiedby`, `modifieddate`) VALUES ('wdgt:13d228d3-bbee-e7d2-6571-83a568688e3d', 'big', 'Events', 'widgets/events/class.php', '0', '1', '1', 1, NOW(), 1, NOW());
INSERT INTO `widgets` (`uuid`, `type`, `title`, `file`, `roleid`, `moduleid`, `default`, `createdby`, `creationdate`, `modifiedby`, `modifieddate`) VALUES ('wdgt:bc323640-6497-cb6f-5897-029af7dcb3c9', 'little', 'System Statistics', 'widgets/systemstats/class.php', '-100', '1', '0', 1, NOW(), 1, NOW());
UPDATE `menu` SET `name` = 'Tools' WHERE `id` = '1' AND `name` = 'Organizer';
UPDATE `menu` SET `roleid` = -100 WHERE `id` = '6' AND `name` = 'System';
DELETE FROM `menu`;
INSERT INTO `menu` (`uuid`, `name`, `link`, `parentid`, `displayorder`, `createdby`, `modifiedby`, `creationdate`, `modifieddate`, `roleid`) VALUES ('menu:1e23c59e-c429-fec5-cc94-99b53c4fc6b0', 'Tools', '', '0', '3', 1, 1, NOW(), NOW(), '0');
INSERT INTO `menu` (`uuid`, `name`, `link`, `parentid`, `displayorder`, `createdby`, `modifiedby`, `creationdate`, `modifieddate`, `roleid`) VALUES ('menu:d9e0eaa6-26b3-fcfb-f1b5-ee0eef8a857a', 'Notes', 'search.php?id=12', 'menu:1e23c59e-c429-fec5-cc94-99b53c4fc6b0', '30', 1, 1, NOW(), NOW(), '0');
INSERT INTO `menu` (`uuid`, `name`, `link`, `parentid`, `displayorder`, `createdby`, `modifiedby`, `creationdate`, `modifieddate`, `roleid`) VALUES ('menu:03e984b6-d7ac-def2-a4f5-662003e94bfd', 'Tasks', 'search.php?id=23', 'menu:1e23c59e-c429-fec5-cc94-99b53c4fc6b0', '40', 1, 1, NOW(), NOW(), '0');
INSERT INTO `menu` (`uuid`, `name`, `link`, `parentid`, `displayorder`, `createdby`, `modifiedby`, `creationdate`, `modifieddate`, `roleid`) VALUES ('menu:c4871074-90e9-c9bb-bcf9-b69ca0c30e8b', 'Events', 'search.php?id=24', 'menu:1e23c59e-c429-fec5-cc94-99b53c4fc6b0', '50', 1, 1, NOW(), NOW(), '0');
INSERT INTO `menu` (`uuid`, `name`, `link`, `parentid`, `displayorder`, `createdby`, `modifiedby`, `creationdate`, `modifieddate`, `roleid`) VALUES ('menu:2bcd88e6-703f-128c-7f18-1aad44fb46fb', 'Snapshot', 'modules/base/snapshot.php', 'menu:1e23c59e-c429-fec5-cc94-99b53c4fc6b0', '10', 1, 1, NOW(), NOW(), '0');
INSERT INTO `menu` (`uuid`, `name`, `link`, `parentid`, `displayorder`, `createdby`, `modifiedby`, `creationdate`, `modifieddate`, `roleid`) VALUES ('menu:bbc91ea7-d7e4-33b7-503e-5eb1b928f28b', 'System', '', '0', '10', 1, 1, NOW(), NOW(), '-100');
INSERT INTO `menu` (`uuid`, `name`, `link`, `parentid`, `displayorder`, `createdby`, `modifiedby`, `creationdate`, `modifieddate`, `roleid`) VALUES ('menu:e44cf976-658a-50d7-4a8f-b575713e3964', 'Configuration', 'modules/base/adminsettings.php', 'menu:bbc91ea7-d7e4-33b7-503e-5eb1b928f28b', '10', 1, 1, NOW(), NOW(), '-100');
INSERT INTO `menu` (`uuid`, `name`, `link`, `parentid`, `displayorder`, `createdby`, `modifiedby`, `creationdate`, `modifieddate`, `roleid`) VALUES ('menu:cf16add3-b02a-bd9b-b3c7-3fe9d0d2e0ba', 'Users', 'search.php?id=9', 'menu:f07d910f-f56d-3d24-e74f-7a3b36b2d3c8', '40', 1, 1, NOW(), NOW(), '-100');
INSERT INTO `menu` (`uuid`, `name`, `link`, `parentid`, `displayorder`, `createdby`, `modifiedby`, `creationdate`, `modifieddate`, `roleid`) VALUES ('menu:d727dda4-6ac5-dd23-992b-7cf64cd96620', 'Roles', 'search.php?id=200', 'menu:f07d910f-f56d-3d24-e74f-7a3b36b2d3c8', '50', 1, 1, NOW(), NOW(), '-100');
INSERT INTO `menu` (`uuid`, `name`, `link`, `parentid`, `displayorder`, `createdby`, `modifiedby`, `creationdate`, `modifieddate`, `roleid`) VALUES ('menu:afddfee1-5ab7-2064-204f-816e9df929ac', '----', 'N/A', 'menu:bbc91ea7-d7e4-33b7-503e-5eb1b928f28b', '15', 1, 1, NOW(), NOW(), '-100');
INSERT INTO `menu` (`uuid`, `name`, `link`, `parentid`, `displayorder`, `createdby`, `modifiedby`, `creationdate`, `modifieddate`, `roleid`) VALUES ('menu:9c845b2d-7383-4182-1bf5-fe9b770f1d63', 'Menu', 'search.php?id=19', 'menu:bbc91ea7-d7e4-33b7-503e-5eb1b928f28b', '50', 1, 1, NOW(), NOW(), '-100');
INSERT INTO `menu` (`uuid`, `name`, `link`, `parentid`, `displayorder`, `createdby`, `modifiedby`, `creationdate`, `modifieddate`, `roleid`) VALUES ('menu:ef5853a0-3b57-06e5-a8d4-31bfbdb207b5', 'Files', 'search.php?id=26', 'menu:1e23c59e-c429-fec5-cc94-99b53c4fc6b0', '910', 1, 1, NOW(), NOW(), '-100');
INSERT INTO `menu` (`uuid`, `name`, `link`, `parentid`, `displayorder`, `createdby`, `modifiedby`, `creationdate`, `modifieddate`, `roleid`) VALUES ('menu:1f72cd68-1e5a-e718-3b38-8671da9b0a1d', 'Saved Searchs/Sorts', 'search.php?id=17', 'menu:1e23c59e-c429-fec5-cc94-99b53c4fc6b0', '930', 1, 1, NOW(), NOW(), '-100');
INSERT INTO `menu` (`uuid`, `name`, `link`, `parentid`, `displayorder`, `createdby`, `modifiedby`, `creationdate`, `modifieddate`, `roleid`) VALUES ('menu:00ddbccd-2761-3347-22ee-1adce9696b66', '----', 'N/A', 'menu:bbc91ea7-d7e4-33b7-503e-5eb1b928f28b', '45', 1, 1, NOW(), NOW(), '-100');
INSERT INTO `menu` (`uuid`, `name`, `link`, `parentid`, `displayorder`, `createdby`, `modifiedby`, `creationdate`, `modifieddate`, `roleid`) VALUES ('menu:8825339e-76a8-b51a-fdce-7b409451962c', 'Reports', 'search.php?id=16', 'menu:bbc91ea7-d7e4-33b7-503e-5eb1b928f28b', '70', 1, 1, NOW(), NOW(), '-100');
INSERT INTO `menu` (`uuid`, `name`, `link`, `parentid`, `displayorder`, `createdby`, `modifiedby`, `creationdate`, `modifieddate`, `roleid`) VALUES ('menu:2dea83ff-2927-0859-ab97-530ee76e7bb8', 'Relationships', 'search.php?id=10', 'menu:bbc91ea7-d7e4-33b7-503e-5eb1b928f28b', '60', 1, 1, NOW(), NOW(), '-100');
INSERT INTO `menu` (`uuid`, `name`, `link`, `parentid`, `displayorder`, `createdby`, `modifiedby`, `creationdate`, `modifieddate`, `roleid`) VALUES ('menu:76f8b6cd-f42d-0823-3e12-5cbe39f7fbdb', 'Table Definitions', 'search.php?id=11', 'menu:1e23c59e-c429-fec5-cc94-99b53c4fc6b0', '940', 1, 1, NOW(), NOW(), '-100');
INSERT INTO `menu` (`uuid`, `name`, `link`, `parentid`, `displayorder`, `createdby`, `modifiedby`, `creationdate`, `modifieddate`, `roleid`) VALUES ('menu:f1780935-8018-d240-8e74-f8fde4f8e1bb', 'Modules', 'search.php?id=21', 'menu:bbc91ea7-d7e4-33b7-503e-5eb1b928f28b', '60', 1, 1, NOW(), NOW(), '-100');
INSERT INTO `menu` (`uuid`, `name`, `link`, `parentid`, `displayorder`, `createdby`, `modifiedby`, `creationdate`, `modifieddate`, `roleid`) VALUES ('menu:e0a2cc66-9b44-f0cb-84a7-45eb3307298f', 'My Account', 'modules/base/myaccount.php', 'menu:f07d910f-f56d-3d24-e74f-7a3b36b2d3c8', '20', 1, 1, NOW(), NOW(), '0');
INSERT INTO `menu` (`uuid`, `name`, `link`, `parentid`, `displayorder`, `createdby`, `modifiedby`, `creationdate`, `modifieddate`, `roleid`) VALUES ('menu:b63e3218-0a12-3e51-88b7-8af400a74a7e', 'Scheduler', 'search.php?id=201', 'menu:bbc91ea7-d7e4-33b7-503e-5eb1b928f28b', '32', 1, 1, NOW(), NOW(), '-100');
INSERT INTO `menu` (`uuid`, `name`, `link`, `parentid`, `displayorder`, `createdby`, `modifiedby`, `creationdate`, `modifieddate`, `roleid`) VALUES ('menu:5f875b57-f499-2307-6d57-61ba49b72e82', 'System Log', 'search.php?id=202', 'menu:bbc91ea7-d7e4-33b7-503e-5eb1b928f28b', '20', 1, 1, NOW(), NOW(), '-100');
INSERT INTO `menu` (`uuid`, `name`, `link`, `parentid`, `displayorder`, `createdby`, `modifiedby`, `creationdate`, `modifieddate`, `roleid`) VALUES ('menu:bd2181f5-b938-011b-7e44-81728310bdf5', 'Smart Searches', 'search.php?id=204', 'menu:bbc91ea7-d7e4-33b7-503e-5eb1b928f28b', '80', 1, 1, NOW(), NOW(), '-100');
INSERT INTO `menu` (`uuid`, `name`, `link`, `parentid`, `displayorder`, `createdby`, `modifiedby`, `creationdate`, `modifieddate`, `roleid`) VALUES ('menu:f8392545-41f4-d39a-da7e-9116c9a35502', 'Tabs', 'search.php?id=203', 'menu:bbc91ea7-d7e4-33b7-503e-5eb1b928f28b', '100', 1, 1, NOW(), NOW(), '-100');
INSERT INTO `menu` (`uuid`, `name`, `link`, `parentid`, `displayorder`, `createdby`, `modifiedby`, `creationdate`, `modifieddate`, `roleid`) VALUES ('menu:3620bdc0-edaa-ad59-8ac5-193f855a9584', 'Log Out', 'logout.php', 'menu:f07d910f-f56d-3d24-e74f-7a3b36b2d3c8', '10', 1, 1, NOW(), NOW(), '0');
INSERT INTO `menu` (`uuid`, `name`, `link`, `parentid`, `displayorder`, `createdby`, `modifiedby`, `creationdate`, `modifieddate`, `roleid`) VALUES ('menu:2da14499-f301-9b18-e384-e0e73f06509e', 'Help', '', '0', '200', 1, 1, NOW(), NOW(), '0');
INSERT INTO `menu` (`uuid`, `name`, `link`, `parentid`, `displayorder`, `createdby`, `modifiedby`, `creationdate`, `modifieddate`, `roleid`) VALUES ('menu:113b56da-3722-6518-4c6a-7804d7ed0d19', 'About phpBMS', 'javascript:menu.showHelp()', 'menu:2da14499-f301-9b18-e384-e0e73f06509e', '0', 1, 1, NOW(), NOW(), '0');
INSERT INTO `menu` (`uuid`, `name`, `link`, `parentid`, `displayorder`, `createdby`, `modifiedby`, `creationdate`, `modifieddate`, `roleid`) VALUES ('menu:08a6bb60-4557-b7d2-f2ba-09d828a1d9b2', 'Snapshot Widgets', 'search.php?id=205', 'menu:bbc91ea7-d7e4-33b7-503e-5eb1b928f28b', '90', 1, 1, NOW(), NOW(), '-100');
INSERT INTO `menu` (`uuid`, `name`, `link`, `parentid`, `displayorder`, `createdby`, `modifiedby`, `creationdate`, `modifieddate`, `roleid`) VALUES ('menu:30bc9743-3530-7705-283a-d740b19238cf', '----', 'N/A', 'menu:1e23c59e-c429-fec5-cc94-99b53c4fc6b0', '20', 1, 1, NOW(), NOW(), '0');
INSERT INTO `menu` (`uuid`, `name`, `link`, `parentid`, `displayorder`, `createdby`, `modifiedby`, `creationdate`, `modifieddate`, `roleid`) VALUES ('menu:13e03413-2f08-9b48-98a2-9bb83e4d15a1', '----', 'N/A', 'menu:1e23c59e-c429-fec5-cc94-99b53c4fc6b0', '900', 1, 1, NOW(), NOW(), '-100');
INSERT INTO `menu` (`uuid`, `name`, `link`, `parentid`, `displayorder`, `createdby`, `modifiedby`, `creationdate`, `modifieddate`, `roleid`) VALUES ('menu:83d23ec3-ad10-09e1-8c80-72de0c4747f9', '----', 'N/A', 'menu:1e23c59e-c429-fec5-cc94-99b53c4fc6b0', '920', 1, 1, NOW(), NOW(), '-100');
INSERT INTO `menu` (`uuid`, `name`, `link`, `parentid`, `displayorder`, `createdby`, `modifiedby`, `creationdate`, `modifieddate`, `roleid`) VALUES ('menu:f07d910f-f56d-3d24-e74f-7a3b36b2d3c8', 'Account', '', '0', '5', 1, 1, NOW(), NOW(), '0');
INSERT INTO `menu` (`uuid`, `name`, `link`, `parentid`, `displayorder`, `createdby`, `modifiedby`, `creationdate`, `modifieddate`, `roleid`) VALUES ('menu:e8401ebb-c369-304f-053d-8195988e7faf', '----', 'N/A', 'menu:f07d910f-f56d-3d24-e74f-7a3b36b2d3c8', '30', 1, 1, NOW(), NOW(), '-100');
UPDATE `tabledefs` SET `hascustomfields` = 1 WHERE `id` IN(12, 9, 26, 200);
ALTER TABLE `notes` ADD COLUMN `custom1` DOUBLE, ADD COLUMN `custom2` DOUBLE, ADD COLUMN `custom3` DATETIME, ADD COLUMN `custom4` DATETIME, ADD COLUMN `custom5` VARCHAR(255), ADD COLUMN `custom6` VARCHAR(255), ADD COLUMN `custom7` TINYINT(1) DEFAULT 0, ADD COLUMN `custom8` TINYINT(1) DEFAULT 0;
ALTER TABLE `users` ADD COLUMN `custom1` DOUBLE, ADD COLUMN `custom2` DOUBLE, ADD COLUMN `custom3` DATETIME, ADD COLUMN `custom4` DATETIME, ADD COLUMN `custom5` VARCHAR(255), ADD COLUMN `custom6` VARCHAR(255), ADD COLUMN `custom7` TINYINT(1) DEFAULT 0, ADD COLUMN `custom8` TINYINT(1) DEFAULT 0;
ALTER TABLE `roles` ADD COLUMN `custom1` DOUBLE, ADD COLUMN `custom2` DOUBLE, ADD COLUMN `custom3` DATETIME, ADD COLUMN `custom4` DATETIME, ADD COLUMN `custom5` VARCHAR(255), ADD COLUMN `custom6` VARCHAR(255), ADD COLUMN `custom7` TINYINT(1) DEFAULT 0, ADD COLUMN `custom8` TINYINT(1) DEFAULT 0;
ALTER TABLE `files` ADD COLUMN `custom1` DOUBLE, ADD COLUMN `custom2` DOUBLE, ADD COLUMN `custom3` DATETIME, ADD COLUMN `custom4` DATETIME, ADD COLUMN `custom5` VARCHAR(255), ADD COLUMN `custom6` VARCHAR(255), ADD COLUMN `custom7` TINYINT(1) DEFAULT 0, ADD COLUMN `custom8` TINYINT(1) DEFAULT 0;
INSERT INTO `tabs` (`id`, `name`, `tabgroup`, `location`, `displayorder`, `enableonnew`, `roleid`, `tooltip`, `notificationsql`, `createdby`, `creationdate`, `modifiedby`, `modifieddate`) VALUES (101, 'custom fields', 'tabledefs entry', 'modules/base/tabledefs_custom.php', '60', '0', '-100', NULL, NULL, 1, NOW(), 1, NOW());