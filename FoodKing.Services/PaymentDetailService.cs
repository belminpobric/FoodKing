using AutoMapper;
using FoodKing.Model.Requests;
using FoodKing.Model.SearchObjects;
using FoodKing.Services.Database;

namespace FoodKing.Services
{
    public class PaymentDetailService: BaseCRUDService<Model.PaymentDetail, Database.PaymentDetail, PaymentDetailSearchObject, PaymentDetailInsertRequest, PaymentDetailUpdateRequest>, IPaymentDetailService
    {
        public PaymentDetailService(FoodKingContext context, IMapper mapper) : base(context, mapper)
        {
            _context = context;
            _mapper = mapper;
        }
        public override IQueryable<Database.PaymentDetail> AddFilter(IQueryable<Database.PaymentDetail> query, PaymentDetailSearchObject? search = null)
        {
            if (search?.OrderNumber != null)
            {
                query = query.Where(x => x.OrderNumber.Equals(search.OrderNumber));
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
            var entity = await _context.PaymentDetails.FindAsync(id);
            if (entity == null)
            {
                throw new Exception("Entity does not exist.");
            }
            entity.SoftDelete = true;
            await _context.SaveChangesAsync();
        }
    }
}
