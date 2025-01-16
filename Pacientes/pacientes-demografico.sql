SELECT
    -- Algunas de las columnas más relevantes de Pacientes
    
	P.IdPac,
	P.IdCliPac,
	P.NumPac,
	P.FecNacim,
	P.IdProfesio,
	P.IdEcivil,
	P.NumHijos,
	P.Sexo,
	P.CP,
	P.FecAlta,
	P.AgNumVis,
	P.IdPacReferidor,
	P.AceptaEmail,

    -- 1) Edad al día de alta
    DATEDIFF(YEAR, P.FecNacim, P.FecAlta) AS EdadAlta,

    -- 2) Edad al día de hoy
    DATEDIFF(YEAR, P.FecNacim, GETDATE()) AS EdadActual,

    -- 3) Rango de edad al alta
    CASE
        WHEN DATEDIFF(YEAR, P.FecNacim, P.FecAlta) < 13 THEN '0-12'
        WHEN DATEDIFF(YEAR, P.FecNacim, P.FecAlta) BETWEEN 13 AND 17 THEN '13-17'
        WHEN DATEDIFF(YEAR, P.FecNacim, P.FecAlta) BETWEEN 18 AND 30 THEN '18-30'
        WHEN DATEDIFF(YEAR, P.FecNacim, P.FecAlta) BETWEEN 31 AND 64 THEN '31-64'
        WHEN DATEDIFF(YEAR, P.FecNacim, P.FecAlta) >= 65 THEN '>65'
        ELSE 'Sin datos'
    END AS RangoEdadAlta,

    -- 4) Categoría de edad al alta
    CASE
        WHEN DATEDIFF(YEAR, P.FecNacim, P.FecAlta) < 13 THEN 'Niño'
        WHEN DATEDIFF(YEAR, P.FecNacim, P.FecAlta) BETWEEN 13 AND 17 THEN 'Adolescente'
        WHEN DATEDIFF(YEAR, P.FecNacim, P.FecAlta) BETWEEN 18 AND 30 THEN 'Adulto joven'
        WHEN DATEDIFF(YEAR, P.FecNacim, P.FecAlta) BETWEEN 31 AND 64 THEN 'Adulto'
        WHEN DATEDIFF(YEAR, P.FecNacim, P.FecAlta) >= 65 THEN 'Adulto mayor'
        ELSE 'Sin datos'
    END AS CategoriaRangoEdadAlta,

    -- 5) Rango de edad actual
    CASE
        WHEN DATEDIFF(YEAR, P.FecNacim, GETDATE()) < 13 THEN '0-12'
        WHEN DATEDIFF(YEAR, P.FecNacim, GETDATE()) BETWEEN 13 AND 17 THEN '13-17'
        WHEN DATEDIFF(YEAR, P.FecNacim, GETDATE()) BETWEEN 18 AND 30 THEN '18-30'
        WHEN DATEDIFF(YEAR, P.FecNacim, GETDATE()) BETWEEN 31 AND 64 THEN '31-64'
        WHEN DATEDIFF(YEAR, P.FecNacim, GETDATE()) >= 65 THEN '>65'
        ELSE 'Sin datos'
    END AS RangoEdadActual,

    -- 6) Categoría de edad actual
    CASE
        WHEN DATEDIFF(YEAR, P.FecNacim, GETDATE()) < 13 THEN 'Niño'
        WHEN DATEDIFF(YEAR, P.FecNacim, GETDATE()) BETWEEN 13 AND 17 THEN 'Adolescente'
        WHEN DATEDIFF(YEAR, P.FecNacim, GETDATE()) BETWEEN 18 AND 30 THEN 'Adulto joven'
        WHEN DATEDIFF(YEAR, P.FecNacim, GETDATE()) BETWEEN 31 AND 64 THEN 'Adulto'
        WHEN DATEDIFF(YEAR, P.FecNacim, GETDATE()) >= 65 THEN 'Adulto mayor'
        ELSE 'Sin datos'
    END AS CategoriaRangoEdadActual

FROM Pacientes AS P;
