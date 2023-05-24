using FoodKing.Model;
using FoodKing.Model.Requests;
using FoodKing.Model.SearchObjects;
using FoodKing.Services;
using Microsoft.AspNetCore.Mvc;

namespace FoodKing.Controllers
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

        [HttpGet("{id}/allowedActions")]
        public virtual async Task<List<string>> AllowedActions(int id)
        {
            return await _service.AllowedActions(id);
        }

        [HttpPut("{id}/accept")]
        public virtual async Task<Order> Accept(int id)
        {
            return await _service.Accept(id);
        }

        [HttpPut("{id}/inProgress")]
        public virtual async Task<Order> inProgress(int id)
        {
            return await _service.InProgress(id);
        }

        [HttpPut("{id}/finish")]
        public virtual async Task<Order> Finish(int id)
        {
            return await _service.Finish(id);
        }

        [HttpPut("{id}/deliver")]
        public virtual async Task<Order> Deliver(int id)
        {
            return await _service.Deliver(id);
        }

        [HttpPut("{id}/cancel")]
        public virtual async Task<Order> Cancel(int id)
        {
            return await _service.Cancel(id);
        }
    }
}
