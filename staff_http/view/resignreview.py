from flask import Blueprint
from extension import db
from models import Staff,Admin_op_record,Admin_user,Resign,Department
from flask import jsonify
from flask import request
from flask_jwt_extended import jwt_required,get_jwt_identity
from until import getDate
from setting import redis_client


resignreview = Blueprint('resignreview',__name__)
