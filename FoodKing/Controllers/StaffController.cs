using FoodKing.Model;
using FoodKing.Model.Requests;
using FoodKing.Model.SearchObjects;
using FoodKing.Services;
using Microsoft.AspNetCore.Mvc;

namespace FoodKing.Controllers
{
    [ApiController]
    [Route("[controller]")]
    public class StaffController : BaseCRUDController<Staff, StaffSearchObject, StaffInsertRequest, StaffUpdateRequest>
    {
        private readonly IStaffService _service;
        private readonly ILogger<StaffController> _logger;

        public StaffController(ILogger<StaffController> logger, IStaffService service) : base(logger, service)
        {
            _logger = logger;
            _service = service;
        }
    }
}
