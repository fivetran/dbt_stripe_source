
with base as (

    select * 
    from {{ ref('stg_stripe__account_tmp') }}
),

fields as (

    select
        {{
            fivetran_utils.fill_staging_columns(
                source_columns=adapter.get_columns_in_relation(ref('stg_stripe__account_tmp')),
                staging_columns=get_account_columns()
            )
        }}
    from base
),

final as (
    
    select 
        id as account_id,
        business_profile_name,
        business_profile_url,
        business_type,
        charges_enabled,
        company_address_city,
        company_address_country,
        company_address_line_1,
        company_address_line_2,
        company_address_postal_code,
        company_address_state,
        company_name,
        company_owners_provided,
        company_phone,
        company_structure,
        country,
        cast(created as {{ dbt.type_timestamp() }}) as created_at,
        default_currency,
        email,
        individual_id,
        is_deleted,
        metadata,
        payouts_enabled,
        type as account_type
    from fields
)

select *
from final
