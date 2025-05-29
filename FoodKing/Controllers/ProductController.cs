using FoodKing.Model;
using FoodKing.Model.Requests;
using FoodKing.Model.SearchObjects;
using FoodKing.Services;
using Microsoft.AspNetCore.Mvc;

namespace FoodKing.Controllers
{
    [ApiController]
    [Route("[controller]")]
    public class ProductController : BaseCRUDController<Product, ProductSearchObject, ProductInsertRequest, ProductUpdateRequest>
    {
        private readonly IProductService _service;
        private readonly ILogger<ProductController> _logger;

        public ProductController(ILogger<ProductController> logger, IProductService service) : base(logger, service)
        {
            _logger = logger;
            _service = service;
        }
    }
}
