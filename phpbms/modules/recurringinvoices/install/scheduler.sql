INSERT INTO `scheduler` (`name`, `job`, `crontab`, `lastrun`, `startdatetime`, `enddatetime`, `description`, `inactive`, `createdby`, `creationdate`, `modifiedby`, `modifieddate`) VALUES ('Recurr Invoices','../recurringinvoices/scheduler_recurr.php','0::0::*::*::*',NULL,'0000-00-00 00:00:00',NULL,'This job recurrs any invoices with repeat options.',0,1,NOW(),1,NOW());