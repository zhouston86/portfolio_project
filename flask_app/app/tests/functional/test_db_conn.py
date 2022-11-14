
from flask_app.app.src.models import db, Flow_sensor



def test_add_device_db(new_flow_sensor, session):
    db.session.add(new_flow_sensor)
    db.session.commit()
    query_result = db.session.query(Flow_sensor.tag_name == new_flow_sensor.tag_name)
    try:
        query_result.serialize()
    except:
        print('Failed db add test!')
        assert False
    else:
        print(query_result.serialize())
        db.session.delete(query_result)
        assert True