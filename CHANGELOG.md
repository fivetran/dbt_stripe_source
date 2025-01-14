# dbt_stripe_source v0.12.2
[PR [#87](https://github.com/fivetran/dbt_stripe_source/pull/87)] includes the following updates:

## Feature Updates: Optionally convert Amounts to Major Units
- Stripe passes amount-based fields, such as `amount`, `net`, and `fee`, in the smallest denomination as raw form. This means, if your currency has minor and major units such as USD, 100 represents 100 cents, the minor unit, or 1 USD, the major unit. Alternatively, if your currency doesn't use minor units such as JPY, 100 represents 100 JPY. 

- This PR introduces a variable `stripe__convert_values` (disabled by default) which allows users the option to divide all amount-based fields by 100.
  - For information on how to enable the division, refer to the [README]((https://github.com/fivetran/dbt_stripe_source?tab=readme-ov-file#enabling-cent-to-dollar-conversion)) on configuring the `stripe__convert_values` variable.
  - Otherwise, amount-based fields will be brought through in their raw form.
  - Examples of currencies using minor units (in which enabling `stripe__convert_values` is relevant) include USD, Euro, and CAD.
  - Examples of currencies NOT using minor units (in which is makes more sense to keep the amount-based fields in raw form) include Japanese Yen (JPY), Indonesian Rupiah (IDR), and Korean Won (KRW).

## Under the Hood
  - Introduces the `convert_values` macro that holds the logic for enabling the division by 100, referenced by all amount-based fields.
  - Updates the `run_models.sh` script to test for when `stripe__convert_values` is set to True.
  - Updates the descriptions for all amount-based fields to specify the grain of the values and add information about the `stripe__convert_values` variable.

## Notes
- Note that in a future release, the division by 100 will be enabled by default instead.
- Currently this package does not support multiple currencies, but we have created a [feature flag to support multiple currencies](https://github.com/fivetran/dbt_stripe/issues/102) where you are welcome to provide feedback or contribute to the discussion.

## Documentation
- Corrected references to connectors and connections in the README. ([#88](https://github.com/fivetran/dbt_stripe_source/pull/88))

# dbt_stripe_source v0.12.1

## Feature Updates
- Declaration of passthrough variables for the `stg_stripe__card` model. This can, for example, be used to pull in non-standard columns from Stripe such as `description`, `iin` and `issuer`. See the [README](https://github.com/fivetran/dbt_stripe_source?tab=readme-ov-file#passing-through-additional-fields) for more details ([PR #81](https://github.com/fivetran/dbt_stripe_source/pull/81)).

```yaml
# dbt_project.yml

vars:
  stripe_source:
    card_pass_through_columns:
      - name: "description"
      - name: "iin"
      - name: "issuer"
        alias: "card_issuer"  # optional: define an alias for the column 
        transform_sql: "cast(card_issuer as string)" # optional: apply transformation to column. must reference the alias if provided
```

## Under the Hood
- Removed un-used columns from the `get_card_columns()` [macro](https://github.com/fivetran/dbt_stripe_source/blob/main/macros/get_card_columns.sql) and aliased the `metadata` field, which is parsed via the `stripe__card_metadata` [variable](https://github.com/fivetran/dbt_stripe_source?tab=readme-ov-file#pivoting-out-metadata-properties), but not included as a field in its entirety in `stg_stripe__card` by default ([PR #83](https://github.com/fivetran/dbt_stripe_source/pull/83)).
  - This ensures users can utilize the new `card_pass_through_columns` variable to include these fields in `stg_stripe__card`.

## Contributors
- [@bramrodenburg](https://github.com/bramrodenburg) ([#81](https://github.com/fivetran/dbt_stripe_source/pull/81))

# dbt_stripe_source v0.12.0

[PR [#77](https://github.com/fivetran/dbt_stripe_source/pull/77)] includes the following updates:

## Feature Updates
- Addition of the following new staging models and accompanying upstream references:
  - `stg_stripe__discount` (required for downstream `dbt_stripe` model transformations)
  - `stg_stripe__product` (enabled by default, but can be disabled by setting the `stripe__using_subscriptions` variable to `false`)

# dbt_stripe_source v0.11.1
[PR [#74](https://github.com/fivetran/dbt_stripe_source/pull/74)] includes the following updates:

## Bug Fix
- Removes the `unique_invoice_line_item_id` uniqueness test in `stg_stripe__invoice_line_item`. This is because `unique_invoice_line_item_id` (`unique_id` in the raw source `invoice_line_item` table) was part of an older version of Stripe that was brought forth to help migrate internal references. See the Stripe [API update](https://stripe.com/docs/upgrades#2019-12-03) for more information. The Fivetran connector persists this in order to resolve the pagination break issue for invoice line items that was introduced by the [API update](https://stripe.com/docs/upgrades#2019-12-03). 
  - Furthermore the column definition for `unique_invoice_line_item_id` (`unique_id` in the raw source `invoice_line_item` table) has been made more specific: 
    > "A unique id generated and only for old invoice line item ID's from a past version of the API. The introduction of this field resolves the pagination break issue for invoice line items, which was introduced by the [Stripe API update](https://stripe.com/docs/upgrades#2019-12-03)."

# dbt_stripe_source v0.11.0
[PR #72](https://github.com/fivetran/dbt_stripe_source/pull/72) includes the following updates:

## 🚨 Breaking Changes 🚨
- No longer filters out deleted customers in `stg_stripe__customer`.
  - Persists `is_deleted` field to differentiate between deleted and active customers.
  - Note that this is a 🚨 breaking change 🚨, as previously filtered-out records will appear in `stg_stripe__customer` (and the downstream transform `stripe__customer_overview` model).

## Feature Updates
- Adds the `phone` column to `stg_stripe__customer`. 

## Under the Hood
- Included auto-releaser GitHub Actions workflow to automate future releases.
- Updated the maintainer PR template to resemble the most up to date format.

# dbt_stripe_source v0.10.0
[PR #68](https://github.com/fivetran/dbt_stripe_source/pull/68) includes the following updates:
## Updates
- Adds the `dispute` and `transfer` objects and respective staging models.

# dbt_stripe_source v0.9.3
v0.9.3 includes the following updates:
## Under the Hood:
- [PR #67](https://github.com/fivetran/dbt_stripe_source/pull/67) moves the live_mode predicate to the non *_tmp staging models. 
    - This move is necessary due to the [0.4.3 release of fivetran_utils](https://github.com/fivetran/dbt_fivetran_utils/releases/tag/v0.4.3), which infers if the source table a package is present, and if not the package will create an empty table to ensure the downstream transformations succeed. Previously the Stripe package wasn't compatible because of where the live_mode predicate existed. In the case there will be an empty data model created, we needed to move the predicate so that the queries and downstream models will still run correctly.
- [PR #66](https://github.com/fivetran/dbt_stripe_source/pull/66) incorporates the new `fivetran_utils.drop_schemas_automation` macro into the end of each Buildkite integration test job and updates the pull request [templates](/.github).
# dbt_stripe_source v0.9.2
PR [#64](https://github.com/fivetran/dbt_stripe_source/pull/64) includes the following updates:
## Bug Fixes
- The `stg_stripe__fee` uniqueness test has been updated to also consider the `index` when determining the unique combination of columns. As there may be many indexes to a single fee, the uniqueness test has been updated to account for this scenario.

## Contributors
- [@jmussitsch](https://github.com/jmussitsch) ([#64](https://github.com/fivetran/dbt_stripe_source/pull/64))

# dbt_stripe_source v0.9.1
PR [#61](https://github.com/fivetran/dbt_stripe_source/pull/61) includes the following updates:
## Feature Updates
- Included the metadata pivot functionality for the `card` and `invoice_line_item` staging models using the respective `stripe__card_metadata` and `stripe__invoice_line_item_metadata` variables.

## Contributors
- [@LewisDavies](https://github.com/LewisDavies) ([#61](https://github.com/fivetran/dbt_stripe_source/pull/61))

# dbt_stripe_source v0.9.0

[PR #59](https://github.com/fivetran/dbt_stripe_source/pull/59) contains the following changes:
## 🚨 Breaking Changes 🚨:
- Variable names have been updated to contain the `stripe` prefix, allowing you to configure global variables while only affecting the Stripe package. 

| **Previous Name**                          | **New Name**                                                                                                                                                                                                                             |
|--------------------------------|------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| using_invoices    | stripe__using_invoices
| using_credit_notes | stripe__using_credit_notes
| using_payment_method | stripe__using_payment_method
| using_livemode | stripe__using_livemode
| using_invoice_line_sub_filter | stripe__using_invoice_line_sub_filter
| using_subscriptions | stripe__using_subscriptions
| using_subscription_history | stripe__using_subscription_history

- `stg_stripe__plan` has been changed to `stg_stripe__price_plan`. Following Stripe's migration from the `Plan` object to the `Price` object ([Stripe doc here.](https://stripe.com/docs/billing/migration/migrating-prices)), we have added a new variable `stripe__using_price` and macro `does_table_exist` that checks if the `price` table exists. This package uses `price` by default if it exists. However, if you still have and wish to keep using `plan`, you can set `stripe__using_price` to False. For more please see the [README](https://github.com/fivetran/dbt_stripe_source#leveraging-plan-vs-price-sources)
- `stripe__plan_metadata` variable has been renamed to `stripe__price_plan_metadata`
- Stripe connectors set up after February 09, 2022 will use the `subscription_history` table, as they will no longer be syncing the `subscription` table. This package uses `subscription_history` by default if it exists. However, if you still have the `subscription` table and wish to use it instead, then set the `stripe__using_subscription_history` to False. 
## 🎉 Feature Updates 🎉: 
- Added the Union ability to allow for multiple Stripe connectors. The new `source_relation` column in each staging model will specify where each record comes from. For more information please see the [README](https://github.com/fivetran/dbt_stripe_source#unioning-multiple-stripe-connectors) [#33](https://github.com/fivetran/dbt_stripe_source/issues/33)
- Added new `price` source table in addition to new `stripe__using_price` variable. Stripe migrated the Plan API to Price API (for more information, refer to their [docs](https://stripe.com/docs/billing/migration/migrating-prices)) so we recommend using the price table. The `stripe__using_price` variable and `does_table_exist` macro checks to see if you are indeed using the `price` table. If you plan on using the `plan` table instead you may toggle this to False. For more information on how to configure, refer to the [README](https://github.com/fivetran/dbt_stripe_source#leveraging-plan-vs-price-sources). 
- Added additional fields to the following models: `stg_stripe__charge`, `stg_stripe__invoice`, `stg_stripe__invoice_line_item`,`stg_stripe__payment_method_card`, `stg_stripe__refund`, `stg_stripe__subscription`.

For more please see the [README](https://github.com/fivetran/dbt_stripe_source/#leveraging-subscription-vs-subscription-history-sources)

# dbt_stripe_source v0.8.0

## 🚨 Breaking Changes 🚨:
[PR #52](https://github.com/fivetran/dbt_stripe_source/pull/52) includes the following breaking changes:
- Dispatch update for dbt-utils to dbt-core cross-db macros migration. Specifically `{{ dbt_utils.<macro> }}` have been updated to `{{ dbt.<macro> }}` for the below macros:
    - `any_value`
    - `bool_or`
    - `cast_bool_to_text`
    - `concat`
    - `date_trunc`
    - `dateadd`
    - `datediff`
    - `escape_single_quotes`
    - `except`
    - `hash`
    - `intersect`
    - `last_day`
    - `length`
    - `listagg`
    - `position`
    - `replace`
    - `right`
    - `safe_cast`
    - `split_part`
    - `string_literal`
    - `type_bigint`
    - `type_float`
    - `type_int`
    - `type_numeric`
    - `type_string`
    - `type_timestamp`
    - `array_append`
    - `array_concat`
    - `array_construct`
- For `current_timestamp` and `current_timestamp_in_utc` macros, the dispatch AND the macro names have been updated to the below, respectively:
    - `dbt.current_timestamp_backcompat`
    - `dbt.current_timestamp_in_utc_backcompat`
- `dbt_utils.surrogate_key` has also been updated to `dbt_utils.generate_surrogate_key`. Since the method for creating surrogate keys differ, we suggest all users do a `full-refresh` for the most accurate data. For more information, please refer to dbt-utils [release notes](https://github.com/dbt-labs/dbt-utils/releases) for this update.
- Dependencies on `fivetran/fivetran_utils` have been upgraded, previously `[">=0.3.0", "<0.4.0"]` now `[">=0.4.0", "<0.5.0"]`.
- Updated README to include instructions on how to use metadata variable in cases of dictionary arguments. ([#57](https://github.com/fivetran/dbt_stripe_source/pull/57))


# dbt_stripe_source v0.7.4
## Under the Hood
- The `plan_interval` field within the `stg_stripe__plan` model has been aliased within the `get_plan_columns()` macro to allow for more flexibility across warehouses. ([#58](https://github.com/fivetran/dbt_stripe_source/pull/58))
- BuildKite testing has been added. ([#58](https://github.com/fivetran/dbt_stripe_source/pull/58))
# dbt_stripe_source v0.7.3
## Feature Updates
- The `period_start` and `period_end` fields have been added to the `stg_stripe__invoice` model. ([#51](https://github.com/fivetran/dbt_stripe_source/pull/51))

## Contributors
- [lijol](https://github.com/lijol) ([#50](https://github.com/fivetran/dbt_stripe_source/pull/51))


# dbt_stripe_source v0.7.2

## 🎉 Feature Updates
- Databricks compatibility 🧱 ([#47](https://github.com/fivetran/dbt_stripe_source/pull/47))
# dbt_stripe_source v0.7.1
## 🎉 Documentation and Feature Updates
- Add timezone notation to timestamp column definition ([#42](https://github.com/fivetran/dbt_stripe_source/pull/42))
- Addition of subscription ID in the `stg_stripe__invoice` model ([#41](https://github.com/fivetran/dbt_stripe_source/pull/41))

## Contributors
- [mvtemple](https://github.com/mvtemple) ([#43](https://github.com/fivetran/dbt_stripe_source/issues/43))
- [ashishk-de](https://github.com/ashishk-de) ([#44](https://github.com/fivetran/dbt_stripe_source/issues/44))

# dbt_stripe_source v0.7.0
## 🎉 Documentation and Feature Updates
- Updated README documentation updates for easier navigation and setup of the dbt package
- Included `stripe_[source_table_name]_identifier` variable for additional flexibility within the package when source tables are named differently.
# dbt_stripe_source v0.6.0
- Stripe connectors set up after February 09, 2022 no longer sync the `subscription` table; however, a newer `subscription_history` table is synced. To account for this change a variable `stripe__subscription_history` has been added to the package project to allow for users to define if their source contains the `subscription_history` table. ([#37](https://github.com/fivetran/dbt_stripe_source/pull/37))
  - By default this variable is set to `false`. If you still have the `subscription` table, then there is no adjustment needed on your end. If you do have the `subscription_history` table then you will want to set the variable to `true`. 
  - Similarly, if you have both tables, then I highly encourage you start leveraging the `subscription_history` source table in your package.

## Features
- Added Postgres support for the Stripe package ([#39](https://github.com/fivetran/dbt_stripe_source/pull/39))

## Contributors
- [nachimehta](https://github.com/nachimehta) ([#37](https://github.com/fivetran/dbt_stripe_source/pull/37))

# dbt_stripe_source v0.5.1

## Under the Hood
- Addresses a bug in which timestamp columns in the `balance_transaction` source table are brought in as `timestamp with time zone` on Redshift and Postgres, which caused downstream datatype errors. These columns are now always cast as `timestamp without time zone` in the staging `balance_transaction` model ([#22](https://github.com/fivetran/dbt_stripe/issues/22)).

# dbt_stripe_source v0.5.0

🎉 dbt v1.0.0 Compatibility 🎉
## 🚨 Breaking Changes 🚨
- Adjusts the `require-dbt-version` to now be within the range [">=1.0.0", "<2.0.0"]. Additionally, the package has been updated for dbt v1.0.0 compatibility. If you are using a dbt version <1.0.0, you will need to upgrade in order to leverage the latest version of the package.
  - For help upgrading your package, I recommend reviewing this GitHub repo's Release Notes on what changes have been implemented since your last upgrade.
  - For help upgrading your dbt project to dbt v1.0.0, I recommend reviewing dbt-labs [upgrading to 1.0.0 docs](https://docs.getdbt.com/docs/guides/migration-guide/upgrading-to-1-0-0) for more details on what changes must be made.
- Upgrades the package dependency to refer to the latest `dbt_fivetran_utils`. The latest `dbt_fivetran_utils` package also has a dependency on `dbt_utils` [">=0.8.0", "<0.9.0"].
  - Please note, if you are installing a version of `dbt_utils` in your `packages.yml` that is not in the range above then you will encounter a package dependency error.

# dbt_stripe_source v0.4.4

## Features
- Add customer metadata to the `stg_stripe__customer` model. 

## Under the Hood
- Allow metadata passthrough functionality for the customer staging model. Please see the [README](https://github.com/fivetran/dbt_stripe_source#pivoting-out-metadata-properties) for more details on how to pivot out metadata properties. ([#30](https://github.com/fivetran/dbt_stripe_source/pull/30))

# dbt_stripe_source v0.1.0 -> v0.4.4
Refer to the relevant release notes on the Github repository for specific details for the previous releases. Thank you!
