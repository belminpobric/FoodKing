using AutoMapper;
using FoodKing.Model.Requests;
using FoodKing.Model.SearchObjects;
using FoodKing.Services.Database;
using Microsoft.EntityFrameworkCore;

namespace FoodKing.Services
{
    public class ProductService: BaseCRUDService<Model.Product, Database.Product, ProductSearchObject, ProductInsertRequest, ProductUpdateRequest>, IProductService
    {
        public ProductService(FoodKingContext context, IMapper mapper) : base(context, mapper)
        {
            _context = context;
            _mapper = mapper;
        }
        public override IQueryable<Database.Product> AddFilter(IQueryable<Database.Product> query, ProductSearchObject? search = null)
        {
            if (!string.IsNullOrWhiteSpace(search?.Title))
            {
                query = query.Where(x => x.Title.StartsWith(search.Title));
            }
            if (search.Menu != null)
            {
                query = query.Include("MenuHasProducts.Menu").Where(x => x.MenuHasProducts.Any(mhp => mhp.Menu.Id == search.Menu));
            }
            if (search.DailyMenu != null)
            {
                query = query.Include("DailyMenuHasProducts.DailyMenu").Where(x => x.DailyMenuHasProducts.Any(dmhp => dmhp.DailyMenu.Id == search.DailyMenu));
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
        public override async Task BeforeInsert(Database.Product entity, ProductInsertRequest insert)
        {
            var menu = await _context.Menus.FirstOrDefaultAsync(x => x.Id == insert.MenuId);
            if (menu != null)
            {
                var menuHasProduct = new Database.MenuHasProduct
                {
                    Menu = menu,
                    Product = entity
                };
                _context.MenuHasProducts.Add(menuHasProduct);
                await _context.SaveChangesAsync();
            }
            var dailyMenu = await _context.DailyMenus.FirstOrDefaultAsync(x => x.Id == insert.DailyMenuId);
            if (dailyMenu != null)
            {
                var dailyMenuHasProduct = new Database.DailyMenuHasProduct
                {
                    DailyMenu = dailyMenu,
                    Product = entity
                };
                _context.DailyMenuHasProducts.Add(dailyMenuHasProduct);
                await _context.SaveChangesAsync();
            }
            await base.BeforeInsert(entity, insert);
        }
        public async Task Delete(int id)
        {
            var entity = await _context.Products.FindAsync(id);
            if (entity == null)
            {
                throw new Exception("Entity does not exist.");
            }
            entity.SoftDelete = true;
            await _context.SaveChangesAsync();
        }
    }
}
