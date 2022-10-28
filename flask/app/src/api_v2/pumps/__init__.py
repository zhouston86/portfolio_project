
from flask import request, jsonify, abort
from flask_restx import Namespace, Resource, fields
from http import HTTPStatus
from ...models import db, Pump
import sqlalchemy

namespace = Namespace('pumps', 'Pump Endpoints')

entity_class = Pump
table_name = 'pumps'
url_pre = ('/' + table_name)
required_attributes = ('tag_name', 'current_value')

post_device_model = namespace.model('Pump Device',{
    'tag_name': fields.String(
        description = 'Tag name for specific device'
    ),
    'model_id': fields.Integer(
        description = 'Calibrated Value'
    )
})

# TODO: change returned values to flask-restx marshal format
# device_model = namespace.model('Pump Device',{
#     'id': fields.Integer(
#         description = 'Device Asset ID'
#     ),
#     'tag_name': fields.String(
#         description = 'Tag name for specific device'
#     ),
#     'current_value': fields.Float(
#         description = 'Calibrated Value'
#     ),
#     'max_range': fields.Float(
#         description = 'Maximum Calibrated Range'
#     ),
#     'min_range': fields.Float(
#         description = 'Minimum Calibrated Range'
#     ),
#     'model': fields.String(
#         description = 'Transmitter Make and Model'
#     ),
#     'pump_id': fields.Integer(
#         description = 'Asset ID for associated pump'
#     )
# })

@namespace.route('')
class devices(Resource):

    #@namespace.marshal_with(device_model)
    def get(self):
        '''Get list of all devices of type'''
        result = []
        for record in db.session.query(entity_class):
            result.append(record.serialize())
        return jsonify(result)

    # expect this model for post request
    @namespace.expect(post_device_model)
    def post(self):
        '''Create new device'''
        for attr in required_attributes:
            if attr not in request.json:
                return abort(400)
        
        e = entity_class()

        for attr in e.serialize().keys():
            if attr in request.json:
                setattr(e,attr,request.json[attr])
            else:
                setattr(e,attr,None)

        try:
            db.session.add(e)
            db.session.commit()
            return (e.serialize())
        except:
            return abort(400)


@namespace.route('/<int:id>')
class device(Resource):
    '''Read, update and delete a specific device'''

    def get(self, id:int):
        '''Get specific device parameters'''
        e = entity_class.query.get_or_404(id)
        es = e.serialize()
        return jsonify(es)

    def delete(self, id:int):
        e = entity_class.query.get_or_404(id)

        try:
            db.session.delete(e)
            db.session.commit()
            return jsonify(True)
        except:
            return abort(400)        

    # expect this model for post request
    @namespace.expect(post_device_model)
    def put(self, id:int):
        '''Modify specific device parameters'''
        e = entity_class.query.get_or_404(id)
        es = e.serialize()


        for attr in request.json:
            if attr in es.keys():
                setattr(e, attr, request.json[attr])
        
        db.session.commit()
        return jsonify(True)
