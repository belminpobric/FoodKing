using AutoMapper;
using FoodKing.Model.Requests;
using FoodKing.Model.SearchObjects;
using FoodKing.Services.Database;

namespace FoodKing.Services
{
    public class MenuService: BaseCRUDService<Model.Menu, Database.Menu, MenuSearchObject, MenuInsertRequest, MenuUpdateRequest>, IMenuService
    {
        public MenuService(FoodKingContext context, IMapper mapper) : base(context, mapper)
        {
            _context = context;
            _mapper = mapper;
        }
        public override IQueryable<Database.Menu> AddFilter(IQueryable<Database.Menu> query, MenuSearchObject? search = null)
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
            query = query.Where(x => x.SoftDelete == false || x.SoftDelete == null);

            return query;
        }
        public async Task Delete(int id)
        {
            var entity = await _context.Menus.FindAsync(id);
            if (entity == null)
            {
                throw new Exception("Entity does not exist.");
            }
            entity.SoftDelete = true;
            await _context.SaveChangesAsync();
        }
    }
}
