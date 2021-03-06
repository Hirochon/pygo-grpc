package main

import (
	"context"
	"log"
	"net"

	pb "hello-server/proto"

	"google.golang.org/grpc"
)

const (
	port = ":50051"
)

type server struct {
	pb.UnimplementedHelloServer
}

func (s *server) PushMsg(ctx context.Context, p *pb.MsgStruct) (*pb.MsgStruct, error) {
	log.Printf("Received: %v", p.Message)
	return &pb.MsgStruct{Message: "Hello " + p.Message}, nil
}

func main() {
	lis, err := net.Listen("tcp", port)
	if err != nil {
		log.Fatalf("failed to listen: %v", err)
	}
	s := grpc.NewServer()
	pb.RegisterHelloServer(s, &server{})
	log.Printf("server listening at %v", lis.Addr())
	if err := s.Serve(lis); err != nil {
		log.Fatalf("failed to serve: %v", err)
	}
}
