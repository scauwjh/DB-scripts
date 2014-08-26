drop procedure if exists get_all_links;
delimiter $$
create procedure get_all_links()
	begin
	
	declare c_content text;
	declare i_done int default 0; 
	declare tmp_action varchar(100);
	declare tmp_power tinyint;
	
	declare c_cursor cursor for
		select C_ACTION,B_POWER from p_link where I_ID in
		(select max(I_ID) from p_link group by C_ACTION);
	declare continue handler for sqlstate '02000' set i_done = 1;
	
	open c_cursor;
	set c_content = '';
	repeat
		fetch c_cursor into tmp_action,tmp_power;
		if not i_done then
			set c_content = concat(c_content, tmp_action, '=', tmp_power, char(13));
		end if;
	until i_done end repeat;
	close c_cursor;
	
	select c_content into outfile 'D:\\action.properties';
	
	end
$$
delimiter ;

call get_all_links();
drop procedure get_all_links;
