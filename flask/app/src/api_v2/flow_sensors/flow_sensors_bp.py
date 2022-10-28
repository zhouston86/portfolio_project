from flask import Blueprint
from flask_restx import Api

from .flow_sensors_ns import namespace as flow_sensors_namespace

blueprint = Blueprint('api_v2',__name__, url_prefix='/api_v2')

api_extension = Api(
    blueprint,
    title='Industrial DB API',
    version='1.0',
    description = 'Flask-RestX extension for Profile Project Flask',
    doc='/doc'
)

api_extension.add_namespace(flow_sensors_namespace)