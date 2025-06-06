﻿using System.Text;
using EasyNetQ;
using FoodKing.Model;
using RabbitMQ.Client;
using RabbitMQ.Client.Events;

//var factory = new ConnectionFactory { HostName = "localhost" };
//using var connection = factory.CreateConnection();
//using var channel = connection.CreateModel();

//channel.QueueDeclare(queue: "product_accepted",
//                     durable: false,
//                     exclusive: false,
//                     autoDelete: false,
//                     arguments: null);

//Console.WriteLine(" [*] Waiting for messages.");

//var consumer = new EventingBasicConsumer(channel);
//consumer.Received += (model, ea) =>
//{
//    var body = ea.Body.ToArray();
//    var message = Encoding.UTF8.GetString(body);
//    Console.WriteLine($" [x] Received {message}");
//};
//channel.BasicConsume(queue: "product_accepted",
//                     autoAck: true,
//                     consumer: consumer);

Console.WriteLine("Provide subscription id :");
var subscriptionId = Console.ReadLine();

using (var bus = RabbitHutch.CreateBus("host=rabbitmq3"))
{
    bus.PubSub.Subscribe<Order>(subscriptionId, HandleTextMessage);
    Console.WriteLine("Listening for messages. Hit <return> to quit.");
    Console.ReadLine();
}
static void HandleTextMessage(Order entity)
{
    Console.WriteLine($"Received: {entity.Id}, {entity.Price}");
    //moze se poslati notifikacija aplikaciji da je primljena narudzba ili mail korisniku ili spasiti u bazu ali nesto da se uradi sa ovom info.
}