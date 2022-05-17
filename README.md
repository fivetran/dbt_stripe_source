<p align="center">
    <a alt="License"
        href="https://github.com/fivetran/dbt_stripe_source/blob/main/LICENSE">
        <img src="https://img.shields.io/badge/License-Apache%202.0-blue.svg" /></a>
    <a alt="Fivetran-Release"
        href="https://fivetran.com/docs/getting-started/core-concepts#releasephases">
        <img src="https://img.shields.io/badge/Fivetran Release Phase-_Beta-orange.svg" /></a>
    <a alt="dbt-core">
        <img src="https://img.shields.io/badge/dbt_Core™_version->=1.0.0_<2.0.0-orange.svg" /></a>
    <a alt="Maintained?">
        <img src="https://img.shields.io/badge/Maintained%3F-yes-green.svg" /></a>
    <a alt="PRs">
        <img src="https://img.shields.io/badge/Contributions-welcome-blueviolet" /></a>
</p>

# Stripe Source dbt Package ([Docs](https://fivetran.github.io/dbt_stripe_source/))
# 📣 What does this dbt package do?
- Materializes [Stripe staging tables](https://fivetran.github.io/dbt_stripe_source/#!/overview/stripe_source/models/?g_v=1&g_e=seeds) which leverage data in the format described by [this ERD](https://fivetran.com/docs/applications/stripe/#schemainformation). These staging tables clean, test, and prepare your Stripe data from [Fivetran's connector](https://fivetran.com/docs/applications/stripe) for analysis by doing the following:
  - Name columns for consistency across all packages and for easier analysis
  - Adds freshness tests to source data
  - Adds column-level testing where applicable. For example, all primary keys are tested for uniqueness and non-null values.
- Generates a comprehensive data dictionary of your Stripe data through the [dbt docs site](https://fivetran.github.io/dbt_stripe_source/).
- These tables are designed to work simultaneously with our [Stripe transformation package](https://github.com/fivetran/dbt_stripe).

# 🎯 How do I use the dbt package?
## Step 1: Prerequisites
To use this dbt package, you must have the following:
- At least one Fivetran stripe connector syncing data into your destination. 
- A **BigQuery**, **Snowflake**, **Redshift**, or **PostgreSQL** destination.

## Step 2: Install the package
Include the following stripe_source package version in your `packages.yml` file.
> TIP: Check [dbt Hub](https://hub.getdbt.com/) for the latest installation instructions or [read the dbt docs](https://docs.getdbt.com/docs/package-management) for more information on installing packages.
```yaml
packages:
  - package: fivetran/stripe_source
    version: [">=0.7.0", "<0.8.0"]
```
## Step 3: Define database and schema variables
By default, this package runs using your destination and the `stripe` schema. If this is not where your stripe data is (for example, if your stripe schema is named `stripe_fivetran`), add the following configuration to your root `dbt_project.yml` file:

```yml
vars:
    stripe_database: your_destination_name
    stripe_schema: your_schema_name 
```
## Step 4: Disable models for non-existent sources
This package takes into consideration that not every Stripe account utilizes the `invoice`, `invoice_line_item`, `payment_method`, `payment_method_card`, `plan`, `subscription`, or `credit_note` features, and allows you to disable the corresponding functionality. By default, all variables' values are assumed to be `true` with the exception of `credit_note`. Add variables for only the tables you want to disable or enable respectively:

```yml
# dbt_project.yml

...
vars:
    using_invoices:        False  #Disable if you are not using the invoice and invoice_line_item tables
    using_payment_method:  False  #Disable if you are not using the payment_method and payment_method_card tables
    using_subscriptions:   False  #Disable if you are not using the subscription and plan tables.
    using_credit_notes:    True   #Enable if you are using the credit note tables.

```
## Step 5: Leveraging Subscription Vs Subscription History Sources
For Stripe connectors set up after February 09, 2022 the `subscription` table has been replaced with the new `subscription_history` table. By default this package will look for your subscription data within the `subscription` source table. However, if you have a newer connector then you must leverage the `stripe__subscription_history` to have the package use the `subscription_history` source rather than the `subscription` table.
> **Please note that if you have `stripe__subscription_history` enabled then the package will filter for only active records.**
```yml
vars:
    stripe__subscription_history: True  # False by default. Set to True if your connector syncs the `subscription_history` table. 
```
## (Optional) Step 6: Additional configurations
<details><summary>Expand to view configurations</summary>

### Running on Live vs Test Customers
By default, this package will run on non-test data (`where livemode = true`) from the source Stripe tables. However, you may want to include and focus on test data when testing out the package or developing your analyses. To run on only test data, add the following configuration to your root `dbt_project.yml` file:

```yml
vars:
    stripe_source:
        using_livemode: false  # Default = true
```
### Including sub Invoice Line Items
By default, this package will filter out any records from the `invoice_line_item` source table which include the string `sub_`. This is due to a legacy Stripe issue where `sub_` records were found to be duplicated. However, if you highly utilize these records you may wish they be included in the final output of the `stg_stripe__invoice_line_item` model. To do, so you may include the below variable configuration in your root `dbt_project.yml`:
```yml
vars:
    stripe_source:
        using_invoice_line_sub_filter: false # Default = true
```

### Pivoting out Metadata Properties
By default, this package selects the `metadata` JSON field within the `customer`, `charge`, `invoice`, `payment_intent`, `payment_method`, `payout`, `plan`, `refund`, and `subscription` source tables. However, you likely have properties within the `metadata` JSON field you would like to pivot out and include in the respective downstream staging model.

If there are properties in the `metadata` JSON field that you'd like to pivot out into columns, add the respective variable(s) to your root `dbt_project.yml` file:
```yml
vars:
    stripe__charge_metadata: ['the', 'list', 'of', 'property', 'fields'] # Note: this is case-SENSITIVE and must match the casing of the property as it appears in the JSON
    stripe__invoice_metadata: ['the', 'list', 'of', 'property', 'fields'] # Note: this is case-SENSITIVE and must match the casing of the property as it appears in the JSON
    stripe__payment_intent_metadata: ['the', 'list', 'of', 'property', 'fields'] # Note: this is case-SENSITIVE and must match the casing of the property as it appears in the JSON
    stripe__payment_method_metadata: ['the', 'list', 'of', 'property', 'fields'] # Note: this is case-SENSITIVE and must match the casing of the property as it appears in the JSON
    stripe__payout_metadata: ['the', 'list', 'of', 'property', 'fields'] # Note: this is case-SENSITIVE and must match the casing of the property as it appears in the JSON
    stripe__plan_metadata: ['the', 'list', 'of', 'property', 'fields'] # Note: this is case-SENSITIVE and must match the casing of the property as it appears in the JSON
    stripe__refund_metadata: ['the', 'list', 'of', 'property', 'fields'] # Note: this is case-SENSITIVE and must match the casing of the property as it appears in the JSON
    stripe__subscription_metadata: ['the', 'list', 'of', 'property', 'fields'] # Note: this is case-SENSITIVE and must match the casing of the property as it appears in the JSON
    stripe__customer_metadata: ['the', 'list', 'of', 'property', 'fields'] # Note: this is case-SENSITIVE and must match the casing of the property as it appears in the JSON
```

### Change the build schema
By default, this package builds the stripe staging models within a schema titled (`<target_schema>` + `_stg_stripe`) in your destination. If this is not where you would like your stripe staging data to be written to, add the following configuration to your root `dbt_project.yml` file:

```yml
models:
    stripe_source:
      +schema: my_new_schema_name # leave blank for just the target_schema
```
    
### Change the source table references
If an individual source table has a different name than the package expects, add the table name as it appears in your destination to the respective variable:
> IMPORTANT: See this project's [`dbt_project.yml`](https://github.com/fivetran/dbt_stripe_source/blob/main/dbt_project.yml) variable declarations to see the expected names.
    
```yml
vars:
    stripe_<default_source_table_name>_identifier: your_table_name 
```
    
</details>

## (Optional) Step 7: Orchestrate your models with Fivetran Transformations for dbt Core™
<details><summary>Expand to view details</summary>
<br>
    
Fivetran offers the ability for you to orchestrate your dbt project through [Fivetran Transformations for dbt Core™](https://fivetran.com/docs/transformations/dbt). Learn how to set up your project for orchestration through Fivetran in our [Transformations for dbt Core™ setup guides](https://fivetran.com/docs/transformations/dbt#setupguide).
</details>
    
# 🔍 Does this package have dependencies?
This dbt package is dependent on the following dbt packages. Please be aware that these dependencies are installed by default within this package. For more information on the following packages, refer to the [dbt hub](https://hub.getdbt.com/) site.
> IMPORTANT: If you have any of these dependent packages in your own `packages.yml` file, we highly recommend that you remove them from your root `packages.yml` to avoid package version conflicts.
```yml
packages:
    - package: fivetran/fivetran_utils
      version: [">=0.3.0", "<0.4.0"]

    - package: dbt-labs/dbt_utils
      version: [">=0.8.0", "<0.9.0"]
```
          
# 🙌 How is this package maintained and can I contribute?
## Package Maintenance
The Fivetran team maintaining this package _only_ maintains the latest version of the package. We highly recommend that you stay consistent with the [latest version](https://hub.getdbt.com/fivetran/stripe_source/latest/) of the package and refer to the [CHANGELOG](https://github.com/fivetran/dbt_stripe_source/blob/main/CHANGELOG.md) and release notes for more information on changes across versions.

## Contributions
A small team of analytics engineers at Fivetran develops these dbt packages. However, the packages are made better by community contributions! 

We highly encourage and welcome contributions to this package. Check out [this dbt Discourse article](https://discourse.getdbt.com/t/contributing-to-a-dbt-package/657) to learn how to contribute to a dbt package!

# 🏪 Are there any resources available?
- If you have questions or want to reach out for help, please refer to the [GitHub Issue](https://github.com/fivetran/dbt_stripe_source/issues/new/choose) section to find the right avenue of support for you.
- If you would like to provide feedback to the dbt package team at Fivetran or would like to request a new dbt package, fill out our [Feedback Form](https://www.surveymonkey.com/r/DQ7K7WW).
- Have questions or want to just say hi? Book a time during our office hours [on Calendly](https://calendly.com/fivetran-solutions-team/fivetran-solutions-team-office-hours) or email us at solutions@fivetran.com.
