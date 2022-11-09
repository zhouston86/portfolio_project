from src.models import db
from src.models import Flow_sensor

def test_new_flow_sensor(new_flow_sensor):
    """
    GIVEN a new flow sensor
    WHEN a new flow sensor is create
    THEN test that current value is between the min and max range for the sensor
    """
    assert isinstance(new_flow_sensor.tag_name, str)
    assert new_flow_sensor.current_value < new_flow_sensor.max_range
    assert new_flow_sensor.current_value > new_flow_sensor.min_range
