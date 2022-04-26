using FoodKing.Services;
using FoodKing.Services.Database;
using Microsoft.AspNetCore.Mvc;

namespace FoodKing.Controllers
{
    [ApiController]
    [Route("[controller]")]
    public class CustomerController : Controller
    {
        public ICustomerService customerService { get; set; }
        public CustomerController(ICustomerService customerservice)
        {
            customerService = customerservice;
        }
        [HttpGet]
        public IEnumerable<Customer> Get()
        {
            return new List<Customer>();
        }
    }
}
