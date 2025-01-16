# Consulta: Listado de Nombres y Edades de Pacientes

## 📋 Descripción
Esta consulta extrae los nombres y edades de todos los pacientes registrados en la base de datos. Ideal para análisis demográficos básicos o preparación de reportes.

## 🔍 Detalles de la Consulta
- **Tablas involucradas**: `Pacientes`
- **Columnas seleccionadas**: `Nombre`, `Apellido`, `FechaNacimiento`
- **Filtros aplicados**:
  - Solo pacientes activos (`Estado = 'Activo'`).

## 📌 Ejemplo de Consulta
```sql
SELECT 
    Nombre,
    Apellido,
    DATEDIFF(YEAR, FechaNacimiento, GETDATE()) AS Edad
FROM 
    Pacientes
WHERE 
    Estado = 'Activo';
```
## 🛠️ Uso

1. Copia y pega la consulta en tu cliente SQL.


2. Ejecuta la consulta para obtener un listado actualizado.


3. Opcional: Modifica el filtro Estado para incluir pacientes inactivos.



## 📖 Notas Adicionales

Si necesitas incluir más columnas, como el género o el historial médico, añade las columnas correspondientes en la cláusula SELECT.

Recuerda respetar las políticas de privacidad de los datos.
