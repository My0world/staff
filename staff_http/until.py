import datetime
import random
def getDate():
    current_date = datetime.datetime.now().strftime("%Y-%m-%d %H:%M:%S")
    print("current_date")
    print(current_date)
    return current_date

def getDate2():
    current_date = datetime.datetime.now().strftime("%Y-%m-%d")
    print("current_date")
    print(current_date)
    return current_date

def delay30_date():
    delay_date = (datetime.datetime.now() + datetime.timedelta(seconds=10)).strftime("%Y-%m-%d %H:%M:%S")
    print("delay_date")
    print(delay_date)
    return delay_date
 
def random_time(str):
    if(str == "上"):
        hour = random.randint(8,9)
        # hour = 8
        minute = random.randint(0,30)
        second = random.randint(0, 59)
    else:
        # hour = random.randint(18,19)
        hour = 18
        minute = random.randint(0, 10)
        second = random.randint(0, 59)
    return datetime.time(hour, minute, second).strftime('%H:%M:%S')


def setStatus(start,end):
    chidao = datetime.time(*map(int, "09:00:00".split(':')))
    kuanggong = datetime.time(*map(int, "11:00:00".split(':')))
    zaotui = datetime.time(*map(int, "18:00:00".split(':')))
    startTime = datetime.time(*map(int, start.split(':')))
    endTime = datetime.time(*map(int, end.split(':')))
    if(startTime <= chidao and endTime >= zaotui):
        return "正常"
    if(startTime > chidao and startTime < kuanggong):
        return "迟到"
    if(startTime >= kuanggong):
        return "旷工"
    if(endTime < zaotui):
        return "早退"