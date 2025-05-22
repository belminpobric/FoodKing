using FoodKing.Model;
using FoodKing.Model.Requests;
using FoodKing.Model.SearchObjects;
using FoodKing.Services;
using Microsoft.AspNetCore.Mvc;

namespace FoodKing.Controllers
{
    [ApiController]
    [Route("[controller]")]
    public class MenuController : BaseCRUDController<Menu, MenuSearchObject, MenuInsertRequest, MenuUpdateRequest>
    {
        private readonly IMenuService _service;
        private readonly ILogger<MenuController> _logger;

        public MenuController(ILogger<MenuController> logger, IMenuService service) : base(logger, service)
        {
            _logger = logger;
            _service = service;
        }
    }
}
