# Presupuestos de los pacientes

## 📋 Descripción
Esta consulta extrae datos anonimizados de los pacientes relacionados con los presupuestos registrados en la base de datos de la clínica dental. Combina información de las tablas de presupuestos y pacientes para ofrecer un análisis más detallado. Es útil para el seguimiento de presupuestos y análisis demográficos básicos.

## 🔍 Detalles de la Consulta
- **Tablas involucradas**: `Presu`, `Pacientes`
- **Columnas seleccionadas**:
  - De la tabla `Presu`: `IdPac`, `NumPre`, `FecPresup`, `FecAcepta`, `FecRechaz`, `IdCol`, `Ident`, `Estado`
  - De la tabla `Pacientes`: `FecNacim`, `Sexo`, `CP`, `IdProfesio`, `IdEcivil`, `NumHijos`
- **Columna calculada**:
  - `EdadPresup`: Edad del paciente en la fecha del presupuesto.
- **Filtros aplicados**: ninguno

## 📌 Ejemplo de Consulta
```sql
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
```

## 🛠️ Uso

1. Copia y pega la consulta en tu cliente SQL. Nosotros utilizamos **Microsoft SQL Server Management Studio (SSMS)**.
2. Ejecuta la consulta para obtener un listado actualizado.
3. Opcional: puedes aplicar filtros adicionales a la consulta según las necesidades específicas.

## 📖 Notas Adicionales

Si necesitas incluir más columnas, como información adicional de los pacientes o presupuestos, simplemente añádelas en la cláusula SELECT y ajusta los JOIN si es necesario.

Recuerda respetar las políticas de privacidad de los datos.

