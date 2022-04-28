[![Apache License](https://img.shields.io/badge/License-Apache%202.0-blue.svg)](https://opensource.org/licenses/Apache-2.0) 
# Stripe 

This package models Stripe data from [Fivetran's connector](https://fivetran.com/docs/applications/stripe). It uses data in the format described by [this ERD](https://fivetran.com/docs/applications/stripe#schemainformation).

This package enriches your Fivetran data by doing the following:
* Add descriptions to tables and columns that are synced using Fivetran
* Add freshness tests to source data
* Add column-level testing where applicable. For example, all primary keys are tested for uniqueness and non-null values.
* Model staging tables, which will be used in our transform package

## Models

This package contains staging models, designed to work simultaneously with our [Stripe modeling package](https://github.com/fivetran/dbt_stripe).  The staging models are designed to:
* Remove any rows that are soft-deleted
* Name columns consistently across all packages:
    * Boolean fields are prefixed with `is_` or `has_`
    * Timestamps are appended with `_at`
    * ID primary keys are prefixed with the name of the table.  For example, the card table's ID column is renamed `card_id`.


## Installation Instructions
Check [dbt Hub](https://hub.getdbt.com/) for the latest installation instructions, or [read the dbt docs](https://docs.getdbt.com/docs/package-management) for more information on installing packages.

Include in your `packages.yml`

```yaml
packages:
  - package: fivetran/stripe_source
    version: [">=0.6.0", "<0.7.0"]
```

## Configuration
By default, this package will look for your Stripe data in the `stripe` schema of your [target database](https://docs.getdbt.com/docs/running-a-dbt-project/using-the-command-line-interface/configure-your-profile). If this is not where your Stripe data is, add the following configuration to your `dbt_project.yml` file:

```yml
# dbt_project.yml

...
config-version: 2

vars:
    stripe_schema: your_schema_name
    stripe_database: your_database_name 
```

### Disabling Models
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
### Leveraging Subscription Vs Subscription History Sources
For Stripe connectors set up after February 09, 2022 the `subscription` table has been replaced with the new `subscription_history` table. By default this package will look for your subscription data within the `subscription` source table. However, if you have a newer connector then you must leverage the `stripe__subscription_history` to have the package use the `subscription_history` source rather than the `subscription` table.
> **Please note that if you have `stripe__subscription_history` enabled then the package will filter for only active records.**
```yml
# dbt_project.yml

...
vars:
    stripe__subscription_history: True  # False by default. Set to True if your connector syncs the `subscription_history` table. 
```

### Changing the Build Schema
By default this package will build the Stripe staging models within a schema titled (<target_schema> + `_stg_stripe`). If this is not where you would like your Stripe staging models to be written to, add the following configuration to your `dbt_project.yml` file:

```yml
# dbt_project.yml

...
models:
  stripe_source:
    +schema: my_new_staging_models_schema # leave blank for just the target_schema

```

*Read more about using custom schemas in dbt [here](https://docs.getdbt.com/docs/building-a-dbt-project/building-models/using-custom-schemas).*

### Running on Live vs Test Customers
By default, this package will run on non-test data (`where livemode = true`) from the source Stripe tables. However, you may want to include and focus on test data when testing out the package or developing your analyses. To run on only test data, add the following configuration to your `dbt_project.yml` file:

```yml
# dbt_project.yml

vars:
    stripe_source:
        using_livemode: false  # Default = true
```
### Including sub Invoice Line Items
By default, this package will filter out any records from the `invoice_line_item` source table which include the string `sub_`. This is due to a legacy Stripe issue where `sub_` records were found to be duplicated. However, if you highly utilize these records you may wish they be included in the final output of the `stg_stripe__invoice_line_item` model. To do, so you may include the below variable configuration:
```yml
# dbt_project.yml

vars:
    stripe_source:
        using_invoice_line_sub_filter: false # Default = true
```

### Pivoting out Metadata Properties
By default, this package selects the `metadata` JSON field within the `customer`, `charge`, `invoice`, `payment_intent`, `payment_method`, `payout`, `plan`, `refund`, and `subscription` source tables. However, you likely have properties within the `metadata` JSON field you would like to pivot out and include in the respective downstream staging model.

If there are properties in the `metadata` JSON field that you'd like to pivot out into columns, add the respective variable(s) to your dbt_project.yml file:
```yml
# dbt_project.yml

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
## Contributions

Additional contributions to this package are very welcome! Please create issues
or open PRs against `master`. Check out 
[this post](https://discourse.getdbt.com/t/contributing-to-a-dbt-package/657) 
on the best workflow for contributing to a package.

## Database support
This package has been tested on BigQuery, Snowflake, Postgres, and Redshift.

### Resources:
- Provide [feedback](https://www.surveymonkey.com/r/DQ7K7WW) on our existing dbt packages or what you'd like to see next
- Have questions, feedback, or need help? Book a time during our office hours [using Calendly](https://calendly.com/fivetran-solutions-team/fivetran-solutions-team-office-hours) or email us at solutions@fivetran.com
- Find all of Fivetran's pre-built dbt packages in our [dbt hub](https://hub.getdbt.com/fivetran/)
- Learn how to orchestrate [dbt transformations with Fivetran](https://fivetran.com/docs/transformations/dbt)
- Learn more about Fivetran overall [in our docs](https://fivetran.com/docs)
- Check out [Fivetran's blog](https://fivetran.com/blog)
- Learn more about dbt [in the dbt docs](https://docs.getdbt.com/docs/introduction)
- Check out [Discourse](https://discourse.getdbt.com/) for commonly asked questions and answers
- Join the [chat](http://slack.getdbt.com/) on Slack for live discussions and support
- Find [dbt events](https://events.getdbt.com) near you
- Check out [the dbt blog](https://blog.getdbt.com/) for the latest news on dbt's development and best practices

