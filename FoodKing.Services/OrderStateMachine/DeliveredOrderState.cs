using AutoMapper;
using FoodKing.Services.Database;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace FoodKing.Services.OrderStateMachine
{
    public class DeliveredOrderState : BaseState
    {
        public DeliveredOrderState(IServiceProvider serviceProvider, IMapper mapper, FoodKingContext context) : base(serviceProvider, mapper, context)
        {

        }
        public override async Task<List<string>> AllowedActions()
        {
            var list = await base.AllowedActions();

            list.Add("None");

            return list;
        }
    }
}
