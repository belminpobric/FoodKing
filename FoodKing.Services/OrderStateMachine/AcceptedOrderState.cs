using AutoMapper;
using FoodKing.Model;
using FoodKing.Services.Database;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace FoodKing.Services.OrderStateMachine
{
    public class AcceptedOrderState : BaseState
    {
        public AcceptedOrderState(IServiceProvider serviceProvider, IMapper mapper, FoodKingContext context) : base(serviceProvider, mapper, context)
        {

        }
        public override async Task<Model.Order> InProgress(int id)
        {
            var entity = await _context.Orders.FindAsync(id);
            if (entity == null)
            {
                throw new UserException($"Order {id} does not exist");
            }
            entity.StateMachine = "InProgress";
            await _context.SaveChangesAsync();

            return _mapper.Map<Model.Order>(entity);
        }
        public override async Task<List<string>> AllowedActions()
        {
            var list = await base.AllowedActions();

            list.Add("InProgress");

            return list;
        }
    }
}
