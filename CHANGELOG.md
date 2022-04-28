# dbt_stripe_source v0.6.0
- Stripe connectors set up after February 09, 2022 no longer sync the `subscription` table; however, a newer `subscription_history` table is synced. To account for this change a variable `stripe__subscription_history` has been added to the package project to allow for users to define if their source contains the `subscription_history` table. ([#37](https://github.com/fivetran/dbt_stripe_source/pull/37))
  - By default this variable is set to `false`. If you still have the `subscription` table, then there is no adjustment needed on your end. If you do have the `subscription_history` table then you will want to set the variable to `true`. 
  - Similarly, if you have both tables, then I highly encourage you start leveraging the `subscription_history` source table in your package.

## Features
- Added Postgres support for the Stripe package ([#39](https://github.com/fivetran/dbt_stripe_source/pull/39))
- 
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
