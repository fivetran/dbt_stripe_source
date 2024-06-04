{% macro livemode_predicate() %}

    where 
        cast(
            case when cast(livemode as {{ dbt.type_string() }} ) = 'true' then true else false end 
            as {{ dbt.type_boolean() }})
        = {{ var('stripe__using_livemode', true) }}

{%- endmacro %}