CREATE TABLE `registrations` (
  `registration_id` int(11) NOT NULL AUTO_INCREMENT,
  `registration_type` varchar(255) DEFAULT NULL,
  `registration_fname` varchar(150) NOT NULL,
  `registration_lname` varchar(150) NOT NULL,
  `registration_organization` text,
  `registration_address1` varchar(150) DEFAULT NULL,
  `registration_address2` varchar(255) DEFAULT NULL,
  `registration_fax` varchar(100) DEFAULT NULL,
  `registration_email` varchar(100) DEFAULT NULL,
  `registration_phone` varchar(100) DEFAULT NULL,
  `registration_phoneext` varchar(100) DEFAULT NULL,
  `registration_city` varchar(150) DEFAULT NULL,
  `registration_state` varchar(50) DEFAULT NULL,
  `registration_zip` varchar(25) DEFAULT NULL,
  `registration_title` varchar(150) DEFAULT NULL,
  `registration_filename` varchar(255) DEFAULT NULL,
  `registration_description` text,
  `registration_dateadded` datetime DEFAULT NULL,
  `registration_lastupdated` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `registration_deleted` tinyint(4) NOT NULL DEFAULT '0',
  `registration_eventid` int(11) NOT NULL DEFAULT '0',
  `registration_hash` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`registration_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

CREATE TABLE `states` (
  `stateid` int(11) NOT NULL AUTO_INCREMENT,
  `state` varchar(30) NOT NULL DEFAULT '',
  `abbrv` varchar(2) NOT NULL DEFAULT '',
  UNIQUE KEY `stateid` (`stateid`)
) ENGINE=MyISAM AUTO_INCREMENT=55 DEFAULT CHARSET=utf8;

INSERT INTO `states` VALUES (1,'Alabama','AL'),(2,'Alaska','AK'),(3,'Arizona','AZ'),(4,'Arkansas','AR'),(5,'California','CA'),(6,'Colorado','CO'),(7,'Connecticut','CT'),(8,'Delaware','DE'),(9,'District of Columbia','DC'),(10,'Florida','FL'),(11,'Georgia','GA'),(12,'Guam','GU'),(13,'Hawaii','HI'),(14,'Idaho','ID'),(15,'Illinois','IL'),(16,'Indiana','IN'),(17,'Iowa','IA'),(18,'Kansas','KS'),(19,'Kentucky','KY'),(20,'Louisiana','LA'),(21,'Maine','ME'),(22,'Maryland','MD'),(23,'Massachusetts','MA'),(24,'Michigan','MI'),(25,'Minnesota','MN'),(26,'Mississippi','MS'),(27,'Missouri','MO'),(28,'Montana','MT'),(29,'Nebraska','NE'),(30,'Nevada','NV'),(31,'New Hampshire','NH'),(32,'New Jersey','NJ'),(33,'New Mexico','NM'),(34,'New York','NY'),(35,'North Carolina','NC'),(36,'North Dakota','ND'),(37,'Ohio','OH'),(38,'Oklahoma','OK'),(39,'Oregon','OR'),(40,'Pennsylvania','PA'),(41,'Puerto Rico','PR'),(42,'Rhode Island','RI'),(43,'South Carolina','SC'),(44,'South Dakota','SD'),(45,'Tennessee','TN'),(46,'Texas','TX'),(47,'Utah','UT'),(48,'Vermont','VT'),(49,'Virgin Islands','VI'),(50,'Virginia','VA'),(51,'Washington','WA'),(52,'West Virginia','WV'),(53,'Wisconsin','WI'),(54,'Wyoming','WY');
