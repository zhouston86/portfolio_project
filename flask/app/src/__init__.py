import os
from flask import Flask
from flask_migrate import Migrate

# https://flask.palletsprojects.com/en/2.0.x/patterns/appfactories/
# allows set up for multiple flask webserver site versions/instances

def create_app(test_config=None):
    app = Flask(__name__, instance_relative_config=True)
    app.config.from_mapping(
        SECRET_KEY='dev',
        SQLALCHEMY_DATABASE_URI='postgresql://postgres@pg:5432/postgres',
        SQLALCHEMY_TRACK_MODIFICATIONS=False,
        SQLALCHEMY_ECHO=True
    )

    if test_config is None:
        # load the instance config, if it exists, when not testing
        app.config.from_pyfile('config.py', silent=True)
    else:
        # load the test config if passed in
        app.config.from_mapping(test_config)

    # ensure the instance folder exists
    try:
        os.makedirs(app.instance_path)
    except OSError:
        pass

    from .models import db
    db.init_app(app)
    migrate = Migrate(app, db)

    from .api import vendors, pump_models, pumps, motors, flow_sensors, speed_sensors, test
    app.register_blueprint(vendors.bp)
    app.register_blueprint(pump_models.bp)
    app.register_blueprint(pumps.bp)
    app.register_blueprint(motors.bp)
    app.register_blueprint(flow_sensors.bp)
    app.register_blueprint(speed_sensors.bp)
    app.register_blueprint(test.bp)

    from .api_v2.flow_sensors import flow_sensors_bp
    app.register_blueprint(flow_sensors_bp.blueprint)

    return app