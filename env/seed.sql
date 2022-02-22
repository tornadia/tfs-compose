INSERT INTO `accounts` (`type`, `name`, `password`, `email`) VALUES (6, 123456, '41da8bef22aaef9d7c5821fa0f0de7cccc4dda4d', 'sampleaccount@gmail.com');

INSERT INTO `players` (`id`, `name`, `account_id`, `group_id`, `sex`, `vocation`, `experience`, `level`, `maglevel`, `health`, `healthmax`, `mana`, `manamax`, `manaspent`, `soul`, `direction`, `lookbody`, `lookfeet`, `lookhead`, `looklegs`, `looktype`, `posx`, `posy`, `posz`, `cap`, `lastlogin`, `lastlogout`, `lastip`, `save`, `conditions`, `town_id`, `balance`) VALUES 
 (1, 'Admin', 1, 6, 1, 0, 100, 999, 500, 100, 100, 100, 100, 70775, 0, 2, 10, 10, 10, 10, 75, 32368, 32215, 7, 10000, 1396046551, 1396045859, 400558280, 1, '', 1, 0),
 (2, 'Tester', 1, 1, 1, 6, 100, 250, 50, 8000, 8000, 8000, 8000, 70775, 200, 2, 10, 10, 10, 10, 75, 32368, 32215, 7, 10000, 1396046551, 1396045859, 400558280, 1, '', 1, 0);

