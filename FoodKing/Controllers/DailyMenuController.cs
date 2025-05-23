using FoodKing.Model;
using FoodKing.Model.Requests;
using FoodKing.Model.SearchObjects;
using FoodKing.Services;
using Microsoft.AspNetCore.Mvc;

namespace FoodKing.Controllers
{
    [ApiController]
    [Route("[controller]")]
    public class DailyMenuController : BaseCRUDController<DailyMenu, DailyMenuSearchObject, DailyMenuInsertRequest, DailyMenuUpdateRequest>
    {
        private readonly IDailyMenuService _service;
        private readonly ILogger<DailyMenuController> _logger;

        public DailyMenuController(ILogger<DailyMenuController> logger, IDailyMenuService service) : base(logger, service)
        {
            _logger = logger;
            _service = service;
        }
    }
}
