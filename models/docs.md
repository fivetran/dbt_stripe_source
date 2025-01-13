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

{% docs city -%}
City, district, suburb, town, or village.
{%- enddocs %}

{% docs country -%}
Two-letter country code (ISO 3166-1 alpha-2).
{%- enddocs %}

{% docs line_1 -%}
Address line 1 (e.g., street, PO Box, or company name).
{%- enddocs %}

{% docs line_2 -%}
Address line 2 (e.g., apartment, suite, unit, or building).
{%- enddocs %}

{% docs postal_code -%}
ZIP or postal code.
{%- enddocs %}

{% docs state -%}
State, county, province, or region.
{%- enddocs %}

{% docs convert_values -%}
By default, this value kept in its raw form. However, in some currencies, it may be useful to divide the value by 100 to get the major currency unit. This works for scenarios in which the currency has a minor unit, which is displayed in the raw data, and major unit. For example, if in USD, if the raw value is 100, this represents 100 cents which then gets converted to $1 dollar, the major currency unit. To invoke the division, set the variable stripe__convert_values to True (False by default). If your currency does not contain minor units (for example the Japanese Yen ¥ which does not use decimals), you can run the package as-is. Note that in a future release, the division by 100 will be enabled by default instead.
{%- enddocs %}
