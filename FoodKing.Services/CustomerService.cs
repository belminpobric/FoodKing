using AutoMapper;
using FoodKing.Model.Requests;
using FoodKing.Model.SearchObjects;
using FoodKing.Services.Database;

namespace FoodKing.Services
{
    public class CustomerService: BaseCRUDService<Model.Customer, Database.Customer, CustomerSearchObject, CustomerInsertRequest, CustomerUpdateRequest>, ICustomerService
    {
        public CustomerService(FoodKingContext context, IMapper mapper) : base(context, mapper)
        {
            _context = context;
            _mapper = mapper;
        }
        public override IQueryable<Database.Customer> AddFilter(IQueryable<Database.Customer> query, CustomerSearchObject? search = null)
        {
            if (!string.IsNullOrWhiteSpace(search?.FirstName))
            {
                query = query.Where(x => x.FirstName.StartsWith(search.FirstName));
            }

            if (!string.IsNullOrWhiteSpace(search?.LastName))
            {
                query = query.Where(x => x.LastName.StartsWith(search.LastName));
            }

            if (!string.IsNullOrWhiteSpace(search?.Email))
            {
                query = query.Where(x => x.Email.StartsWith(search.Email));
            }

            return query;
        }
    }
}
