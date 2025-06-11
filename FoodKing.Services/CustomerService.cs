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

            filteredQuery = filteredQuery.Where(x => x.SoftDelete == false || x.SoftDelete == null);

            if (!string.IsNullOrWhiteSpace(search?.FirstName))
            {
                filteredQuery = filteredQuery.Where(x => x.FirstName.StartsWith(search.FirstName));
            }

            if (!string.IsNullOrWhiteSpace(search?.LastName))
            {
                filteredQuery = filteredQuery.Where(x => x.LastName.StartsWith(search.LastName));
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
                filteredQuery = filteredQuery.Where(x => x.Email.StartsWith(search.Email));
            }

            if (search?.SortByCreatedAtDesc == true)
            {
                filteredQuery = filteredQuery.OrderByDescending(x => x.CreatedAt);
            }
            else
            {
                filteredQuery = filteredQuery.OrderBy(x => x.CreatedAt);
            }

            return filteredQuery;
        }

        public async Task Delete(int id)
        {
            var entity = await _context.Customers.FindAsync(id);
            if (entity == null)
            {
                throw new Exception("Entity does not exist.");
            }
            entity.SoftDelete = true;
            await _context.SaveChangesAsync();
        }
    }
}
