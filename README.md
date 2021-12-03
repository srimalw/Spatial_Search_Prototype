# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version - ruby 3.0.2p107

* System dependencies - 
    #gems for open street map
    gem 'leaflet-rails'
    gem 'open_street_map'

    #gem for api documentation
    gem 'apipie-rails'

* Api Documentation can be find here
    http://localhost:3000/apipie

## Answer for question 3

* Answer 
```` 
```
DELETE FROM table1 where id IN (
select id_a as ids from table3
union
select id_b from table3 
union 
select id_b from table3
) 
```
```` 

* Queries to create db
```` 
```
CREATE TABLE IF NOT EXISTS `table1` (
  `id` INT unsigned NOT NULL,
  `other_column` varchar(200) NOT NULL,
  PRIMARY KEY (`id`)
) engine=innodb;

INSERT INTO `table1` (`id`, `other_column`) VALUES
  ('1', 'Data 1'),
  ('2', 'Data 2'),
  ('3', 'Data 3'),
  ('4', 'Data 4'),
  ('5', 'Data 5'),
  ('6', 'Data 6'),
  ('7', 'Data 7'),
  ('8', 'Data 8'),
  ('9', 'Data 9'),
  ('10', 'Data 10'),
  ('11', 'Data 11'),
  ('12', 'Data 12');
  
  
CREATE TABLE IF NOT EXISTS `table3` (
  `id_a` INT unsigned,
  `id_b` INT unsigned,
  `id_c` INT unsigned,
  `another_column` varchar(200) NOT NULL,
   CONSTRAINT fk_1 FOREIGN KEY (id_a) 
     REFERENCES table1 (id)  ON DELETE SET NULL
) engine=innodb;

ALTER TABLE `table3`  
   ADD CONSTRAINT `fk_2` 
      FOREIGN KEY (`id_b`) REFERENCES `table1` (`id`) 
      ON DELETE SET NULL;

ALTER TABLE `table3`  
   ADD CONSTRAINT `fk_3` 
      FOREIGN KEY (`id_c`) REFERENCES `table1` (`id`) 
      ON DELETE SET NULL;

INSERT INTO `table3` (`id_a`, `id_b`,`id_c`,`another_column`) VALUES
  ('1', '7', '8', 'Data 1'),
  ('2', '4', '9', 'Data 2'),
  ('3', '1', '10', 'Data 3'),
  ('8', '10', '12', 'Data 4'),
  ('5', '2', '1', 'Data 5');

```
```` 
