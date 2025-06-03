using AutoMapper;
using EasyNetQ;
using FoodKing.Model;
using FoodKing.Model.Requests;
using FoodKing.Services.Database;
using FoodKing.Services.Messages;
using Microsoft.Extensions.Logging;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace FoodKing.Services.OrderStateMachine
{
    public class UpdatedOrderState : BaseState
    {
        protected ILogger<UpdatedOrderState> _logger;

        public UpdatedOrderState(ILogger<UpdatedOrderState> logger, IServiceProvider serviceProvider, IMapper mapper, FoodKingContext context) : base(serviceProvider, mapper, context)
        {
            _logger = logger;

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

            list.Add("Accept");

            return list;
        }
    }
}
