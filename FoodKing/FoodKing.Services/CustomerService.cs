using AutoMapper;
using FoodKing.Services.Database;

namespace FoodKing.Services
{
    public class CustomerService : BaseService<Model.Customer, Database.Customer>, ICustomerService
    {
        public CustomerService(FoodKingContext context, IMapper mapper): base(context,mapper)
        {
        }
        //public IEnumerable<Model.Customer> Get()
        //{
        //    List<Model.Customer> list = new List<Model.Customer>();

        //    var result = _context.Customers.ToList();

        //    return Mapper.Map<List<Model.Customer>>(result);
        //}

        //public Model.Customer GetById(int id)
        //{
        //    var result = _context.Customers.Find(id);

        //    return Mapper.Map<Model.Customer>(result);
        //}
    }
}
