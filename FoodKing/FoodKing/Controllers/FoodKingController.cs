using FoodKing.Services;
using Microsoft.AspNetCore.Mvc;

namespace FoodKing.Controllers
{
    [ApiController]
    [Route("[controller]")]
    public class FoodKingController : Controller
    {
        public IFoodService _foodService { get; set; }
        public FoodKingController(IFoodService foodServce)
        {
            _foodService = foodServce;
        }
    }
}
