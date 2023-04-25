using FoodKing.Model;
using FoodKing.Model.Requests;
using FoodKing.Model.SearchObjects;
using FoodKing.Services;
using Microsoft.AspNetCore.Mvc;

namespace app.Controllers
{
    [ApiController]
    [Route("[controller]")]
    public class OrderController : BaseCRUDController<Order, OrderSearchObject, OrderInsertRequest, OrderUpdateRequest>
    {
        private readonly IOrderService _service;
        private readonly ILogger<OrderController> _logger;

        public OrderController(ILogger<OrderController> logger, IOrderService service) : base(logger, service)
        {
            _logger = logger;
            _service = service;
        }
    }
}
