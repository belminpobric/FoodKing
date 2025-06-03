using FoodKing.Model;
using FoodKing.Model.Requests;
using FoodKing.Model.SearchObjects;
using FoodKing.Services;
using Microsoft.AspNetCore.Mvc;

namespace FoodKing.Controllers
{
    [ApiController]
    [Route("[controller]")]
    public class PaymentDetailController : BaseCRUDController<PaymentDetail, PaymentDetailSearchObject, PaymentDetailInsertRequest, PaymentDetailUpdateRequest>
    {
        private readonly IPaymentDetailService _service;
        private readonly ILogger<PaymentDetailController> _logger;

        public PaymentDetailController(ILogger<PaymentDetailController> logger, IPaymentDetailService service) : base(logger, service)
        {
            _logger = logger;
            _service = service;
        }
    }
}
