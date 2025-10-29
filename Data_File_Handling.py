import pandas as pd
import psycopg2
# import openpyxl
from sqlalchemy import create_engine


def read_csv(file_path):
    df = pd.read_csv(file_path)
    return df
def read_excel(file_path, sheet_name=0):
    df = pd.read_excel(file_path, sheet_name=sheet_name)
    return df

def read_json(file_path):
    df = pd.read_json(file_path)
    return df




def read_db(db_config: dict, table_name: str) -> pd.DataFrame:
    """
    Read table from PostgreSQL into DataFrame.
    
    db_config should be a dict:
    {
        "dbname": "your_db",
        "user": "your_user",
        "password": "your_password",
        "host": "localhost",
        "port": 5432
    }
    """
    conn = psycopg2.connect(**db_config)
    query = f"SELECT * FROM {table_name};"
    df = pd.read_sql(query, conn)
    conn.close()
    return df

# Save functions

def save_csv(df: pd.DataFrame, file_path: str):
    """Save DataFrame to CSV"""
    df.to_csv(file_path+".csv", index=False)
    print("csv saved!")


def save_excel(df: pd.DataFrame, file_path: str, sheet_name: str = "Sheet1"):
    """Save DataFrame to Excel"""
    df.to_excel(file_path+".xlsx", index=False, sheet_name=sheet_name)
    print("excel saved!")


def save_json(df: pd.DataFrame, file_path: str):
    """Save DataFrame to JSON"""
    df.to_json(file_path+".json", orient="records")
    print("json saved!")

# , indent=4

def save_db(df: pd.DataFrame, db_config: dict, table_name: str):
    """
    Save DataFrame to PostgreSQL table.
    
    db_config should be a dict:
    {
        "dbname": "your_db",
        "user": "your_user",
        "password": "your_password",
        "host": "localhost",
        "port": 5432
    }
    """
    # Use SQLAlchemy for easier DataFrame export
    engine = create_engine(
        f"postgresql+psycopg2://{db_config['user']}:{db_config['password']}@"
        f"{db_config['host']}:{db_config['port']}/{db_config['dbname']}"
    )
    df.to_sql(table_name, engine, if_exists="replace", index=False)
    engine.dispose()
    print("db saved!")