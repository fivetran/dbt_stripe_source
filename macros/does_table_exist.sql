{%- macro does_table_exist(table_name) -%}
{{ adapter.dispatch('does_table_exist', 'stripe_source')(table_name) }}
{%- endmacro %}

{%- macro default__does_table_exist(table_name) -%}
    {%- if execute -%}
        {%- for node in graph.sources.values() -%} -- grab sources from the dictionary of nodes 
        -- call the database for the matching table
            {%- if node.name | lower == table_name | lower -%} 
                {%- set source_relation = adapter.get_relation(
                        database=var('stripe_database', node.database),
                        schema=var('stripe_schema', node.schema),
                        identifier=var('stripe_' ~ table_name ~ '_identifier', node.identifier)
                        ) -%}
                {{ return('exists' if source_relation is not none) }}
            {% endif %}
        {%- endfor -%}
    {%- endif -%}
{%- endmacro -%}