import psycopg2
import random
import matplotlib.pyplot as plt
import numpy as np
import datetime


# quick and dirty script to populate sensor data into the database. 

conn = psycopg2.connect(
    """
    dbname=my_pumps user=postgres host=localhost port=5432
    """

)

conn.set_session(autocommit=True)
cur = conn.cursor()

# Create DB table

cur.execute(
    """
    DROP TABLE IF EXISTS timeseries; 
    DROP TABLE IF EXISTS flow_timeseries; 
    DROP TABLE IF EXISTS speed_timeseries; 
    """
)

# need separates tables for each due to conflicting sensor_id
# use btree index for timestamps
cur.execute(
    """
        CREATE TABLE flow_timeseries(
            sensor_id INT,
            time INT,
            PRIMARY KEY (time, sensor_id),
            value REAL,
            FOREIGN KEY (sensor_id)
            REFERENCES flow_sensors
        );

        CREATE INDEX flow_time_b_index ON flow_timeseries(time);
        CREATE INDEX flow_time_hash_index ON flow_timeseries(sensor_id);

        CREATE TABLE speed_timeseries(
            sensor_id INT,
            time INT,
            PRIMARY KEY (time, sensor_id),
            value REAL,
            FOREIGN KEY (sensor_id)
            REFERENCES speed_sensors
        );

        CREATE INDEX speed_time_b_index ON flow_timeseries(time);
        CREATE INDEX speed_time_hash_index ON flow_timeseries(sensor_id);       
    """
)


num = 60
y = np.random.rand(num)*100
x = np.linspace(0, 600, num)

plt.plot(x,y)

# populate flow sensors
cur.execute(
    """
    SELECT id FROM flow_sensors;
    """
)

flow_sensor_query = cur.fetchall()
flow_sensor_ids = []

for each in flow_sensor_query:
    flow_sensor_ids.append(each[0])


for each in flow_sensor_ids:
    np.random.seed()
    y = np.random.rand(num)*100
    sensor_id_list = [each for i in range(num)]

    for i in range(0, num, 1):
        inserted_list=(sensor_id_list[i], round(x[i]), y[i])

        print(inserted_list)

        cur.execute(
        """
            INSERT INTO flow_timeseries (sensor_id, time, value)
            VALUES (%s, %s, %s);
        """, inserted_list)

# Repeate for speed sensors 

cur.execute(
    """
    SELECT id FROM speed_sensors;
    """
)

speed_sensors_query = cur.fetchall()
speed_sensors_ids = []

for each in speed_sensors_query:
    speed_sensors_ids.append(each[0])


for each in speed_sensors_ids:
    np.random.seed()
    y = np.random.rand(num)*100

    sensor_id_list = [each for i in range(num)]

    for i in range(0, num, 1):
        inserted_list=(sensor_id_list[i], round(x[i]), y[i])

        print(inserted_list)

        cur.execute(
        """
            INSERT INTO speed_timeseries (sensor_id, time, value)
            VALUES (%s, %s, %s);
        """, inserted_list)

