{% macro livemode_predicate() %}

{{ adapter.dispatch('livemode_predicate', 'stripe_source') () }}

{%- endmacro %}

{% macro default__livemode_predicate()  %}

    where cast(livemode as {{ dbt.type_boolean() }} ) = {{ var('stripe__using_livemode', true) }}

{%- endmacro %}

{% macro redshift__livemode_predicate()  %}

    where decode(livemode, 'true', true, 'false', false) = {{ var('stripe__using_livemode', true) }}

{%- endmacro %}