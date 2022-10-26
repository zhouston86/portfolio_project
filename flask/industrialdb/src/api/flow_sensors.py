
from flask import Blueprint, appcontext_popped, jsonify, request, abort, json
from ..models import Flow_timeseries, db, Flow_sensor
import sqlalchemy

# Config this for each equipment type
entity_class = Flow_sensor
table_name = 'flow_sensors'
url_pre = ('/' + table_name)
required_attributes = ('tag_name', 'current_value')


# Below should not require changes for each class
bp = Blueprint(table_name, __name__, url_prefix=url_pre)

@bp.route('', methods = ['GET'])
def index():
    result = []
    for record in db.session.query(entity_class):
        result.append(record.serialize())
    return jsonify(result)

@bp.route('/<int:id>', methods = ['GET'])
def show(id:int):
    e = entity_class.query.get_or_404(id)
    return jsonify(e.serialize())


@bp.route('', methods = ['POST'])
def create():

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


@bp.route('/<int:id>', methods = ['DELETE'])
def delete(id:int):
    e = entity_class.query.get_or_404(id)

    try:
        db.session.delete(e)
        db.session.commit()
        return jsonify(True)
    except:
        return abort(400)
        
@bp.route('/<int:id>', methods = ['PUT','PATCH'])
def update(id:int):
    e = entity_class.query.get_or_404(id)
    es = e.serialize()


    for attr in request.json:
        if attr in es.keys():
            setattr(e, attr, request.json[attr])
    
    db.session.commit()
    return jsonify(True)

@bp.route('<int:id>/history', methods = ['GET'])
def get_history(id:int):
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
        Flow_timeseries.value, Flow_timeseries.time).join(
        Flow_sensor).filter(
            Flow_sensor.id == id  
        ).filter(
            Flow_timeseries.time >= start
        ).filter(
            Flow_timeseries.time <= end
        )

    results = db.session.execute(q)
    results_dict = []

    for each in results:
        dict_entry = {'tag_name': e.tag_name,'time': each[1], 'value':each[0]}
        results_dict.append(dict_entry)

    return jsonify(results_dict)

@bp.route('<int:id>/value', methods = ['GET'])
def get_value(id:int):
    e = entity_class.query.get_or_404(id)

    q = db.session.query(
        Flow_timeseries.value, Flow_timeseries.time).join(
        Flow_sensor).filter(
        Flow_sensor.id == id    
        ).order_by(sqlalchemy.desc(Flow_timeseries.time)).first()

    

    q_dict = {'tag_name': e.tag_name,'time': q[1], 'value': q[0]}

    return jsonify(q_dict)