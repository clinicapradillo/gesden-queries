SELECT
    Presu.IdPac,
    Presu.NumPre,
    Presu.FecPresup,
    Presu.FecAcepta,
    Presu.FecRechaz,
    Presu.IdCol,
    Presu.Ident,
    Presu.Estado,
    Pacientes.FecNacim,
    Pacientes.Sexo,
    Pacientes.CP,
    Pacientes.IdProfesio,
    Pacientes.IdEcivil,
    Pacientes.NumHijos,
    DATEDIFF(YEAR, Pacientes.FecNacim, Presu.FecPresup) - 
        CASE 
            WHEN MONTH(Pacientes.FecNacim) > MONTH(Presu.FecPresup) 
                 OR (MONTH(Pacientes.FecNacim) = MONTH(Presu.FecPresup) AND DAY(Pacientes.FecNacim) > DAY(Presu.FecPresup)) 
            THEN 1 
            ELSE 0 
        END AS EdadPresup
FROM 
    Presu
LEFT JOIN 
    Pacientes ON Presu.IdPac = Pacientes.IdPac;
