using AutoMapper;
using FoodKing.Services.Database;

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
