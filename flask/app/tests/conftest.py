from src.models import db
from src.models import Flow_sensor
from pytest import fixture
import pytest
import psycopg2

@pytest.fixture()
def new_flow_sensor():
    flow_sensor = Flow_sensor(
            tag_name = '99FT999',
            model = 'FT_TEST',
            max_range = 100,
            min_range = 0,
            current_value = 1
        )
    return flow_sensor

@pytest.fixture(scope='session')
def session():
    conn = psycopg2.connect(host="localhost", database="pg", user="postgres")
    session = conn.cursor()
    yield session
    # Close the cursor and connection
    session.close()
    conn.close()