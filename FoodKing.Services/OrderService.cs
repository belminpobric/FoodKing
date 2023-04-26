using AutoMapper;
using FoodKing.Model;
using FoodKing.Model.Requests;
using FoodKing.Model.SearchObjects;
using FoodKing.Services.Database;
using FoodKing.Services.OrderStateMachine;

namespace FoodKing.Services
{
    public class OrderService : BaseCRUDService<Model.Order, Database.Order, OrderSearchObject, OrderInsertRequest, OrderUpdateRequest>, IOrderService
    {
        public BaseState _baseState { get; set; }

        public OrderService(BaseState baseState, FoodKingContext context, IMapper mapper) : base(context, mapper)
        {
            _context = context;
            _mapper = mapper;
            _baseState = baseState;
        }
        public override Task<Model.Order> Insert(OrderInsertRequest insert)
        {
            var state = _baseState.CreateState("Initial");

            return state.Insert(insert);
        }
        public async Task<List<string>> AllowedActions(int id)
        {
            var entity = await _context.Orders.FindAsync(id);
            var state = _baseState.CreateState(entity?.StateMachine ?? "Initial");
            return await state.AllowedActions();
        }

        public async Task<Model.Order> Cancel(int id)
        {
            var entity = await _context.Orders.FindAsync(id);
            if (entity == null)
            {
                throw new UserException("Order does not exist");
            }
            var state = _baseState.CreateState(entity.StateMachine);

            return await state.Cancel(id);
        }
    }
}
