using AutoMapper;
using FoodKing.Services.Database;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace FoodKing.Services.OrderStateMachine
{
    public class FinishedOrderState : BaseState
    {
        public FinishedOrderState(IServiceProvider serviceProvider, IMapper mapper, FoodKingContext context) : base(serviceProvider, mapper, context)
        {

        }
    }
}
