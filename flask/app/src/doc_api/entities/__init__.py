from attr import field, fields
from flask import request
from flask_restplus import Namespace, Resource, fields

namespace = Namespace('entities', 'Entities related endpoints')

entity_model = namespace.model('entities',{
    'message': fields.String(
        readonly = True, 
        description = 'Entities model message'
        )
})

entity_example = {'message':'Entity Example'}

@namespace.route('')
class Entity(Resource)