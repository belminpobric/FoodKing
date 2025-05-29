using AutoMapper;
using FoodKing.Model.Requests;
using FoodKing.Model.SearchObjects;
using FoodKing.Services.Database;

namespace FoodKing.Services
{
    public class DailyMenuService: BaseCRUDService<Model.DailyMenu, Database.DailyMenu, DailyMenuSearchObject, DailyMenuInsertRequest, DailyMenuUpdateRequest>, IDailyMenuService
    {
        public DailyMenuService(FoodKingContext context, IMapper mapper) : base(context, mapper)
        {
            _context = context;
            _mapper = mapper;
        }
        public override IQueryable<Database.DailyMenu> AddFilter(IQueryable<Database.DailyMenu> query, DailyMenuSearchObject? search = null)
        {
            if (!string.IsNullOrWhiteSpace(search?.Title))
            {
                query = query.Where(x => x.Title.StartsWith(search.Title));
            }
            if (search?.SortByCreatedAtDesc == true)
            {
                query = query.OrderByDescending(x => x.CreatedAt);
            }
            else
            {
                query = query.OrderBy(x => x.CreatedAt);
            }
            return query;
        }
    }
}
