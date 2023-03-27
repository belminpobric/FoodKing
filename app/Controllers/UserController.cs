using FoodKing.Model;
using FoodKing.Model.Requests;
using FoodKing.Services;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace app.Controllers
{
    [ApiController]
    [Route("[controller]")]
    public class UserController : Controller
    {
        private readonly IUserService _service;
        private readonly ILogger<UserController> _logger;

        public UserController(ILogger<UserController> logger, IUserService service)
        {
            _logger = logger;
            _service = service;
        }

        [HttpGet()]
        public async Task<IEnumerable<User>> Get()
        {
            return await _service.Get();
        }

        [HttpGet("{id}")]
        public async Task<User> GetById(int id)
        {
            return await _service.GetByID(id);
        }

        [HttpPost]
        public User Insert(UserInsertRequest request)
        {
            return _service.Insert(request);
        }

        [HttpPut("{id}")]
        public async Task<User> Update(int id, UserUpdateRequest request)
        {
            return await _service.Update(id, request);
        }
        //[HttpPut("{id}")]
        //public Model.Korisnici Update(int id, KorisniciUpdateRequest request)
        //{
        //    return _service.Update(id, request);
        //}
    }
}
