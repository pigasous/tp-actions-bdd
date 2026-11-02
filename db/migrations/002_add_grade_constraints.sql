ALTER TABLE students
    ADD CONSTRAINT grade_range CHECK (grade >= 0 AND grade <= 20);

CREATE INDEX idx_students_grade ON students (grade);
