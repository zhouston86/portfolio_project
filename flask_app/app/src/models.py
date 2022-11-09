# from flask_sqlalchemy package, import the SQLAlchemy base class that defines a database adapter
from flask_sqlalchemy import SQLAlchemy

# create database adapter class, including model
db = SQLAlchemy()

# like SQLAlchemy requires base class...


class Flow_sensor(db.Model):

    def serialize(self):
        return {
            'id': self.id,
            'tag_name': self.tag_name,
            'model':self.model,
            'max_range':self.max_range,
            'min_range':self.min_range,
            'current_value': self.current_value,
            'pump_id': self.pump_id
        }

    __tablename__ = 'flow_sensors'
    id = db.Column(db.Integer, primary_key=True, autoincrement=True)
    tag_name = db.Column(db.String(32), unique=True, nullable=False)
    model = db.Column(db.String(128))
    min_range = db.Column(db.Float)
    max_range = db.Column(db.Float)
    current_value = db.Column(db.Float, nullable=False)
    # FK relationship
    pump_id = db.Column(db.Integer, db.ForeignKey('pumps.id'))
    flow_timeseries = db.relationship("Flow_timeseries", back_populates = "flow_sensor")

class Flow_timeseries(db.Model):
    def serialize(self):
        return {
            'sensor_id':self.sensor_id,
            'time': self.time,
            'value': self.value
        }
    
    __tablename__ = 'flow_timeseries'
    time = db.Column(db.Integer, primary_key = True)
    sensor_id = db.Column(db.Integer, db.ForeignKey('flow_sensors.id'),primary_key = True)
    value = db.Column(db.Float)
    flow_sensor = db.relationship("Flow_sensor", back_populates="flow_timeseries")

class Motor(db.Model):

    def serialize(self):
        return {
            'id': self.id,
            'tag_name': self.tag_name,
            'model':self.model,
            'max_speed':self.max_speed,
            'pump_id':self.pump_id
        }

    __tablename__ = 'motors'
    id = db.Column(db.Integer, primary_key=True, autoincrement=True)
    tag_name = db.Column(db.String(32), unique=True, nullable=False)
    model = db.Column(db.String(128))
    max_speed = db.Column(db.Integer)
    pump_id = db.Column(db.Integer, db.ForeignKey('pumps.id'))
    speed_sensors = db.relationship(
        'Speed_sensor', backref='motor', cascade="all,delete")


class Pump(db.Model):

    def serialize(self):
        return {
            'id': self.id,
            'tag_name': self.tag_name,
            'model_id':self.model_id,
        }

    __tablename__ = 'pumps'
    id = db.Column(db.Integer, primary_key=True, autoincrement=True)
    tag_name = db.Column(db.String(32), unique=True, nullable=False)
    model_id = db.Column(db.String(128), db.ForeignKey(
        'pump_models.id'), nullable=False)
    motor = db.relationship(
        'Motor', backref='motor', cascade="all,delete")
    flow_sensors = db.relationship(
        'Flow_sensor', backref='pump', cascade="all,delete")


class Pump_model(db.Model):

    def serialize(self):
        return {
            'id': self.id,
            'make': self.make,
            'model': self.model,
            'max_flow': self.max_flow
        }

    __tablename__ = 'pump_models'
    id = db.Column(db.Integer, primary_key=True, autoincrement=True)
    make = db.Column(db.String(128),  nullable=False)
    model = db.Column(db.String(128), nullable=False)
    max_flow = db.Column(db.Float)
    pumps = db.relationship('Pump', backref='pump_model', cascade="all,delete")


class Speed_sensor(db.Model):

    def serialize(self):
        return {
            'id': self.id,
            'tag_name': self.tag_name,
            'type':self.type,
            'current_value': self.current_value,
            'motor_id': self.motor_id
        }

    __tablename__ = 'speed_sensors'
    id = db.Column(db.Integer, primary_key=True, autoincrement=True)
    tag_name = db.Column(db.String(32), unique=True, nullable=False)
    type = db.Column(db.String)
    current_value = db.Column(db.Float, nullable=False) 
    # FK relationship
    motor_id = db.Column(db.Integer, db.ForeignKey('motors.id'))
    speed_timeseries = db.relationship("Speed_timeseries", back_populates = "speed_sensor")

class Speed_timeseries(db.Model):
    def serialize(self):
        return {
            'sensor_id':self.sensor_id,
            'time': self.time,
            'value': self.value
        }
    
    __tablename__ = 'speed_timeseries'
    time = db.Column(db.Integer, primary_key = True)
    sensor_id = db.Column(db.Integer, db.ForeignKey('speed_sensors.id'),primary_key = True)
    value = db.Column(db.Float)
    speed_sensor = db.relationship("Speed_sensor", back_populates="speed_timeseries")

# vendors-pump models bridge table
vendors_pump_models = db.Table(
    'vendors_pump_models',
    db.Column('vendor_id',
              db.Integer,
              db.ForeignKey('vendors.id'),
              primary_key=True
              ),
    db.Column(
        'model_id',
        db.Integer,
        db.ForeignKey('pump_models.id'),
        primary_key=True
    ),
    db.Column(
        'pump_price',
        db.Float
    )
)


class Vendor(db.Model):

    # create serialize method to convert to plaintext dict
    def serialize(self):
        return {
            'id': self.id,
            'name': self.name
        }

    # configure sqldb parameters
    __tablename__ = 'vendors'
    id = db.Column(db.Integer, primary_key=True, autoincrement=True)
    name = db.Column(db.String(128), unique=True, nullable=False)

