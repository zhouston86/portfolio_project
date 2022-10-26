from flask import Blueprint, jsonify, request, abort
from ..models import db, Motor


# Config this for each equipment type
entity_class = Motor
table_name = 'motors'
url_pre = ('/' + table_name)
required_attributes = ('tag_name', 'pump_id')


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
            print('ERROR1')
            return abort(400)
    
    e = entity_class()

    for attr in e.serialize().keys():
        if attr in request.json:
            setattr(e,attr,request.json[attr])


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