INSERT INTO `smartsearches` (`uuid`, `name`, `fromclause`, `valuefield`, `displayfield`, `secondaryfield`, `classfield`, `searchfields`, `filterclause`, `rolefield`, `tabledefid`, `moduleid`, `createdby`, `creationdate`, `modifiedby`, `modifieddate`) VALUES ('smsr:d843d3ec-89f6-4468-b06f-3d262e9202a6', 'Pick Push Record For Cron', 'pushrecords', 'pushrecords.uuid', 'pushrecords.name', 'CONCAT(pushrecords.server,IF(pushrecords.port,CONCAT(\':\', pushrecords.port),\'\'), pushrecords.destscript)', '\'\'', 'pushrecords.name', 'pushrecords.whereclause != \'select\'', NULL, 'tbld:73adc80f-7f0e-e340-937e-41194c5bda29', 'mod:b2d42220-443b-fe74-dbdb-ed2c0968c38c', 1, NOW(), 1, NOW());