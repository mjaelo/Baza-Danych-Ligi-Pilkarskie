--reset tabeli 
delete from [Ranking Pilkarzy]


set @id_dr  = ABS(CHECKSUM(NEWID()) % 5)
set @sezon  = 2010
set @id_zaw =1

set @limit_zaw  = (Select [Limit Zawodnikow w Druzynie]from Limity where [ID Ligi]=@id_ligi)	
set @limit_dr  =(Select [Limit Druzyn w Lidze] from Limity where [ID Ligi]=@id_ligi)		
set @limit_lat  =(Select [Limit Lat]  from Limity where [ID Ligi]=@id_ligi)

set @max_z =0
set @max_d =0
set @max_id =0
set @temp =0

WHILE @sezon <= @limit_lat
BEGIN
	set @id_zaw=1
	set @max_z=0
	set @temp=0
	While @id_zaw<= @limit_dr*@limit_zaw
	begin
		set @temp=
		(select count([ID Zawodnika]) from Wydarzenia
		where [Opis Wydarzenia]='GOL' and Sezon=@sezon and [ID Zawodnika]=@id_zaw)
		insert into [Ranking Pilkarzy] values (@id_zaw,@temp,@sezon);
		if @temp>@max_z
		begin
			set @max_z =@temp
			set @max_id=@id_zaw
		end;
		set @id_zaw = @id_zaw+1
	end;
	set @id_zaw = @max_id
	--select @max_id,@max,@sezon

	--insert into [Ranking Pilkarzy] values (@id_zaw,@max_z,@sezon);
	set @sezon=@sezon +1
end;


/*
select * from [Ranking Pilkarzy]
order by Sezon,[Strzelone Gole]
*/

