using FoodKing.Model;
using FoodKing.Model.Requests;
using FoodKing.Model.SearchObjects;

namespace FoodKing.Services
{
    public interface IOrderService : ICRUDService<Order, OrderSearchObject, OrderInsertRequest, OrderUpdateRequest>
    {
        Task<List<string>> AllowedActions(int id);
        Task<Order> Cancel(int id);
    }
}
