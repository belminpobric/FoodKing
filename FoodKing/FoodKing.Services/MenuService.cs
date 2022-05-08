using AutoMapper;
using FoodKing.Services.Database;

namespace FoodKing.Services
{
    public class MenuService : BaseService<Database.Menu, Database.Menu> , IMenuService
    {
        public MenuService(FoodKingContext context, IMapper mapper) : base(context, mapper)
        {
            _context = context;
        }
    }
}