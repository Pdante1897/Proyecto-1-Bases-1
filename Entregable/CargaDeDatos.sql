drop table Big_Smoke_Data_Temp


CREATE GLOBAL TEMPORARY TABLE  Big_Smoke_Data_Temp (
    NOMBRE_EMPLEADO VARCHAR(200) null,
    APELLIDO_EMPLEADO VARCHAR(200) null,
    DIRECCION_EMPLEADO VARCHAR(200) null,
    TELEFONO_EMPLEADO VARCHAR(200) null,
    GENERO_EMPLEADO VARCHAR(50) null,
    FECHA_NACIMIENTO_EMPLEADO TIMESTAMP null,
    TITULO_DEL_EMPLEADO VARCHAR(200) null,
    NOMBRE_PACIENTE VARCHAR(200) null,
    APELLIDO_PACIENTE VARCHAR(200) null,
    DIRECCION_PACIENTE VARCHAR(200) null,
    TELEFONO_PACIENTE VARCHAR(200) null,
    GENERO_PACIENTE VARCHAR(50) null,
    FECHA_NACIMIENTO_PACIENTE TIMESTAMP null,
    ALTURA NUMBER null,
    PESO NUMBER null,
    FECHA_EVALUACION TIMESTAMP null,
    SINTOMA_DEL_PACIENTE VARCHAR(200) null,
    DIAGNOSTICO_DEL_SINTOMA VARCHAR(200) null,
    RANGO_DEL_DIAGNOSTICO NUMBER null,
    FECHA_TRATAMIENTO TIMESTAMP null,
    TRATAMIENTO_APLICADO VARCHAR(200)null
)

select count(*) from Big_Smoke_Data_Temp

-- Tabla Genero

select COUNT(*),GENERO_PACIENTE from Big_Smoke_Data_Temp  GROUP BY GENERO_PACIENTE HAVING COUNT(*)>1
INSERT INTO GENERO (NOMBRE_GE) (select GENERO_PACIENTE from Big_Smoke_Data_Temp  GROUP BY GENERO_PACIENTE HAVING COUNT(*)>1);

-- Tabla Profesion

select TITULO_DEL_EMPLEADO from Big_Smoke_Data_Temp  GROUP BY TITULO_DEL_EMPLEADO HAVING COUNT(*)>1
INSERT INTO PROFESION (nombre_profesion) (select TITULO_DEL_EMPLEADO from Big_Smoke_Data_Temp  GROUP BY TITULO_DEL_EMPLEADO HAVING COUNT(*)>1);

-- Tabla Sintoma

select SINTOMA_DEL_PACIENTE from Big_Smoke_Data_Temp  GROUP BY SINTOMA_DEL_PACIENTE HAVING COUNT(*)>1
INSERT INTO SINTOMA (nombre_sintoma) (select SINTOMA_DEL_PACIENTE from Big_Smoke_Data_Temp  GROUP BY SINTOMA_DEL_PACIENTE HAVING COUNT(*)>1);

-- Tabla Tratamiento

select TRATAMIENTO_APLICADO from Big_Smoke_Data_Temp  GROUP BY TRATAMIENTO_APLICADO HAVING COUNT(*)>0
INSERT INTO TRATAMIENTO (nombre_tra) (select TRATAMIENTO_APLICADO from Big_Smoke_Data_Temp  GROUP BY TRATAMIENTO_APLICADO HAVING COUNT(*)>0);

-- Tabla Diagnostico

select DIAGNOSTICO_DEL_SINTOMA from Big_Smoke_Data_Temp  GROUP BY DIAGNOSTICO_DEL_SINTOMA HAVING COUNT(*)>0
INSERT INTO DIAGNOSTICO (nombre_DIAG) (select DIAGNOSTICO_DEL_SINTOMA from Big_Smoke_Data_Temp  GROUP BY DIAGNOSTICO_DEL_SINTOMA HAVING COUNT(*)>0);

-- Tabla Paciente
insert into PACIENTE (nombre_pa, apellidos_pa, direccion_pa, telefono_pa, fecha_nac_pa, altura, peso, genero)
(select NOMBRE_PACIENTE, APELLIDO_PACIENTE, DIRECCION_PACIENTE, TELEFONO_PACIENTE, FECHA_NACIMIENTO_PACIENTE, ALTURA, PESO , id_genero
from Big_Smoke_Data_Temp join GENERO on GENERO_PACIENTE=nombre_ge 
GROUP BY NOMBRE_PACIENTE, APELLIDO_PACIENTE, DIRECCION_PACIENTE, TELEFONO_PACIENTE, id_genero, FECHA_NACIMIENTO_PACIENTE, ALTURA, PESO  HAVING COUNT(*)>0);
  
 

-- Tabla Empleado
insert into EMPLEADO (nombre_em, apellidos_em, direccion_em, telefono_em, fecha_nac_em, profesion, genero)
(select NOMBRE_EMPLEADO, APELLIDO_EMPLEADO, DIRECCION_EMPLEADO, TELEFONO_EMPLEADO, FECHA_NACIMIENTO_EMPLEADO, id_profesion, id_genero 
from Big_Smoke_Data_Temp join GENERO on GENERO_EMPLEADO=nombre_ge 
join PROFESION on TITULO_DEL_EMPLEADO = nombre_profesion
GROUP BY NOMBRE_EMPLEADO, APELLIDO_EMPLEADO, DIRECCION_EMPLEADO, TELEFONO_EMPLEADO, id_genero, id_profesion , FECHA_NACIMIENTO_EMPLEADO HAVING COUNT(*)>0);

-- Tabla Lista Tratamientos
 
 insert into LISTA_TRATAMIENTO (paciente, tratamiento, fecha_trat)
(select id_paciente, id_trat, FECHA_TRATAMIENTO 
from Big_Smoke_Data_Temp join PACIENTE on TELEFONO_PACIENTE=telefono_pa and NOMBRE_PACIENTE =nombre_pa and APELLIDO_PACIENTE = apellidos_pa 
join TRATAMIENTO on nombre_tra = TRATAMIENTO_APLICADO
GROUP BY id_paciente, id_trat, FECHA_TRATAMIENTO HAVING COUNT(*)>0)

-- Tabla Diagnostico

insert into EVALUACION (empleado, paciente, fecha_ev)
(select id_empleado, id_paciente, FECHA_EVALUACION 
from Big_Smoke_Data_Temp inner join PACIENTE on TELEFONO_PACIENTE=telefono_pa and NOMBRE_PACIENTE =nombre_pa and APELLIDO_PACIENTE = apellidos_pa
join EMPLEADO on TELEFONO_EMPLEADO=telefono_em and NOMBRE_EMPLEADO =nombre_em and APELLIDO_EMPLEADO = apellidos_em 
GROUP BY id_paciente, id_empleado, FECHA_EVALUACION HAVING COUNT(*)>0);

-- Tabla Diagnostico_Ge
insert into DIAGNOSTICO_GE (rango, sintoma, diagnostico, evaluacion)
(select RANGO_DEL_DIAGNOSTICO, id_sintoma, id_diagnostico, id_evaluacion 
from evaluacion  join PACIENTE on id_paciente=paciente 
 join EMPLEADO on id_empleado=empleado 
 join Big_Smoke_Data_Temp on TELEFONO_PACIENTE=telefono_pa and NOMBRE_PACIENTE =nombre_pa and APELLIDO_PACIENTE = apellidos_pa 
    and TELEFONO_EMPLEADO=telefono_em and NOMBRE_EMPLEADO =nombre_em and APELLIDO_EMPLEADO = apellidos_em 
 join sintoma on nombre_sintoma=SINTOMA_DEL_PACIENTE
 join diagnostico on nombre_diag=DIAGNOSTICO_DEL_SINTOMA);