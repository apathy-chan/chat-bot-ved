INSERT INTO questions (section_id, question, answer, content_type, is_new)
SELECT 
    sr.section_id, 
    sr.question, 
    sr.answer, 
    'html', 
    1  -- Пометка, что это новый вопрос
FROM 
    spp_requests sr
WHERE 
    sr.status = 'processed' AND
    sr.answer IS NOT NULL AND
    NOT EXISTS (
        SELECT 1 FROM questions q 
        WHERE q.question = sr.question AND q.section_id = sr.section_id
    );