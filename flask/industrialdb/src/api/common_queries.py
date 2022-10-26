from flask import Blueprint, jsonify, request, abort
from ..models import db, Motor, Pump, Flow_sensor, Speed_sensor, Vendor, Pump_model
import sqlalchemy

# TODO: try to combine shared queries to this file. 

def index(entity_class):
    result = []
    for record in db.session.query(entity_class):
        result.append(record.serialize())
    return jsonify(result)