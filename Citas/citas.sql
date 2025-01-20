SELECT 
    DCitas.IdUsu,
    DCitas.IdOrden,
    DCitas.Fecha,
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
    TSitCita.Descripcio AS SitCitaDescripcion
FROM 
    DCitas
LEFT JOIN 
    IconoTratAgenda ON DCitas.IdIcono = IconoTratAgenda.IdIcono
LEFT JOIN 
    TSitCita ON DCitas.IdSitC = TSitCita.IdSitC;
