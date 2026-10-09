import psycopg2
from psycopg2.extensions import connection


def main() -> int:
    print("Hello World")

    conn: connection = psycopg2.connect(
        host="dpg-db3qr88m7kps73fnpveg-a.virginia-postgres.render.com",
        port=5432,
        dbname="dbfall26",
        user="my_user",
        password="URE5x3wYbKwSomimD1fcx7zhKOnjHaez",
        sslmode="require",
    )
    print("Conectado a Render")
    conn.close()

    return 1


if __name__ == "__main__":
    if main() == -1:
        raise Exception()