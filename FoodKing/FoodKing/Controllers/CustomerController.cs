using FoodKing.Model;
using FoodKing.Services;
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
        public IEnumerable<Model.Customer> Get()
        {
            return customerService.Get();
        }
    }
}
