{% docs _fivetran_synced -%} The timestamp that Fivetran last synced the record. 
{%- enddocs %}

{% docs source_relation -%} The source where this data was pulled from. If you are making use of the `union_schemas` variable, this will be the source schema. If you are making use of the `union_databases` variable, this will be the source database. If you are not unioning together multiple sources, this will be an empty string.
{%- enddocs %}

{% docs created -%} Time at which the record was created. Dates in the requested timezone, or UTC if not provided.
{%- enddocs %}

{% docs created_at -%} Time at which the record was created. Dates in the requested timezone, or UTC if not provided.
{%- enddocs %}

{% docs created_utc -%}
Time at which the record was created. Dates in UTC.
{%- enddocs %}
