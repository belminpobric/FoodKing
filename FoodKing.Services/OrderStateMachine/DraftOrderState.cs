using AutoMapper;
using EasyNetQ;
using FoodKing.Model;
using FoodKing.Model.Requests;
using FoodKing.Services.Database;
using FoodKing.Services.Messages;
using Microsoft.Extensions.Logging;
using RabbitMQ.Client;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
//draft order state should be after initial, from draft we can cancel order, update order and accept order
namespace FoodKing.Services.OrderStateMachine
{
    public class DraftOrderState : BaseState
    {
        protected ILogger<DraftOrderState> _logger;
        public DraftOrderState(ILogger<DraftOrderState> logger, IServiceProvider serviceProvider, IMapper mapper, FoodKingContext context) : base(serviceProvider, mapper, context)
        {
            _logger = logger;
        }
        public override async Task<Model.Order> Update(int id, OrderUpdateRequest update)
        {
            var set = _context.Set<Database.Order>();
            var entity = await set.FindAsync(id);
            if (entity == null)
            {
                throw new Exception("Entity does not exist.");
            }
            _mapper.Map(update, entity);

            await _context.SaveChangesAsync();
            return _mapper.Map<Model.Order>(entity);
        }
        public override async Task<Model.Order> Cancel(int id)
        {
            var entity = await _context.Orders.FindAsync(id);
            if (entity == null)
            {
                throw new UserException($"Order {id} does not exist");
            }
            entity.StateMachine = "Canceled";
            await _context.SaveChangesAsync();

            return _mapper.Map<Model.Order>(entity);
        }
        public override async Task<Model.Order> Accept(int id)
        {
            var entity = await _context.Orders.FindAsync(id);
            if (entity == null)
            {
                throw new UserException($"Order {id} does not exist");
            }
            _logger.LogInformation($"Order {id} is accepted.");

            entity.StateMachine = "Accepted";
            await _context.SaveChangesAsync();

            //var factory = new ConnectionFactory { HostName = "localhost" };
            //using var connection = factory.CreateConnection();
            //using var channel = connection.CreateModel();

            //channel.QueueDeclare(queue: "product_accepted",
            //                     durable: false,
            //                     exclusive: false,
            //                     autoDelete: false,
            //                     arguments: null);

            //const string message = "Hello World!";
            //var body = Encoding.UTF8.GetBytes(message);

            //channel.BasicPublish(exchange: string.Empty,
            //                     routingKey: "product_accepted",
            //                     basicProperties: null,
            //                     body: body);

            var mappedEntity = _mapper.Map<Model.Order>(entity);

            var rmqhost = Environment.GetEnvironmentVariable("RABBITMQ_HOST");
            var rmquser = Environment.GetEnvironmentVariable("RABBITMQ_USER");
            var rmqpass = Environment.GetEnvironmentVariable("RABBITMQ_PASSWORD");
            var rmqport = Environment.GetEnvironmentVariable("RABBITMQ_PORT");

            using var bus = RabbitHutch.CreateBus($"host={rmqhost};username={rmquser};password={rmqpass};port={rmqport}");

            OrderAccepted message = new OrderAccepted { Order = mappedEntity };
            bus.PubSub.Publish(message);

            return mappedEntity;
        }

        public override async Task<List<string>> AllowedActions()
        {
            var list = await base.AllowedActions();

            list.Add("Cancel");
            list.Add("Accept");
            list.Add("Update");

            return list;
        }
    }
}
