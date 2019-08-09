import csv, sqlite3
import psycopg2
import random
import time

def strTimeProp(start, end, format, prop):
    """Get a time at a proportion of a range of two formatted times.

    start and end should be strings specifying times formated in the
    given format (strftime-style), giving an interval [start, end].
    prop specifies how a proportion of the interval to be taken after
    start.  The returned time will be in the specified format.
    """

    stime = time.mktime(time.strptime(start, format))
    etime = time.mktime(time.strptime(end, format))

    ptime = stime + prop * (etime - stime)

    return time.strftime(format, time.localtime(ptime))


def randomDate(start, end, prop):
    return strTimeProp(start, end, '%Y-%m-%d', prop)

conn = psycopg2.connect("postgres://cpymjnxryasdef:7d2e21ecf6ff0096eb5da43fa82cfdcaa834b7d6324238d8da4f2dc2cf052c5a@ec2-50-16-197-244.compute-1.amazonaws.com:5432/d7a58cmju41hth")
cur = conn.cursor()

with open('db_column.csv','r',encoding="utf-8-sig") as fin: # `with` statement available in 2.5+
    # csv.DictReader uses first line in file for column headings by default
    dr = csv.DictReader(fin) # comma is default delimiter
    start_date = randomDate("2019-1-1", "2019-6-30", random.random())
    end_date = randomDate("2019-7-1", "2020-12-31", random.random())
    pub_date = randomDate("2019-1-1", "2019-6-30", random.random())
    to_db = [(i['title'], i['body'], i['age'],i['educated'],i['region'],i["url"],pub_date,start_date,end_date,0,"admin") for i in dr]

cur.executemany("insert into policy_policylist(title,body,age,educated,region,url,pub_date,start_date,end_date,hits,writer) values (%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s)",to_db)

conn.commit()
conn.close()