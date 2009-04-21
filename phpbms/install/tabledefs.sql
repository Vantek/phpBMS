INSERT INTO `tabledefs` (`id`, `displayname`, `type`, `moduleid`, `maintable`, `querytable`, `editfile`, `editroleid`, `addfile`, `addroleid`, `importfile`, `importroleid`, `searchroleid`, `advsearchroleid`, `viewsqlroleid`, `deletebutton`, `canpost`, `defaultwhereclause`, `defaultsortorder`, `defaultsearchtype`, `defaultcriteriafindoptions`, `defaultcriteriaselection`, `createdby`, `creationdate`, `modifiedby`, `modifieddate`) VALUES ('9', 'Users', 'system', '1', 'users', 'users', 'modules/base/users_addedit.php', '0', 'modules/base/users_addedit.php', '0', 'modules/base/users_import.php', '-100', '0', '-100', '-100', 'revoke', '0', 'users.id !=0', 'users.id', NULL, NULL, NULL, 1, NOW(), 1, NOW());
INSERT INTO `tabledefs` (`id`, `displayname`, `type`, `moduleid`, `maintable`, `querytable`, `editfile`, `editroleid`, `addfile`, `addroleid`, `importfile`, `importroleid`, `searchroleid`, `advsearchroleid`, `viewsqlroleid`, `deletebutton`, `canpost`, `defaultwhereclause`, `defaultsortorder`, `defaultsearchtype`, `defaultcriteriafindoptions`, `defaultcriteriaselection`, `createdby`, `creationdate`, `modifiedby`, `modifieddate`) VALUES ('10', 'Relationships', 'system', '1', 'relationships', '(relationships inner join tabledefs as fromtable on relationships.fromtableid=fromtable.id) inner join tabledefs as totable on relationships.totableid=totable.id', 'modules/base/relationships_addedit.php', '0', 'modules/base/relationships_addedit.php', '0', NULL, '-100', '0', '-100', '-100', 'delete', '0', 'relationships.id != 0', 'fromtable.displayname, name', '', '', '', 1, NOW(), 1, NOW());
INSERT INTO `tabledefs` (`id`, `displayname`, `type`, `moduleid`, `maintable`, `querytable`, `editfile`, `editroleid`, `addfile`, `addroleid`, `importfile`, `importroleid`, `searchroleid`, `advsearchroleid`, `viewsqlroleid`, `deletebutton`, `canpost`, `defaultwhereclause`, `defaultsortorder`, `defaultsearchtype`, `defaultcriteriafindoptions`, `defaultcriteriaselection`, `createdby`, `creationdate`, `modifiedby`, `modifieddate`) VALUES ('11', 'Table Definitions', 'system', '1', 'tabledefs', 'tabledefs left join modules on tabledefs.moduleid=modules.id', 'modules/base/tabledefs_addedit.php', '-100', 'modules/base/tabledefs_addedit.php', '-100', NULL, '-100', '-100', '-100', '-100', 'delete', '0', 'tabledefs.id != 0', 'modules.name, tabledefs.displayname', '', '', '', 1, NOW(), 1, NOW());
INSERT INTO `tabledefs` (`id`, `displayname`, `type`, `moduleid`, `maintable`, `querytable`, `editfile`, `editroleid`, `addfile`, `addroleid`, `importfile`, `importroleid`, `searchroleid`, `advsearchroleid`, `viewsqlroleid`, `deletebutton`, `canpost`, `defaultwhereclause`, `defaultsortorder`, `defaultsearchtype`, `defaultcriteriafindoptions`, `defaultcriteriaselection`, `createdby`, `creationdate`, `modifiedby`, `modifieddate`) VALUES ('12', 'Notes', 'table', '1', 'notes', 'notes', 'modules/base/notes_addedit.php', '0', 'modules/base/notes_addedit.php', '0', NULL, '-100', '0', '-100', '-100', 'delete', '0', 'notes.type=\'NT\' AND notes.createdby = {{$_SESSION[\'userinfo\'][\'id\']}} AND completed=0', 'notes.category,notes.type,notes.importance DESC,notes.creationdate', 'search', 'My Unread Notes', 'new', 1, NOW(), 1, NOW());
INSERT INTO `tabledefs` (`id`, `displayname`, `type`, `moduleid`, `maintable`, `querytable`, `editfile`, `editroleid`, `addfile`, `addroleid`, `importfile`, `importroleid`, `searchroleid`, `advsearchroleid`, `viewsqlroleid`, `deletebutton`, `canpost`, `defaultwhereclause`, `defaultsortorder`, `defaultsearchtype`, `defaultcriteriafindoptions`, `defaultcriteriaselection`, `createdby`, `creationdate`, `modifiedby`, `modifieddate`) VALUES ('16', 'Reports', 'system', '1', 'reports', 'reports left join tabledefs on reports.tabledefid=tabledefs.id', 'modules/base/reports_addedit.php', '0', 'modules/base/reports_addedit.php', '0', NULL, '-100', '0', '-100', '-100', 'delete', '0', 'reports.id != 0', 'tabledefid,displayorder DESC, reports.name', '', '', '', 1, NOW(), 1, NOW());
INSERT INTO `tabledefs` (`id`, `displayname`, `type`, `moduleid`, `maintable`, `querytable`, `editfile`, `editroleid`, `addfile`, `addroleid`, `importfile`, `importroleid`, `searchroleid`, `advsearchroleid`, `viewsqlroleid`, `deletebutton`, `canpost`, `defaultwhereclause`, `defaultsortorder`, `defaultsearchtype`, `defaultcriteriafindoptions`, `defaultcriteriaselection`, `createdby`, `creationdate`, `modifiedby`, `modifieddate`) VALUES ('17', 'Saved Searches/Sorts', 'system', '1', 'usersearches', '(usersearches left join users on usersearches.userid = users.id) inner join tabledefs on usersearches.tabledefid=tabledefs.id', 'modules/base/usersearches_edit.php', '0', 'N/A', '0', NULL, '-100', '0', '-100', '-100', 'delete', '0', 'usersearches.id != 0', 'usersearches.name', '', '', '', 1, NOW(), 1, NOW());
INSERT INTO `tabledefs` (`id`, `displayname`, `type`, `moduleid`, `maintable`, `querytable`, `editfile`, `editroleid`, `addfile`, `addroleid`, `importfile`, `importroleid`, `searchroleid`, `advsearchroleid`, `viewsqlroleid`, `deletebutton`, `canpost`, `defaultwhereclause`, `defaultsortorder`, `defaultsearchtype`, `defaultcriteriafindoptions`, `defaultcriteriaselection`, `createdby`, `creationdate`, `modifiedby`, `modifieddate`) VALUES ('19', 'Menu', 'system', '1', 'menu', '((menu LEFT JOIN menu as parentmenu on menu.parentid=parentmenu.id) LEFT JOIN roles on menu.roleid=roles.id)', 'modules/base/menu_addedit.php', '-100', 'modules/base/menu_addedit.php', '-100', NULL, '-100', '-100', '-100', '-100', 'delete', '0', 'menu.id!=0', 'if(parentmenu.name is null,menu.displayorder,parentmenu.displayorder+(menu.displayorder+1)/10000)', '', '', '', 1, NOW(), 1, NOW());
INSERT INTO `tabledefs` (`id`, `displayname`, `type`, `moduleid`, `maintable`, `querytable`, `editfile`, `editroleid`, `addfile`, `addroleid`, `importfile`, `importroleid`, `searchroleid`, `advsearchroleid`, `viewsqlroleid`, `deletebutton`, `canpost`, `defaultwhereclause`, `defaultsortorder`, `defaultsearchtype`, `defaultcriteriafindoptions`, `defaultcriteriaselection`, `createdby`, `creationdate`, `modifiedby`, `modifieddate`) VALUES ('21', 'Installed Modules', 'system', '1', 'modules', 'modules', 'modules/base/modules_view.php', '0', 'modules/base/modules_view.php', '0', NULL, '-100', '0', '-100', '-100', 'NA', '0', 'modules.id!=0', 'modules.name', '', '', '', 1, NOW(), 1, NOW());
INSERT INTO `tabledefs` (`id`, `displayname`, `type`, `moduleid`, `maintable`, `querytable`, `editfile`, `editroleid`, `addfile`, `addroleid`, `importfile`, `importroleid`, `searchroleid`, `advsearchroleid`, `viewsqlroleid`, `deletebutton`, `canpost`, `defaultwhereclause`, `defaultsortorder`, `defaultsearchtype`, `defaultcriteriafindoptions`, `defaultcriteriaselection`, `createdby`, `creationdate`, `modifiedby`, `modifieddate`) VALUES ('23', 'Tasks', 'view', '1', 'notes', '((notes left join users as assignedto on assignedto.id= notes.assignedtoid)  left join users as assignedby on assignedby.id=notes.assignedbyid)', 'modules/base/notes_addedit.php?backurl=../../search.php?id=23', '0', 'modules/base/notes_addedit.php?ty=TS&backurl=../../search.php?id=23', '0', NULL, '-100', '0', '-100', '-100', 'delete', '0', 'notes.id = -1', 'notes.importance, IF(assignedtodate IS NOT NULL, assignedtodate, IF((enddate IS NOT NULL && type = \'TS\'), enddate, IF((startdate IS NOT NULL && type = \'EV\'), startdate, CURDATE()))), subject', 'search', 'My Uncompleted Tasks', NULL, 1, NOW(), 1, NOW());
INSERT INTO `tabledefs` (`id`, `displayname`, `type`, `moduleid`, `maintable`, `querytable`, `editfile`, `editroleid`, `addfile`, `addroleid`, `importfile`, `importroleid`, `searchroleid`, `advsearchroleid`, `viewsqlroleid`, `deletebutton`, `canpost`, `defaultwhereclause`, `defaultsortorder`, `defaultsearchtype`, `defaultcriteriafindoptions`, `defaultcriteriaselection`, `createdby`, `creationdate`, `modifiedby`, `modifieddate`) VALUES ('24', 'Events', 'view', '1', 'notes', '((notes left join users as assignedto on assignedto.id= notes.assignedtoid)  left join users as assignedby on assignedby.id=notes.assignedbyid)', 'modules/base/notes_addedit.php?backurl=../../search.php?id=24', '0', 'modules/base/notes_addedit.php?ty=EV&backurl=../../search.php?id=24', '0', NULL, '-100', '0', '-100', '-100', 'delete', '0', 'notes.type=\'EV\' AND notes.createdby = {{$_SESSION[\'userinfo\'][\'id\']}} AND ((notes.startdate = year(notes.startdate)=year(curdate()) and week(notes.startdate)=week(curdate())))', 'notes.startdate DESC,notes.starttime DESC,notes.enddate DESC,notes.endtime DESC,notes.importance', 'search', NULL, NULL, 1, NOW(), 1, NOW());
INSERT INTO `tabledefs` (`id`, `displayname`, `type`, `moduleid`, `maintable`, `querytable`, `editfile`, `editroleid`, `addfile`, `addroleid`, `importfile`, `importroleid`, `searchroleid`, `advsearchroleid`, `viewsqlroleid`, `deletebutton`, `canpost`, `defaultwhereclause`, `defaultsortorder`, `defaultsearchtype`, `defaultcriteriafindoptions`, `defaultcriteriaselection`, `createdby`, `creationdate`, `modifiedby`, `modifieddate`) VALUES ('26', 'Files', 'table', '1', 'files', 'files', 'modules/base/files_addedit.php', '0', 'modules/base/files_addedit.php', '0', NULL, '-100', '-100', '-100', '-100', 'delete', '0', 'files.id=-1', 'files.name', 'search', '', '', 1, NOW(), 1, NOW());
INSERT INTO `tabledefs` (`id`, `displayname`, `type`, `moduleid`, `maintable`, `querytable`, `editfile`, `editroleid`, `addfile`, `addroleid`, `importfile`, `importroleid`, `searchroleid`, `advsearchroleid`, `viewsqlroleid`, `deletebutton`, `canpost`, `defaultwhereclause`, `defaultsortorder`, `defaultsearchtype`, `defaultcriteriafindoptions`, `defaultcriteriaselection`, `createdby`, `creationdate`, `modifiedby`, `modifieddate`) VALUES ('27', 'Attachments', 'table', '1', 'attachments', '(attachments INNER JOIN files on attachments.fileid=files.id)', 'modules/base/files_addedit.php', '0', 'modules/base/files_addedit.php', '0', NULL, '-100', '0', '-100', '-100', 'delete', '0', 'attachments.id!=0', 'attachments.creationdate DESC', 'search', '', '', 1, NOW(), 1, NOW());
INSERT INTO `tabledefs` (`id`, `displayname`, `type`, `moduleid`, `maintable`, `querytable`, `editfile`, `editroleid`, `addfile`, `addroleid`, `importfile`, `importroleid`, `searchroleid`, `advsearchroleid`, `viewsqlroleid`, `deletebutton`, `canpost`, `defaultwhereclause`, `defaultsortorder`, `defaultsearchtype`, `defaultcriteriafindoptions`, `defaultcriteriaselection`, `createdby`, `creationdate`, `modifiedby`, `modifieddate`) VALUES ('200', 'Roles', 'table', '1', 'roles', 'roles', 'modules/base/roles_addedit.php', '-100', 'modules/base/roles_addedit.php', '-100', NULL, '-100', '-100', '-100', '-100', 'inactivate', '0', 'roles.id!=-1', 'name', 'search', '', '', 1, NOW(), 1, NOW());
INSERT INTO `tabledefs` (`id`, `displayname`, `type`, `moduleid`, `maintable`, `querytable`, `editfile`, `editroleid`, `addfile`, `addroleid`, `importfile`, `importroleid`, `searchroleid`, `advsearchroleid`, `viewsqlroleid`, `deletebutton`, `canpost`, `defaultwhereclause`, `defaultsortorder`, `defaultsearchtype`, `defaultcriteriafindoptions`, `defaultcriteriaselection`, `createdby`, `creationdate`, `modifiedby`, `modifieddate`) VALUES ('201', 'Scheduler', 'system', '1', 'scheduler', 'scheduler', 'modules/base/scheduler_addedit.php', '-100', 'modules/base/scheduler_addedit.php', '-100', NULL, '-100', '-100', '-100', '-100', 'delete', '0', 'scheduler.id!=0', 'scheduler.name', '', '', '', 1, NOW(), 1, NOW());
INSERT INTO `tabledefs` (`id`, `displayname`, `type`, `moduleid`, `maintable`, `querytable`, `editfile`, `editroleid`, `addfile`, `addroleid`, `importfile`, `importroleid`, `searchroleid`, `advsearchroleid`, `viewsqlroleid`, `deletebutton`, `canpost`, `defaultwhereclause`, `defaultsortorder`, `defaultsearchtype`, `defaultcriteriafindoptions`, `defaultcriteriaselection`, `createdby`, `creationdate`, `modifiedby`, `modifieddate`) VALUES ('202', 'System Log', 'system', '1', 'log', 'log LEFT JOIN users ON log.userid=users.id', 'N/A', '-100', 'N/A', '-100', NULL, '-100', '-100', '-100', '-100', 'delete', '0', 'log.stamp> DATE_SUB(CURDATE(),INTERVAL 1 DAY)', 'log.stamp', '', '', '', 1, NOW(), 1, NOW());
INSERT INTO `tabledefs` (`id`, `displayname`, `type`, `moduleid`, `maintable`, `querytable`, `editfile`, `editroleid`, `addfile`, `addroleid`, `importfile`, `importroleid`, `searchroleid`, `advsearchroleid`, `viewsqlroleid`, `deletebutton`, `canpost`, `defaultwhereclause`, `defaultsortorder`, `defaultsearchtype`, `defaultcriteriafindoptions`, `defaultcriteriaselection`, `createdby`, `creationdate`, `modifiedby`, `modifieddate`) VALUES ('203', 'Tabs', 'system', '1', 'tabs', 'tabs LEFT JOIN roles ON tabs.roleid=roles.id', 'modules/base/tabs_addedit.php', '-100', 'modules/base/tabs_addedit.php', '-100', NULL, '-100', '-100', '-100', '-100', 'delete', '0', 'tabs.id!=0', 'tabs.tabgroup,tabs.displayorder', '', '', '', 1, NOW(), 1, NOW());
INSERT INTO `tabledefs` (`id`, `displayname`, `type`, `moduleid`, `maintable`, `querytable`, `editfile`, `editroleid`, `addfile`, `addroleid`, `importfile`, `importroleid`, `searchroleid`, `advsearchroleid`, `viewsqlroleid`, `deletebutton`, `canpost`, `defaultwhereclause`, `defaultsortorder`, `defaultsearchtype`, `defaultcriteriafindoptions`, `defaultcriteriaselection`, `createdby`, `creationdate`, `modifiedby`, `modifieddate`) VALUES ('204', 'Smart Searches', 'table', '1', 'smartsearches', '(smartsearches INNER JOIN tabledefs ON smartsearches.tabledefid = tabledefs.id) INNER JOIN modules on smartsearches.moduleid = modules.id', 'modules/base/smartsearches_addedit.php', '-100', 'modules/base/smartsearches_addedit.php', '-100', NULL, '-100', '-100', '-100', '-100', 'delete', '0', 'smartsearches.id != -1', 'smartsearches.name', NULL, NULL, NULL, 1, NOW(), 1, NOW());
INSERT INTO `tabledefs` (`id`, `displayname`, `type`, `moduleid`, `maintable`, `querytable`, `editfile`, `editroleid`, `addfile`, `addroleid`, `importfile`, `importroleid`, `searchroleid`, `advsearchroleid`, `viewsqlroleid`, `deletebutton`, `canpost`, `defaultwhereclause`, `defaultsortorder`, `defaultsearchtype`, `defaultcriteriafindoptions`, `defaultcriteriaselection`, `createdby`, `creationdate`, `modifiedby`, `modifieddate`) VALUES ('205', 'Snapshot Widgets', 'system', '1', 'widgets', '((widgets INNER JOIN modules ON widgets.moduleid = modules.id) LEFT JOIN roles ON widgets.roleid = roles.id) ', 'modules/base/widgets_addedit.php', '-100', 'modules/base/widgets_addedit.php', '-100', NULL, '-100', '-100', '-100', '-100', 'delete', '0', 'widgets.id != -1', 'widgets.title', NULL, NULL, NULL, 1, NOW(), 1, NOW());