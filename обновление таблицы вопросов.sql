INSERT INTO questions (section_id, question, answer, content_type, is_new)
SELECT 
    section_id,
    group_concat(question, '\n\n') AS question,
    CASE 
        WHEN answer LIKE '%http%://%' OR answer LIKE '%www.%' THEN 
            'Медиа-контент: ' || group_concat(answer, '\n\n')
        ELSE 
            group_concat(answer, '\n\n')
    END AS answer,
    CASE 
        WHEN answer LIKE '%http%://%' OR answer LIKE '%www.%' THEN 'text'
        ELSE 'html'
    END AS content_type,
    1 AS is_new
FROM 
    spp_requests
WHERE 
    status = 'processed' AND answer IS NOT NULL
GROUP BY 
    section_id;