using AutoMapper;
using FoodKing.Model;
using FoodKing.Services.Database;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace FoodKing.Services
{
    public class CustomerService : ICustomerService
    {
        public FoodKingContext _context { get; set; }
        public IMapper Mapper { get; set; }
        public CustomerService(FoodKingContext context, IMapper mapper)
        {
            _context = context;
            Mapper = mapper;
        }
        public IEnumerable<Model.Customer> GetCustomers()
        {
            List<Model.Customer> list = new List<Model.Customer>();

            var result = _context.Customers.ToList();

            return Mapper.Map<List<Model.Customer>>(result);
        }  
    }
}
