
This project analyzes customer reviews from the Sephora product dataset using Snowflake Cortex LLM functions to extract sentiment insights at scale. It demonstrates a modern data stack pipeline — from infrastructure as code with Terraform, to transformation and modeling with dbt, all running on Snowflake.

## Overview

**Goal:** Use Snowflake Cortex's LLM capabilities to perform sentiment analysis on customer reviews.

**Dataset:** Kaggle Sephora product reviews dataset.

**Stack:**
- Infrastructure: *Terraform*
- Cloud Data Platform: *Snowflake*
- Transformation: *dbt*
- LLM Analysis: *Snowflake Cortex* function - `COMPLETE()`


## Features

- Provision Snowflake objects (warehouse, databases, schemas, roles) using Terraform

- Load and structure Sephora reviews into Snowflake

- Transform raw data using dbt models

- Apply Cortex LLM functions to:
    - Summarize customer sentiment
    - Evaluate the customer sentiment

- Enable downstream usage: dashboards, product team insights, or ML training
