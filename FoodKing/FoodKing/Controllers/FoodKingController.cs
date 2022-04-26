using FoodKing.Services;
using Microsoft.AspNetCore.Mvc;

namespace FoodKing.Controllers
{
    public class FoodKingController : Controller
    {
        public IFoodService _foodService { get; set; }
        public FoodKingController(IFoodService foodServce)
        {
            _foodService = foodServce;
        }
        public IActionResult Index()
        {
            return View();
        }
    }
}
