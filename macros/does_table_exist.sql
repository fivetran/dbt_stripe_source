{%- macro does_table_exist(table_name) -%}
    {%- if execute -%} -- returns true when dbt is in execute mode
    {%- set ns = namespace(has_table=false) -%} -- declare boolean namespace and default value 
    {%- set stripe_database = var('stripe_database') -%} -- get stripe database from project.yml
    {%- set stripe_schema = var('stripe_schema') -%} -- get stripe schema from project.yml
        {%- for node in graph.sources.values() -%} -- grab sources from the dictionary of nodes 
        -- call the database for the matching table
            {%- set source_relation = adapter.get_relation(
                    database=node.database,
                    schema=node.schema,
                    identifier=node.identifier ) -%} 
            {%- if source_relation == None and node.name | lower == table_name | lower -%} 
                {{ return(False) }} -- return false if relation identified by the database.schema.identifier does not exist for the given table name
            {%- elif source_relation != None and node.name | lower == table_name | lower -%} 
                {{ return(True) }} -- otherwise return True 
            {% endif %}
        {%- endfor -%}
    {%- endif -%} 
{%- endmacro -%}
