using FoodKing.Model;
using FoodKing.Model.Requests;
using FoodKing.Model.SearchObjects;

namespace FoodKing.Services
{
    public interface IOrderService : ICRUDService<Order, OrderSearchObject, OrderInsertRequest, OrderUpdateRequest>
    {
    }
}
