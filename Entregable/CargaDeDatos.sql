CREATE TABLE Big_Smoke_Data_Temp (
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

drop table Big_Smoke_Data_Temp
delete from Big_Smoke_Data_Temp
select count(*) from Big_Smoke_Data_Temp