# Industrial DB Portfolio Project
## Description
This project is the SQL portfolio project for nucamp. I chose to use a very simple industrial vendor, pump, motor, and sensor database for illustration.

## ER Diagram
Because a picture is worth a million words, here is the ER diagram describing the database implementation.
    ![My ER Diagram](/docs/industrial_process_er_rev2.svg)

## Flask/Docker Compose
This version of the project is built using Docker Compose and Flask. You should be able to build the project using "docker compose up -d" from the terminal. This will build and run a flask web server, postgres database, and a pgadmin container. 

## Kubernetes
The project can also be deployed using kubernetes. See "minikube_env_start.txt" on how to start a local minikube environment running the flask application, postgres database, and pgadmin.

## Azure CI/CD
The Github actions is configured to deploy the project to Azure. However the service principle is a GitHub secret that any other contributors would need access to. To deploy this in your own Azure environment, you just need to setup AKS with a container node, then create your own secret [using the link here](https://github.com/marketplace/actions/azure-login).

## API Reference

### Swagger

A Swagger Docs can be accessed at [Swagger](http://localhost:5000/api_v2/doc) . This is the recommmended methods to see API docs.

### Insomnia 

A sample [Insomnia](https://insomnia.rest/) collection is located in [/insomnia_collection](/insomnia_collection)

The REST api has the following endpoints:

### -- For all equipment --
    
The following requests work for all object types including:
<ul>
    <li>vendors</li>
    <li>pump_models</li>
    <li>pumps</li>
    <li>motors</li>
    <li>flow_sensors</li>
    <li>speed_sensors</li>
    <li>flow_timeseries</li>
    <li>speed_timeseries</li>
</ul>



**GET /{object_type}** </br>
Gets an index of all objects of that type.</br>

Example:</br>
    GET/pumps
        
**GET /{object_type}/:id**</br>
Gets data for instance of object_type</br>

Example: </br>
    GET/pumps/1

**POST /{object_type}**
Creates a new object_type</br>
For motors, a pump must be created first, since they are a non-nullable, one-to-one relationship</br>
Data should be in json format</br>
See ER diagram for nullable and unique attributes</br>

Example: </br>
POST /pumps
    {
        "tag_name":"67M1020",
        "model":"ZachTechMotorXL",
        "pump_id":5,
        "max_speed":7200
    }   

**DELETE /{object_type}/:id**</br>
Removes object from database</br>

Example:</br>
    DELETE /pumps/22

**PATCH/{object_type}/:id**</br>
Updates object attributes.</br>
Data should be in json format.</br>
See ER diagram for nullable and unique attributes.</br>

Example:</br>

PATCH /pumps/22
{
    "max_speed":9600
}   

### --Special Endpoints--

Flow sensors and speed sensors have a special endpoint that allow users to get the most recent value measured, or historical values.

**GET /{flow_sensors or speed_sensors}/:id/value**</br>
Gets the most recent measured value for the specific sensor</br>

Example:</br>
    GET/flow_sensors/1/value

**GET /{flow_sensors or speed_sensors}/:id/history**
Gets historical data for the specified sensors.</br>
Optional parameters "start" and "end" for date range</br>
Currently takes/returns integer values for time (from 0 to 600 for development system)</br>

Example:</br>
GET/flow_sensors/1/history
{
    "start":100,
    "end":200
}

## Testing
TBC...

## Report

Question 1:
How did the project's design evolve over time?

<ul>
    <li>I started without the pump_models table, which cause problems mapping to vendors. So I added that</li>
    <li>I realized a lot of the API queries were basically the same, so I wrote reusable code for many API endpoints.</li>
    <li>Once we decided to add data to satisify the week 4 requirements, I added historical data tables. I used stackoverflow for guidance on how to best do that.</li>
</ul>

Question 2:
Did you choose to go with the ORM or raw SQL approach? What was the reason for your choice?

I went with the ORM method, because after the lectures I didn't feel I understood it well, and this was an opportunity to test and build my understanding. I did use some raw SQL queries though when populating data using [create_sensor_data_tables_indexes.py](/sql_files/create_sensor_data_tables_indexes.py)

Question 3:
What future improvements are in store, if any?
<ul>
    <li>I need to get rid of the "current_value" for sensors, since that has been replaced with the hisorical data. I could update my database to update that value with a trigger!</li>
    <li>I would create API endpoints to handle some special requests that join data. Such as return prices for instances of pumps in the field.</li>
    <li>I would like to include some plots for historical data queries, but I read online that it is somewhat tricky without using HTML. Maybe use pandas along with it.</li>
    <li>Since most the API requests have the same code, I should be able to move those requests into common_requests.py. However flask gave an error that I needed to call a function under the decorator. Probably just need some troubleshooting/research</li>
</ul>
