# Citas de pacientes

## 📋 Descripción
Esta consulta extrae información anonimizada de las citas y datos de los pacientes registrados en la base de datos de la clínica dental. Además de las columnas propias de la base de datos, también se han calculado varias columnas adicionales, como la edad del paciente en la fecha de la cita (**EdadCita**). Ideal para análisis demográficos, planeación de horarios o preparación de reportes detallados.

## 🔍 Detalles de la Consulta
- **Tablas involucradas**: `DCitas`, `Pacientes`, `IconoTratAgenda`, `TSitCita`
- **Columnas seleccionadas**: 
  - De `DCitas`: `IdUsu`, `IdOrden`, `Fecha`, `Hora`, `Duracion`, `IdSitC`, `IdPac`, `Aceptada`, `HorSitCita`, `HorLlegada`, `HorConsul`, `HorFinal`, `IdCita`, `IdIcono`.
  - De `Pacientes`: `FecNacim`, `Sexo`, `CP`, `IdProfesio`, `IdEcivil`, `NumHijos`
  - De `IconoTratAgenda`: `Descripcion`
  - De `TSitCita`: `Descripcio`
- **Columnas calculadas**: `Fecha`, `EdadCita`, `Hora`, `DuracionMinutos`
- **Filtros aplicados**: `DCitas.IdPac IS NOT NULL`

## 📌 Ejemplo de Consulta
```sql
SELECT 
    DCitas.IdUsu,
    DCitas.IdOrden,
    -- Convertir la "fecha serial" Excel (INT) a un formato DD-MM-YYYY
    CONVERT(
        VARCHAR(10),
        DATEADD(DAY, DCitas.Fecha, '30-12-1899'),
        23
    ) AS Fecha,
	-- Seleccionar directamente la columna FecNacim desde la tabla Pacientes
    Pacientes.FecNacim AS FecNacim,
	-- Columna calculada EdadCita
    CASE 
        WHEN Pacientes.FecNacim IS NULL OR DCitas.Fecha IS NULL THEN NULL
        ELSE 
            DATEDIFF(YEAR, Pacientes.FecNacim, DATEADD(DAY, DCitas.Fecha, '30-12-1899'))
            - CASE
                -- Si el paciente no ha cumplido años todavía en la fecha de la cita, restar 1
                WHEN MONTH(DATEADD(DAY, DCitas.Fecha, '30-12-1899')) < MONTH(Pacientes.FecNacim)
                     OR (
                         MONTH(DATEADD(DAY, DCitas.Fecha, '30-12-1899')) = MONTH(Pacientes.FecNacim)
                         AND DAY(DATEADD(DAY, DCitas.Fecha, '30-12-1899')) < DAY(Pacientes.FecNacim)
                     )
                THEN 1 ELSE 0
              END
    END AS EdadCita,
    -- Convertir la columna Hora de segundos a formato HH:mm:ss
    CONVERT(TIME, DATEADD(SECOND, DCitas.Hora, '00:00:00')) AS Hora,
    -- Convertir la Duración de segundos a minutos
    DCitas.Duracion / 60 AS DuracionMinutos,
    DCitas.IdSitC,
    DCitas.IdPac,
	DCitas.Aceptada,
	DCitas.HorSitCita,
    -- Convertir la columna HorLlegada de segundos a formato HH:mm:ss
    CONVERT(TIME, DATEADD(SECOND, DCitas.HorLlegada, '00:00:00')) AS HorLlegada,
    -- Convertir la HorConsul de segundos a formato HH:mm:ss
    CONVERT(TIME, DATEADD(SECOND, DCitas.HorConsul, '00:00:00')) AS HorConsul,
    -- Convertir la HorFinal de segundos a formato HH:mm:ss
    CONVERT(TIME, DATEADD(SECOND, DCitas.HorFinal, '00:00:00')) AS HorFinal,
	
    DCitas.IdCita,
    DCitas.IdIcono,
    IconoTratAgenda.Descripcion AS IconoDescripcion,
    TSitCita.Descripcio AS SitCitaDescripcion,
	Pacientes.Sexo AS Sexo,
    Pacientes.CP AS CP,
    Pacientes.IdProfesio AS IdProfesio,
    Pacientes.IdEcivil AS IdEcivil,
    Pacientes.NumHijos AS NumHijos
FROM 
    DCitas
LEFT JOIN 
    IconoTratAgenda ON DCitas.IdIcono = IconoTratAgenda.IdIcono
LEFT JOIN 
    TSitCita ON DCitas.IdSitC = TSitCita.IdSitC
LEFT JOIN 
    Pacientes ON DCitas.IdPac = Pacientes.IdPac
WHERE 
    DCitas.IdPac IS NOT NULL;
```

## 🛠️ Uso
1. Copia y pega la consulta en tu cliente SQL, como **Microsoft SQL Server Management Studio (SSMS)**.
2. Ejecuta la consulta para obtener los resultados deseados.
3. Opcional: Aplica filtros adicionales en caso de necesitar información específica, como por rangos de fechas o tipos de citas.

## 📖 Notas Adicionales
- **Anonimización**: Asegúrate de que no se incluyan datos identificativos al usar los resultados fuera del ámbito interno de la clínica.
- **Personalización**: Puedes añadir más columnas relacionadas con las citas o datos del paciente según sea necesario.
- **Validación**: Verifica los resultados especialmente para las edades calculadas en la columna **EdadCita** en casos de fechas fuera de rango.

