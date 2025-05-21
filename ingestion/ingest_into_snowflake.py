from sqlalchemy import create_engine
from sqlalchemy.exc import DatabaseError
import pandas as pd
import os
from dotenv import load_dotenv
import logging

logger = logging.getLogger(__name__)
logging.basicConfig(filename="ingestion.log")

SNOWFLAKE_USER = os.getenv("SNOWFLAKE_USER")
SNOWFLAKE_PASSWORD = os.getenv("SNOWFLAKE_PASSWORD")
SNOWFLAKE_ACCOUNT = os.getenv("SNOWFLAKE_ACCOUNT")
SNOWFLAKE_DATABASE = os.getenv("SNOWFLAKE_DATABASE")
SNOWFLAKE_SCHEMA = os.getenv("SNOWFLAKE_SCHEMA")
SNOWFLAKE_ROLE = os.getenv("SNOWFLAKE_ROLE")
SNOWFLAKE_WAREHOUSE = os.getenv("SNOWFLAKE_WAREHOUSE")
SNOWFLAKE_URL_CONNECTION = "snowflake://{user}:{password}@{account}/{database}/{schema}?role={role}&warehouse={warehouse}"


def main():
    csv_data = {
        "product_info": {"filepath": "product_info.csv", "index_col": 0},
        "reviews": {"filepath": "reviews.csv", "index_col": 1},
    }
    try:
        engine = create_engine(
            SNOWFLAKE_URL_CONNECTION.format(
                user=SNOWFLAKE_USER,
                password=SNOWFLAKE_PASSWORD,
                account=SNOWFLAKE_ACCOUNT,
                database=SNOWFLAKE_DATABASE,
                schema=SNOWFLAKE_SCHEMA,
                role=SNOWFLAKE_ROLE,
                warehouse=SNOWFLAKE_WAREHOUSE,
            )
        )

        for table_name, csv in csv_data.items():
            df = pd.read_csv(
                f"./ingestion/{csv['filepath']}",
                index_col=csv["index_col"],
                low_memory=False,
            )
            df.to_sql(table_name, engine, if_exists="replace", index=False)
            logger.info(
                f"{table_name} table loaded on {SNOWFLAKE_DATABASE} database and {SNOWFLAKE_SCHEMA} schema."
            )
    except DatabaseError as error:
        logger.error(error)


if __name__ == "__main__":
    load_dotenv()
    main()
