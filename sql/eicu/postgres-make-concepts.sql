\echo ''
\echo '==='
\echo 'Beginning to create materialized views for EICU database.'
\echo 'Any notices of the form  "NOTICE: materialized view "XXXXXX" does not exist" can be ignored.'
\echo 'The scripts drop views before creating them, and these notices indicate nothing existed prior to creating the view.'
\echo '==='
\echo ''

\cd :concepts_dir
-- Set the search_path, i.e. the location at which we generate tables.
-- postgres looks at schemas sequentially, so this will generate tables on the mimiciv_derived schema

-- NOTE: many scripts *require* you to use mimiciv_derived as the schema for outputting concepts
-- change the search path at your peril!

\i basic_demographics.sql
\i labsfirstday.sql
\i icustay_detail.sql
-- diagnosis
\i diagnosis/apache-groups.sql

-- pivoted
\i pivoted/pivoted-bg.sql
\i pivoted/pivoted-infusion.sql
\i pivoted/pivoted-lab.sql
\i pivoted/pivoted-med.sql
\i pivoted/pivoted-o2.sql
\i pivoted/pivoted-oasis.sql
\i pivoted/pivoted-score.sql
\i pivoted/pivoted-treatment-vasopressor.sql
\i pivoted/pivoted-uo.sql
\i pivoted/pivoted-vital-other.sql
\i pivoted/pivoted-vital.sql
\i pivoted/pivoted-weight.sql
