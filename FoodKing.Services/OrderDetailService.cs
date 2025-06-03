using AutoMapper;
using FoodKing.Model.Requests;
using FoodKing.Model.SearchObjects;
using FoodKing.Services.Database;

namespace FoodKing.Services
{
    public class OrderDetailService: BaseCRUDService<Model.OrderDetail, Database.OrderDetail, OrderDetailSearchObject, OrderDetailInsertRequest, OrderDetailUpdateRequest>, IOrderDetailService
    {
        public OrderDetailService(FoodKingContext context, IMapper mapper) : base(context, mapper)
        {
            _context = context;
            _mapper = mapper;
        }
        public override IQueryable<Database.OrderDetail> AddFilter(IQueryable<Database.OrderDetail> query, OrderDetailSearchObject? search = null)
        {
            if (!string.IsNullOrWhiteSpace(search?.Details))
            {
                query = query.Where(x => x.Details.StartsWith(search.Details));
            }
            if (search?.SortByCreatedAtDesc == true)
            {
                query = query.OrderByDescending(x => x.CreatedAt);
            }
            else
            {
                query = query.OrderBy(x => x.CreatedAt);
            }
            query = query.Where(x => x.SoftDelete == false);

            return query;
        }
        public async Task Delete(int id)
        {
            var entity = await _context.OrderDetails.FindAsync(id);
            if (entity == null)
            {
                throw new Exception("Entity does not exist.");
            }
            entity.SoftDelete = true;
            await _context.SaveChangesAsync();
        }
    }
}
