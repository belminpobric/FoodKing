using AutoMapper;
using FoodKing.Services.Database;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace FoodKing.Services
{
    public class FoodService : BaseService<Database.FoodItem, Database.FoodItem> , IFoodService
    {
        public FoodService(FoodKingContext context, IMapper mapper) : base(context, mapper)
        {
            _context = context;
        }
    }
}
