using FoodKing.Model;
using FoodKing.Services;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using static Microsoft.EntityFrameworkCore.DbLoggerCategory;

namespace FoodKing.Controllers
{
    public class BaseCRUDController<T, TSearch, TInsert, TUpdate> : BaseController<T, TSearch> where TSearch : class where T : class
    {
        private readonly ICRUDService<T, TSearch, TInsert, TUpdate> _service;
        private readonly ILogger<BaseCRUDController<T, TSearch, TInsert, TUpdate>> _logger;

        public BaseCRUDController(ILogger<BaseCRUDController<T, TSearch, TInsert, TUpdate>> logger, ICRUDService<T, TSearch, TInsert, TUpdate> service) : base(logger, service)
        {
            _logger = logger;
            _service = service;
        }

        [HttpPost()]
        [Authorize(Roles = "Administrator")]
        public virtual async Task<T> Insert([FromBody] TInsert insert)
        {
            return await _service.Insert(insert);
        }

        [HttpPut("{id}")]
        public virtual async Task<T> Update(int id, [FromBody] TUpdate update)
        {
            return await _service.Update(id, update);
        }
        [HttpDelete("{id}")]
        public async Task Delete(int id)
        {
            await _service.Delete(id);
        }
    }
}
