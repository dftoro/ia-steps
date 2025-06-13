select
	filename,
	urlAbsoluta,
	max(direccion) as direccion,
	max(fachada) as fachada,
	max(envio) as envio,
	max(etiqueta) as etiqueta,
	max(planilla) as planilla
from
	(
	select
		ar.nombre as filename,
		ar.urlAbsoluta,
		GROUP_CONCAT(case ac.idCriterio when 1 then 1 else 0 end) as direccion,
		GROUP_CONCAT(case ac.idCriterio when 2 then 1 else 0 end) as fachada,
		GROUP_CONCAT(case ac.idCriterio when 3 then 1 else 0 end) as envio,
		GROUP_CONCAT(case ac.idCriterio when 4 then 1 else 0 end) as etiqueta,
		GROUP_CONCAT(case ac.idCriterio when 6 then 1 else 0 end) as planilla
	from
		archivocriterio_ci ac
	inner JOIN 
archivo_ci ar on
		ar.idArchivo = ac.idArchivo
	group by
		ar.nombre,
		ar.urlAbsoluta,
		ac.idCriterio
) as tb
group by
	filename,
	urlAbsoluta
;




select ac.idArchivo, ac.idCriterio, cr.nombre, ac2.nombre, ac2.urlAbsoluta
from archivocriterio_ci ac inner join
archivo_ci ac2 on ac2.idArchivo = ac.idArchivo inner join
criterio_ci cr on cr.idCriterio = ac.idCriterio
where ac2.nombre = '1001234722400_202311011807405880.jpg';



set @direccion = 2;
set @envio = 3;
set @etiqueta = 4;
set @fachada = 5;
set @planilla = 7;
set @inicio = '2024-12-15 00:00:00';
set @fin = '2025-03-15 23:59:59';

select
	filename,
	urlAbsoluta,
	max(direccion) as direccion,
	max(fachada) as fachada,
	max(envio) as envio,
	max(etiqueta) as etiqueta,
	max(planilla) as planilla
from
	(
	select
		ar.archivo as filename,
		ar.uriImagen as urlAbsoluta,
		GROUP_CONCAT(case ac.idArchivoCriterio when @direccion then 1 else 0 end) as direccion,
		GROUP_CONCAT(case ac.idArchivoCriterio when @fachada then 1 else 0 end) as fachada,
		GROUP_CONCAT(case ac.idArchivoCriterio when @envio then 1 else 0 end) as envio,
		GROUP_CONCAT(case ac.idArchivoCriterio when @etiqueta then 1 else 0 end) as etiqueta,
		GROUP_CONCAT(case ac.idArchivoCriterio when @planilla then 1 else 0 end) as planilla
	from
		archivoenviocriterio_env ac
	inner JOIN 
archivoenvio_lin ar on
		ar.idArchivoEnvio = ac.idArchivoEnvio
	where
		ac.creacion between @inicio and @fin
		and (ac.idArchivoCriterio = @direccion and ac.idArchivoCriterio in (@direccion, @fachada, @envio, @etiqueta, @planilla))
		and ac.idArchivoEnvio > rand() * (
		select
			max(acm.idArchivoEnvio)
		from
			archivoenviocriterio_env acm)
	group by
		ar.archivo,
		ar.uriImagen,
		ac.idArchivoCriterio
	limit 250 ) as tb
group by
	filename,
	urlAbsoluta
union all
select
	filename,
	urlAbsoluta,
	max(direccion) as direccion,
	max(fachada) as fachada,
	max(envio) as envio,
	max(etiqueta) as etiqueta,
	max(planilla) as planilla
from
	(
	select
		ar.archivo as filename,
		ar.uriImagen as urlAbsoluta,
		GROUP_CONCAT(case ac.idArchivoCriterio when @direccion then 1 else 0 end) as direccion,
		GROUP_CONCAT(case ac.idArchivoCriterio when @fachada then 1 else 0 end) as fachada,
		GROUP_CONCAT(case ac.idArchivoCriterio when @envio then 1 else 0 end) as envio,
		GROUP_CONCAT(case ac.idArchivoCriterio when @etiqueta then 1 else 0 end) as etiqueta,
		GROUP_CONCAT(case ac.idArchivoCriterio when @planilla then 1 else 0 end) as planilla
	from
		archivoenviocriterio_env ac
	inner JOIN 
archivoenvio_lin ar on
		ar.idArchivoEnvio = ac.idArchivoEnvio
	where
		ac.creacion between @inicio and @fin
		and (ac.idArchivoCriterio = @fachada and ac.idArchivoCriterio in (@direccion, @fachada, @envio, @etiqueta, @planilla))
		and ac.idArchivoEnvio > rand() * (
		select
			max(acm.idArchivoEnvio)
		from
			archivoenviocriterio_env acm)
	group by
		ar.archivo,
		ar.uriImagen,
		ac.idArchivoCriterio
	limit 250 ) as tb
group by
	filename,
	urlAbsoluta

union all 

select
	filename,
	urlAbsoluta,
	max(direccion) as direccion,
	max(fachada) as fachada,
	max(envio) as envio,
	max(etiqueta) as etiqueta,
	max(planilla) as planilla
from
	(
	select
		ar.archivo as filename,
		ar.uriImagen as urlAbsoluta,
		GROUP_CONCAT(case ac.idArchivoCriterio when @direccion then 1 else 0 end) as direccion,
		GROUP_CONCAT(case ac.idArchivoCriterio when @fachada then 1 else 0 end) as fachada,
		GROUP_CONCAT(case ac.idArchivoCriterio when @envio then 1 else 0 end) as envio,
		GROUP_CONCAT(case ac.idArchivoCriterio when @etiqueta then 1 else 0 end) as etiqueta,
		GROUP_CONCAT(case ac.idArchivoCriterio when @planilla then 1 else 0 end) as planilla
	from
		archivoenviocriterio_env ac
	inner JOIN 
archivoenvio_lin ar on
		ar.idArchivoEnvio = ac.idArchivoEnvio
	where
		ac.creacion between @inicio and @fin
		and (ac.idArchivoCriterio = @envio and ac.idArchivoCriterio in (@direccion, @fachada, @envio, @etiqueta, @planilla))
		and ac.idArchivoEnvio > rand() * (
		select
			max(acm.idArchivoEnvio)
		from
			archivoenviocriterio_env acm)
	group by
		ar.archivo,
		ar.uriImagen,
		ac.idArchivoCriterio
	limit 250 ) as tb
group by
	filename,
	urlAbsoluta

union all 

select
	filename,
	urlAbsoluta,
	max(direccion) as direccion,
	max(fachada) as fachada,
	max(envio) as envio,
	max(etiqueta) as etiqueta,
	max(planilla) as planilla
from
	(
	select
		ar.archivo as filename,
		ar.uriImagen as urlAbsoluta,
		GROUP_CONCAT(case ac.idArchivoCriterio when @direccion then 1 else 0 end) as direccion,
		GROUP_CONCAT(case ac.idArchivoCriterio when @fachada then 1 else 0 end) as fachada,
		GROUP_CONCAT(case ac.idArchivoCriterio when @envio then 1 else 0 end) as envio,
		GROUP_CONCAT(case ac.idArchivoCriterio when @etiqueta then 1 else 0 end) as etiqueta,
		GROUP_CONCAT(case ac.idArchivoCriterio when @planilla then 1 else 0 end) as planilla
	from
		archivoenviocriterio_env ac
	inner JOIN 
archivoenvio_lin ar on
		ar.idArchivoEnvio = ac.idArchivoEnvio
	where
		ac.creacion between @inicio and @fin
		and (ac.idArchivoCriterio = @etiqueta and ac.idArchivoCriterio in (@direccion, @fachada, @envio, @etiqueta, @planilla))
		and ac.idArchivoEnvio > rand() * (
		select
			max(acm.idArchivoEnvio)
		from
			archivoenviocriterio_env acm)
	group by
		ar.archivo,
		ar.uriImagen,
		ac.idArchivoCriterio
	limit 250 ) as tb
group by
	filename,
	urlAbsoluta
	
	union all 

select
	filename,
	urlAbsoluta,
	max(direccion) as direccion,
	max(fachada) as fachada,
	max(envio) as envio,
	max(etiqueta) as etiqueta,
	max(planilla) as planilla
from
	(
	select
		ar.archivo as filename,
		ar.uriImagen as urlAbsoluta,
		GROUP_CONCAT(case ac.idArchivoCriterio when @direccion then 1 else 0 end) as direccion,
		GROUP_CONCAT(case ac.idArchivoCriterio when @fachada then 1 else 0 end) as fachada,
		GROUP_CONCAT(case ac.idArchivoCriterio when @envio then 1 else 0 end) as envio,
		GROUP_CONCAT(case ac.idArchivoCriterio when @etiqueta then 1 else 0 end) as etiqueta,
		GROUP_CONCAT(case ac.idArchivoCriterio when @planilla then 1 else 0 end) as planilla
	from
		archivoenviocriterio_env ac
	inner JOIN 
archivoenvio_lin ar on
		ar.idArchivoEnvio = ac.idArchivoEnvio
	where
		ac.creacion between @inicio and @fin
		and (ac.idArchivoCriterio = @planilla and ac.idArchivoCriterio in (@direccion, @fachada, @envio, @etiqueta, @planilla))
		and ac.idArchivoEnvio > rand() * (
		select
			max(idArchivoCriterio)
		from
			archivoenviocriterio_env acm)
	group by
		ar.archivo,
		ar.uriImagen,
		ac.idArchivoCriterio
	limit 250 ) as tb
group by
	filename,
	urlAbsoluta
	;



-- muestra de 5000
set @direccion = 2;
set @envio = 3;
set @etiqueta = 4;
set @fachada = 5;
set @planilla = 7;
set @inicio = '2024-12-15 00:00:00';
set @fin = '2025-03-15 23:59:59';

select
	filename,
	urlAbsoluta,
	max(direccion) as direccion,
	max(fachada) as fachada,
	max(envio) as envio,
	max(etiqueta) as etiqueta,
	max(planilla) as planilla
from
	(
	select
		ar.archivo as filename,
		ar.uriImagen as urlAbsoluta,
		GROUP_CONCAT(case ac.idArchivoCriterio when @direccion then 1 else 0 end) as direccion,
		GROUP_CONCAT(case ac.idArchivoCriterio when @fachada then 1 else 0 end) as fachada,
		GROUP_CONCAT(case ac.idArchivoCriterio when @envio then 1 else 0 end) as envio,
		GROUP_CONCAT(case ac.idArchivoCriterio when @etiqueta then 1 else 0 end) as etiqueta,
		GROUP_CONCAT(case ac.idArchivoCriterio when @planilla then 1 else 0 end) as planilla
	from
		archivoenviocriterio_env ac
	inner JOIN archivoenvio_lin ar on
		ar.idArchivoenvio = ac.idArchivoEnvio
	where
		ac.creacion between @inicio and @fin
		and ac.idArchivoEnvio > rand() * (
		select
			max(acm.idArchivoEnvio)
		from
			archivoenviocriterio_env acm)
	group by
		ar.archivo,
		ar.uriImagen,
		ac.idArchivoCriterio 
) as tb
group by
	filename,
	urlAbsoluta
limit 5000;
