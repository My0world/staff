from extension import db


# 管理系统-权限表
class Admin_authority(db.Model):
    __tablename__ = "admin_authority"
    # ID
    id = db.Column(db.Integer(),primary_key = True,autoincrement = True)
    # 一级权限名称
    one_level_name = db.Column(db.String(255),nullable = True)
    # 二级权限名称
    two_level_name = db.Column(db.String(255),nullable = True)
    # 三级权限名称
    three_level_name = db.Column(db.String(255),nullable = True)
    # 权限名称
    right_name = db.Column(db.String(30), primary_key = True)
    # 权限描述
    description = db.Column(db.Text(),nullable = False)

    # 模型的资源序列化函数（方法）
    def schema(self):
        return {
            'id': self.id,
            'one_level_name': self.one_level_name,
            'two_level_name': self.two_level_name,
            'three_level_name': self.three_level_name,
            'right_name': self.right_name, 
            'description': self.description,
        }
    
    #清空数据
    def clearData():
        Admin_authority.query.filter_by().delete()
        # 提交会话 增删改都要提交会话
        db.session.commit()
    

# 管理系统-操作记录表
class Admin_op_record(db.Model):
    __tablename__ = "admin_op_record"
    # ID
    id = db.Column(db.Integer(),primary_key = True,autoincrement = True)
    # 内容
    content = db.Column(db.Text(),nullable = False)
    # 员工ID
    staffId = db.Column(db.String(7),nullable = False)
    # 操作时间
    datetime = db.Column(db.DateTime(),nullable = False)


    # 模型的资源序列化函数（方法）
    def schema(self):
        return {
            'id': self.id,
            'content': self.content,
            'staffId': self.staffId,
            'datetime': self.datetime,
        }
    
    #清空数据
    def clearData():
        Admin_op_record.query.filter_by().delete()
        # 提交会话 增删改都要提交会话
        db.session.commit()
    

# 管理系统-操作内容审核表
class Admin_op_review(db.Model):
    __tablename__ = "admin_op_review"
    # ID
    id = db.Column(db.Integer(),primary_key = True,autoincrement = True)
    # 数据
    data = db.Column(db.Text(),nullable = False)
    # 操作描述
    description = db.Column(db.Text(),nullable = False)
    # 员工ID
    staffId = db.Column(db.String(7),nullable = False)
    # 申请时间
    datetime = db.Column(db.DateTime(),nullable = False)
    # 状态
    status = db.Column(db.String(255),nullable = False)


    # 模型的资源序列化函数（方法）
    def schema(self):
        return {
            'id': self.id,
            'data': self.data,
            'description':self.description,
            'staffId': self.staffId,
            'datetime': self.datetime,
            'status': self.status,
        }

    #清空数据
    def clearData():
        Admin_op_review.query.filter_by().delete()
        # 提交会话 增删改都要提交会话
        db.session.commit()
    

# 管理系统-用户表
class Admin_user(db.Model):
    __tablename__ = "admin_user"
    # 员工ID
    staffId = db.Column(db.String(7),primary_key = True,autoincrement = False)
    # 员工ID
    departId = db.Column(db.String(7),nullable = False)
    # 员工姓名
    staffName = db.Column(db.String(255),nullable = False)
    # 密码
    password = db.Column(db.String(50),nullable = False)
    # 状态
    status = db.Column(db.String(255),nullable = False)
    # 权限值
    authority = db.Column(db.Text(),nullable = True)


    # 模型的资源序列化函数（方法）
    def schema(self):
        return {
            'staffId': self.staffId,
            'departId':self.departId,
            'staffName': self.staffName,
            'password': self.password,
            'status': self.status,
            'authority': self.authority,
        }
    
    #清空数据
    def clearData():
        Admin_user.query.filter_by().delete()
        # 提交会话 增删改都要提交会话
        db.session.commit()
    

# 请假表
class Askforleave(db.Model):
    __tablename__ = "askforleave"
    # ID
    id = db.Column(db.Integer(),primary_key = True,autoincrement = True)
    # 员工ID
    staffId = db.Column(db.String(7),nullable = False)
    # 接受方员工ID
    receiver_staffId = db.Column(db.String(7),nullable = False)
    # 内容
    content = db.Column(db.Text(),nullable = False)
    # 开始时间
    startTime = db.Column(db.DateTime(),nullable = False)
    # 结束时间
    endTime = db.Column(db.DateTime(),nullable = False)
    # 申请时间
    dateTime = db.Column(db.DateTime(),nullable = False)
    # 状态
    status = db.Column(db.String(255),nullable = False)


    # 模型的资源序列化函数（方法）
    def schema(self):
        return {
            'id': self.id,
            'staffId': self.staffId,
            'receiver_staffId': self.receiver_staffId,
            'content': self.content,
            'startTime': self.startTime,
            'endTime': self.endTime,
            'status': self.status,
        }
    
    #清空数据
    def clearData():
        Askforleave.query.filter_by().delete()
        # 提交会话 增删改都要提交会话
        db.session.commit()


# 部门表
class Department(db.Model):
    __tablename__ = "department"
    # 部门ID
    departId = db.Column(db.String(2),primary_key = True,autoincrement = False)
    # 部门名称
    department_Name = db.Column(db.String(255),nullable = False)
    # 管理人名称
    manager_staffId = db.Column(db.String(7),db.ForeignKey("staff.staffId",ondelete='SET NULL'))


    # 模型的资源序列化函数（方法）
    def schema(self):
        return {
            'departId': self.departId,
            'department_Name': self.department_Name,
            'manager_staffId': self.manager_staffId,
        }
    
    #清空数据
    def clearData():
        Department.query.filter_by().delete()
        # 提交会话 增删改都要提交会话
        db.session.commit()
    

# 反馈表
class Feedback(db.Model):
    __tablename__ = "feedback"
    # ID
    id = db.Column(db.Integer(),primary_key = True,autoincrement = True)
    # 内容
    content = db.Column(db.Text(),nullable = False)
    # 发送方员工ID
    send_staffId = db.Column(db.String(7),nullable = False)
    # 反馈时间
    dateTime = db.Column(db.DateTime(),nullable = False)

    # 模型的资源序列化函数（方法）
    def schema(self):
        return {
            'id': self.id,
            'content': self.content,
            'send_staffId': self.send_staffId,
            'dateTime': self.dateTime,
        }
    
    #清空数据
    def clearData():
        Feedback.query.filter_by().delete()
        # 提交会话 增删改都要提交会话
        db.session.commit()


# 通知表
class Notice(db.Model):
    __tablename__ = "notice"
    # ID
    id = db.Column(db.Integer(),primary_key = True,autoincrement = True)
    # 发送方员工ID
    send_staffId = db.Column(db.String(7),nullable = False)
    # 接受方员工ID
    receiver_staffId = db.Column(db.String(7),nullable = False)
    # 内容
    content = db.Column(db.Text(),nullable = False)
    # 发送时间
    datetime = db.Column(db.DateTime(),nullable = False)


    # 模型的资源序列化函数（方法）
    def schema(self):
        return {
            'id': self.id,
            'send_staffId': self.send_staffId,
            'receiver_staffId': self.receiver_staffId,
            'content': self.content,
            'datetime': self.datetime,
        }
    
    #清空数据
    def clearData():
        Notice.query.filter_by().delete()
        # 提交会话 增删改都要提交会话
        db.session.commit()


# 离职员工表
class Resign(db.Model):
    __tablename__ = "resign"
    # 员工ID
    staffId = db.Column(db.String(7),primary_key = True,autoincrement = False)
    # 部门ID
    departId = db.Column(db.String(2),nullable = False)
    # 电话号码
    phoneNum = db.Column(db.BigInteger(),nullable = False)
    # 员工姓名
    staffName = db.Column(db.String(255),nullable = False)
    # 性别
    sex = db.Column(db.String(255),nullable = False)
    # 年龄
    age = db.Column(db.Integer(),nullable = False)
    # 薪资
    salary = db.Column(db.BigInteger(),nullable = False)
    # 职位
    job = db.Column(db.String(255),nullable = False)
    # 入职时间
    entryTime = db.Column(db.Date(),nullable = False)
    # 离职时间
    resignTime = db.Column(db.Date(),nullable = False)

    # 模型的资源序列化函数（方法）
    def schema(self):
        return {
            "staffId":self.staffId,
            'departId': self.departId,
            'phoneNum': self.phoneNum,
            'staffName': self.staffName,
            'sex': self.sex,
            'age':self.age,
            'salary':self.salary,
            'job': self.job,
            'entryTime': self.entryTime,
            'resignTime': self.resignTime,
        }

    #清空数据
    def clearData():
        Resign.query.filter_by().delete()
        # 提交会话 增删改都要提交会话
        db.session.commit()


# 离职申请表
class Resignreview(db.Model):
    __tablename__ = "resignreview"
    # ID
    id = db.Column(db.Integer(),primary_key = True,autoincrement = True)
    # 员工ID
    staffId = db.Column(db.String(7),primary_key = True,autoincrement = False)
    # 员工姓名
    staffName = db.Column(db.String(255),nullable = False)
    # 内容
    content = db.Column(db.Text(),nullable = False)
    # 申请时间
    dateTime = db.Column(db.DateTime(),nullable = False)
    # 状态
    status = db.Column(db.String(255),nullable = False)

    # 模型的资源序列化函数（方法）
    def schema(self):
        return {
            'id': self.id,
            'staffId':self.staffId,
            'staffName': self.staffName,
            'content': self.content,
            'dateTime': self.dateTime,
            'status': self.status,
        }
    
    #清空数据
    def clearData():
        Resignreview.query.filter_by().delete()
        # 提交会话 增删改都要提交会话
        db.session.commit()


# 员工表
class Staff(db.Model):
    __tablename__ = "staff"
    # 员工ID
    staffId = db.Column(db.String(7),primary_key = True,autoincrement = False)
    # 部门ID
    departId = db.Column(db.String(2),nullable = False)
    # 电话号码
    phoneNum = db.Column(db.BigInteger(),nullable = False)
    # 员工姓名
    staffName = db.Column(db.String(255),nullable = False)
    # 性别
    sex = db.Column(db.String(255),nullable = False)
    # 年龄
    age = db.Column(db.Integer(),nullable = False)
    # 薪资
    salary = db.Column(db.BigInteger(),nullable = False)
    # 职位
    job = db.Column(db.String(255),nullable = False)
    # 入职时间
    entryTime = db.Column(db.Date(),nullable = False)

    # 模型的资源序列化函数（方法）
    def schema(self):
        return {
            'staffId': self.staffId,
            'departId': self.departId,
            'phoneNum': self.phoneNum,
            'staffName': self.staffName,
            'sex': self.sex,
            'age':self.age,
            'salary':self.salary,
            'job': self.job,
            'entryTime': self.entryTime
        }

    #清空数据
    def clearData():
        Staff.query.filter_by().delete()
        # 提交会话 增删改都要提交会话
        db.session.commit()

# 考勤表
class Workattendance(db.Model):
    __tablename__ = "workattendance"
    # ID
    id = db.Column(db.Integer(),primary_key = True,autoincrement = True)
    # 状态
    status = db.Column(db.String(255),nullable = False)
    # 员工ID
    staffId = db.Column(db.String(7),nullable = False)
    # 员工姓名
    staffName = db.Column(db.String(255),nullable = False)
    # 日期
    date = db.Column(db.Date(),nullable = False)
    # 开始时间
    startTime = db.Column(db.DateTime(),nullable = False)
    # 结束时间
    endTime = db.Column(db.DateTime(),nullable = False)

    # 模型的资源序列化函数（方法）
    def schema(self):
        return {
            'id': self.id,
            'status': self.status,
            'staffId': self.staffId,
            'staffName': self.staffName,
            'date': self.date,
            'startTime':self.startTime,
            'endTime':self.endTime,
        }
    
    #清空数据
    def clearData():
        Workattendance.query.filter_by().delete()
        # 提交会话 增删改都要提交会话
        db.session.commit()

    

