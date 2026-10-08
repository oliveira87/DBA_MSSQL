/************************************************************
 Autor: Maximiliano de Oliveira Queiroz

 Query para verificar percentual de fragmentação das tabelas
*************************************************************/
USE AdventureWorks
GO
SELECT
    DB_NAME() AS Banco,
    OBJECT_SCHEMA_NAME(ps.object_id) AS Esquema,
    OBJECT_NAME(ps.object_id) AS Tabela,
    i.name AS Indice,
    ps.index_type_desc AS TipoIndice,
    ps.avg_fragmentation_in_percent AS Fragmentacao,
    ps.page_count AS Paginas
FROM
    sys.dm_db_index_physical_stats
    (
        DB_ID(),
        NULL,
        NULL,
        NULL,
        'LIMITED'
    ) ps
INNER JOIN
    sys.indexes i
    ON ps.object_id = i.object_id
    AND ps.index_id = i.index_id
WHERE
    ps.index_id > 0
    AND ps.page_count > 1000
ORDER BY
    ps.avg_fragmentation_in_percent DESC
 GO