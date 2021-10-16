from __future__ import print_function
import logging

import grpc

import hello_pb2
import hello_pb2_grpc

def run():
    msg = input()
    with grpc.insecure_channel('localhost:50051') as channel:
        stub = hello_pb2_grpc.HelloStub(channel)
        stub.PushMsg(hello_pb2.MsgStruct(message=msg))

if __name__ == '__main__':
    logging.basicConfig()
    while True:
        run()