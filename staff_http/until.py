import datetime
def getDate():
    current_date = datetime.datetime.now().strftime("%Y-%m-%d %H:%M:%S")
    print("current_date")
    print(current_date)
    return current_date

def delay30_date():
    delay_date = (datetime.datetime.now() + datetime.timedelta(seconds=10)).strftime("%Y-%m-%d %H:%M:%S")
    print("delay_date")
    print(delay_date)
    return delay_date