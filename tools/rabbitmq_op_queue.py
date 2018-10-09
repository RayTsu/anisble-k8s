#!/usr/bin/env python
# -*- coding:utf-8 -*-
import pika
import sys

try:
    server=sys.argv[1]
    credentials=pika.PlainCredentials('risk','risk134')
    connection=pika.BlockingConnection(pika.ConnectionParameters(server,5672,'/',credentials))
    channel=connection.channel()
except:
    print 'Usage: 请依次输入三个参数：'+'server,queues_file/queue_name,add/delete'
    sys.exit()


def main():
# 调用函数
    if len(sys.argv)!=4:
        print '请输入三个参数！'

    if '.txt' in sys.argv[2] and 'add'==sys.argv[3]:
        queues_add()
        connection.close()
    elif '.txt' in sys.argv[2] and 'delete'==sys.argv[3]:
        queues_delete()
        connection.close()
    elif '.txt' not in sys.argv[2] and 'add'==sys.argv[3]:
        queue_add()
        connection.close()
    elif '.txt' not in sys.argv[2] and 'delete'==sys.argv[3]:
        queue_delete()
        connection.close()
    else:
        print '输入有误！'
    
def queues_add():
    with open(sys.argv[2], 'r') as f:
        data=f.read()
        queues=data.split()
        for i in queues:
            print i
            channel.queue_declare(queue=i,durable=True,auto_delete=False)
            print '队列添加成功！'

def queues_delete():
    with open(sys.argv[2], 'r') as f:
        data=f.read()
        queues=data.split()
        for i in queues:
            print i
            channel.queue_delete(queue=i)
            print '队列删除成功！'

def queue_add():
    channel.queue_declare(queue=sys.argv[2],durable=True,auto_delete=False)
    print '队列添加成功！'

def queue_delete():
    channel.queue_delete(queue=sys.argv[2])
    print '队列删除成功！'

if __name__=='__main__':
    main()
