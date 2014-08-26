delimiter $$
create procedure repair_auto_increment(IN db varchar(10))
	begin
	declare tmp_name char(30) default "";
	declare tmp_cursor cursor for
		select TABLE_NAME FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA=db;
	DECLARE CONTINUE HANDLER FOR SQLSTATE '02000' SET tmp_name = null;
	
	open tmp_cursor;
	fetch tmp_cursor into tmp_name;
	while(tmp_name is not null)
	do
		set @sql = concat('alter table ', tmp_name);
		set @sql = concat(@sql, ' auto_increment=1');
		prepare stmt from @sql;
		execute stmt;
		fetch tmp_cursor into tmp_name;
	end while;

	close tmp_cursor;

	end
$$
delimiter ;
