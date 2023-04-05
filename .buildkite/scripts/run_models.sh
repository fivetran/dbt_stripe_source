#!/bin/bash

set -euo pipefail

apt-get update
apt-get install libsasl2-dev

python3 -m venv venv
. venv/bin/activate
pip install --upgrade pip setuptools
pip install -r integration_tests/requirements.txt
mkdir -p ~/.dbt
cp integration_tests/ci/sample.profiles.yml ~/.dbt/profiles.yml

db=$1
echo `pwd`
cd integration_tests
dbt deps
dbt seed --target "$db" --full-refresh
dbt run --target "$db" --full-refresh
dbt test --target "$db"
dbt run --vars '{stripe__using_invoice_line_sub_filter: false, stripe__using_credit_notes: true, stripe__using_price: false, stripe__using_subscription_history: false}' --full-refresh --target "$db"
dbt run --vars '{stripe__card_metadata: {"external_id"}, stripe__invoice_line_item_metadata: {"external_id"}}' --full-refresh --target "$db"
dbt test --target "$db"