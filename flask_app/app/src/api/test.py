from flask import Blueprint, jsonify, request, abort


bp = Blueprint('test', __name__, url_prefix='/test')


@bp.route('', methods=['GET'])
def index():
    result = "Test Successful."
    return jsonify(result)
