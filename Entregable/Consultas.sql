
--Consulta 1
select nombre_em as nombre, apellidos_em as apellidos , telefono_em as telefono, count(paciente) as pacientes 
from evaluacion inner join empleado  on id_empleado=evaluacion.empleado 
GROUP BY  nombre_em, apellidos_em, telefono_em
order by pacientes desc;

--Consulta 2


select nombre_em as nombre, apellidos_em as apellidos , direccion_em as direcciones, nombre_profesion as titulo, count(paciente) as pacientes 
from evaluacion inner join empleado  on id_empleado=evaluacion.empleado 
inner join genero on id_genero=genero and nombre_ge='M'
inner join profesion on id_profesion=profesion and fecha_ev BETWEEN '1/1/2016' and '31/12/2016'
GROUP BY  nombre_em, apellidos_em, direccion_em, nombre_profesion having count(paciente)>3
order by pacientes;

--Consulta 3

select nombre_pa as nombre, apellidos_pa as apellido from paciente 
inner join lista_tratamiento on paciente=id_paciente 
inner join tratamiento on lista_tratamiento.tratamiento=id_trat and  nombre_tra='Tabaco en polvo'
inner join evaluacion on evaluacion.paciente=id_paciente
inner join diagnostico_ge on diagnostico_ge.evaluacion=id_evaluacion
inner join sintoma on diagnostico_ge.sintoma=id_sintoma and nombre_sintoma='Dolor de cabeza'
GROUP BY nombre_pa, apellidos_pa having count(*)>1


--Consulta 4

select nombre_pa as nombre, apellidos_pa as apellido, count(id_trat) as "cantidad de tratamientos" from paciente 
inner join lista_tratamiento on paciente=id_paciente 
inner join tratamiento on lista_tratamiento.tratamiento=id_trat and  nombre_tra='Antidepresivos' 
GROUP BY nombre_pa, apellidos_pa order by"cantidad de tratamientos" desc   FETCH FIRST 5 ROWS ONLY 

--Consulta 5

select nombre_pa as nombre, apellidos_pa as apellido, direccion_pa as direccion, count(id_trat) as "cantidad de tratamientos" from paciente 
inner join lista_tratamiento on lista_tratamiento.paciente=id_paciente 
inner join tratamiento on lista_tratamiento.tratamiento=id_trat 
and  not exists (select paciente from evaluacion where id_paciente=paciente) 
GROUP BY nombre_pa, apellidos_pa, direccion_pa having count(id_trat)>3 order by"cantidad de tratamientos" desc   


--Consulta 6

select nombre_diag as nombre, count(DISTINCT id_sintoma) as "cantidad de sintomas" from diagnostico_ge 
inner join diagnostico on id_diagnostico=diagnostico_ge.diagnostico 
inner join sintoma on diagnostico_ge.sintoma=id_sintoma 
where rango=9 having count(id_sintoma)>0
GROUP BY nombre_diag order by"cantidad de sintomas" desc

--Consulta7

select nombre_pa as nombre, apellidos_pa as apellido, direccion_pa as direccion from paciente 
inner join evaluacion on paciente=id_paciente 
inner join diagnostico_ge on diagnostico_ge.evaluacion=id_evaluacion 
where rango > 5
GROUP BY nombre_pa, apellidos_pa, direccion_pa having count(id_paciente)>0 order by  nombre_pa, apellidos_pa asc  

--Consulta 8

select nombre_em as nombre, apellidos_em as apellido, fecha_nac_em as "fecha de nacimiento", count(paciente) as pacientes  from empleado
inner join genero on id_genero = empleado.genero
inner join evaluacion on id_empleado=evaluacion.empleado
where nombre_ge='F' and direccion_em='1475 Dryden Crossing'
group by nombre_em, apellidos_em, fecha_nac_em  having count(id_empleado)>1 order by pacientes desc

--Consulta 9

select DISTINCT  nombre_em as nombre, apellidos_em as apellido, 
(select count(*)from evaluacion where evaluacion.empleado=id_empleado and evaluacion.fecha_ev between '1/1/2017' and systimestamp)/(select count(*)from evaluacion )*100 as porcentaje
from empleado
inner join evaluacion on id_empleado=evaluacion.empleado and evaluacion.fecha_ev between '1/1/2017' and systimestamp
order by porcentaje desc


--Consulta 10

select DISTINCT  nombre_profesion as titulo, 
(select count(*)from empleado where empleado.profesion=id_profesion)/(select count(*)from empleado )*100 as porcentaje
from profesion
inner join empleado on id_profesion=empleado.profesion
order by porcentaje desc


--Consulta 11

select anio, mes, paciente,nombre, apellido, cantidad
    from (select DISTINCT EXTRACT(YEAR FROM fecha_ev)as anio, EXTRACT(MONTH FROM fecha_ev) as mes, id_paciente as paciente, nombre_pa as nombre, apellidos_pa as apellido, 
        (select count(*) from lista_tratamiento where id_paciente=lista_tratamiento.paciente ) as cant
        from evaluacion
        full outer join paciente on id_paciente=evaluacion.paciente
        inner join lista_tratamiento on lista_tratamiento.paciente=id_paciente 
        order by cant desc)
    where cantidad = (select max(maximo) from (select (select count(id_paciente) from lista_tratamiento where id_paciente=lista_tratamiento.paciente ) as maximo
        from evaluacion
        inner join paciente on id_paciente=evaluacion.paciente
        inner join lista_tratamiento on lista_tratamiento.paciente=id_paciente)) 
    or cant = 1