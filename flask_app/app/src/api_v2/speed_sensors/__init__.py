
from flask import request, jsonify, abort
from flask_restx import Namespace, Resource, fields
from http import HTTPStatus
from ...models import Speed_timeseries, db, Speed_sensor
import sqlalchemy

namespace = Namespace('speed_sensors', 'Speed Sensor Endpoints')

entity_class = Speed_sensor
table_name = 'speed_sensors'
url_pre = ('/' + table_name)
required_attributes = ('tag_name', 'current_value')

post_device_model = namespace.model('Speed Sensor Device',{
    'tag_name': fields.String(
        description = 'Tag name for specific device'
    ),
    'current_value': fields.Float(
        description = 'Calibrated Value'
    ),
    'max_range': fields.Float(
        description = 'Maximum Calibrated Range'
    ),
    'min_range': fields.Float(
        description = 'Minimum Calibrated Range'
    ),
    'model': fields.String(
        description = 'Transmitter Make and Model'
    ),
    'pump_id': fields.Integer(
        description = 'Asset ID for associated pump'
    )
})

history_model = namespace.model('Device History',{
    'start': fields.Integer(
        description = 'Start time (0 to 600)'
    ),
    'end': fields.Integer(
        description = 'End time (0 to 600)'
    )
})

# TODO: change returned values to flask-restx marshal format
# device_model = namespace.model('Speed Sensor Device',{
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

@namespace.route('/<int:id>/history')
class history(Resource):

    @namespace.expect(history_model)
    def post(self, id:int):
        '''Retrieve time series data for specific sensor. Uses POST due to Swagger limitations.'''
        e = entity_class.query.get_or_404(id)

        if 'start' not in request.json:
            start = 0
        else:
            start = request.json['start']
        
        if 'end' not in request.json:
            # TODO: need to update for datetime
            end = 10000000
        else:
            end = request.json['end']

        q = db.session.query(
            Speed_timeseries.value, Speed_timeseries.time).join(
            Speed_sensor).filter(
                Speed_sensor.id == id  
            ).filter(
                Speed_timeseries.time >= start
            ).filter(
                Speed_timeseries.time <= end
            )

        results = db.session.execute(q)
        results_dict = []

        for each in results:
            dict_entry = {'tag_name': e.tag_name,'time': each[1], 'value':each[0]}
            results_dict.append(dict_entry)

        return jsonify(results_dict)

@namespace.route('/<int:id>/value')
class value(Resource):

    def get(self, id:int):
        '''GET the most recent sensor value'''
        e = entity_class.query.get_or_404(id)

        q = db.session.query(
            Speed_timeseries.value, Speed_timeseries.time).join(
            Speed_sensor).filter(
            Speed_sensor.id == id    
            ).order_by(sqlalchemy.desc(Speed_timeseries.time)).first()

        q_dict = {'tag_name': e.tag_name,'time': q[1], 'value': q[0]}

        return jsonify(q_dict)