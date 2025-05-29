using AutoMapper;
using FoodKing.Model.Requests;
using FoodKing.Model.SearchObjects;
using FoodKing.Services.Database;
using Microsoft.EntityFrameworkCore;

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
            var filteredQuery = base.AddFilter(query, search);

            if (!string.IsNullOrWhiteSpace(search?.FirstName))
            {
                filteredQuery = query.Where(x => x.FirstName.StartsWith(search.FirstName));
            }

            if (!string.IsNullOrWhiteSpace(search?.LastName))
            {
                filteredQuery = query.Where(x => x.LastName.StartsWith(search.LastName));
            }

            if (!string.IsNullOrWhiteSpace(search?.NameGTE))
            {
                var nameGte = search.NameGTE!;
                filteredQuery = filteredQuery.Where(x =>
                    EF.Functions.Like(x.FirstName, nameGte + "%") ||
                    EF.Functions.Like(x.LastName, nameGte + "%")
                );
            }

            if (!string.IsNullOrWhiteSpace(search?.Email))
            {
                filteredQuery = query.Where(x => x.Email.StartsWith(search.Email));
            }
            if (search?.SortByCreatedAtDesc == true)
            {
                filteredQuery = query.OrderByDescending(x => x.CreatedAt);
            } 
            else
            {
                filteredQuery = query.OrderBy(x => x.CreatedAt);
            }

            return filteredQuery;
        }
    }
}
