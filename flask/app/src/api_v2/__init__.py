from flask import Blueprint
from flask_restx import Api

from .flow_sensors import namespace as flow_sensors_namespace
from .speed_sensors import namespace as speed_sensors_namespace
from .motors import namespace as motors_namespace
from .pumps import namespace as pumps_namespace
from .pump_models import namespace as pump_models_namespace
from .vendors import namespace as vendors_namespace



blueprint = Blueprint('api_v2',__name__, url_prefix='/api_v2')

api_extension = Api(
    blueprint,
    title='Industrial DB API',
    version='1.0',
    description = 'Flask-RestX extension for Profile Project Flask',
    doc='/doc'
)

api_extension.add_namespace(flow_sensors_namespace)
api_extension.add_namespace(speed_sensors_namespace)
api_extension.add_namespace(motors_namespace)
api_extension.add_namespace(pumps_namespace)
api_extension.add_namespace(pump_models_namespace)
api_extension.add_namespace(vendors_namespace)