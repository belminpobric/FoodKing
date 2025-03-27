using AutoMapper;
using EasyNetQ;
using FoodKing.Model;
using FoodKing.Model.Requests;
using FoodKing.Services.Database;
using Microsoft.Extensions.Logging;
using RabbitMQ.Client;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace FoodKing.Services.OrderStateMachine
{
    public class InitialOrderState : BaseState
    {
        protected ILogger<InitialOrderState> _logger;
        public InitialOrderState(ILogger<InitialOrderState> logger, IServiceProvider serviceProvider, IMapper mapper, FoodKingContext context) : base(serviceProvider, mapper, context)
        {
            _logger = logger;
        }
        public override async Task<Model.Order> Insert(OrderInsertRequest request)
        {
            var set = _context.Set<Database.Order>();

            var entity = _mapper.Map<Database.Order>(request);

            entity.StateMachine = "Draft";
            set.Add(entity);

            await _context.SaveChangesAsync();

            return _mapper.Map<Model.Order>(entity);
        }
       
        public override async Task<List<string>> AllowedActions()
        {
            var list = await base.AllowedActions();

            list.Add("Insert");

            return list;
        }
    }
}
