import os

from flask import Flask
from sqlalchemy import (
    Column,
    Engine,
    Integer,
    MetaData,
    String,
    Table,
    create_engine,
    select,
)

metadata = MetaData()
engine: Engine = create_engine(
    f"mysql+pymysql://{os.environ['DB_USER']}:{os.environ['DB_PASSWORD']}@{os.environ['DB_HOST']}/{os.environ['DB_SERVICE']}?charset=utf8mb4",
    connect_args={"ssl": {"ca": "./tools/DigiCertGlobalRootCA.crt.pem"}},
)

products = Table(
    "products",
    metadata,
    Column("id", Integer, primary_key=True, autoincrement=True),
    Column("name", String(50), nullable=False),
)
metadata.create_all(engine)

app = Flask(__name__)


@app.route("/")
def fetch_products():
    return [tuple(row) for row in engine.connect().execute(select(products)).fetchall()]


@app.route("/initialize")
def insert_products():
    with engine.connect() as conn:
        conn.execute(products.delete())
        conn.execute(products.insert().values(id=1, name="table"))
        conn.execute(products.insert().values(id=2, name="monitor"))
        conn.commit()
        return [tuple(row) for row in conn.execute(select(products)).fetchall()]


if __name__ == "__main__":
    app.run(host="0.0.0.0", port=8080)
