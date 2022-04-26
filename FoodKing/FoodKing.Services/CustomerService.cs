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
        public CustomerService(FoodKingContext context)
        {
            _context = context;
        }
        public IEnumerable<Customer> GetCustomers()
        {
            throw new NotImplementedException();
        }
    }
}
