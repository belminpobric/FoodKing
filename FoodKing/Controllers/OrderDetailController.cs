using FoodKing.Model;
using FoodKing.Model.Requests;
using FoodKing.Model.SearchObjects;
using FoodKing.Services;
using Microsoft.AspNetCore.Mvc;

namespace FoodKing.Controllers
{
    [ApiController]
    [Route("[controller]")]
    public class OrderDetailController : BaseCRUDController<OrderDetail, OrderDetailSearchObject, OrderDetailInsertRequest, OrderDetailUpdateRequest>
    {
        private readonly IOrderDetailService _service;
        private readonly ILogger<OrderDetailController> _logger;

        public OrderDetailController(ILogger<OrderDetailController> logger, IOrderDetailService service) : base(logger, service)
        {
            _logger = logger;
            _service = service;
        }
    }
}
