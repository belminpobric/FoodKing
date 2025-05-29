using AutoMapper;
using FoodKing.Model;
using FoodKing.Model.Requests;
using FoodKing.Model.SearchObjects;
using FoodKing.Services.Database;
using FoodKing.Services.OrderStateMachine;
using Microsoft.EntityFrameworkCore;

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

        public override IQueryable<Database.Order> AddFilter(IQueryable<Database.Order> query, OrderSearchObject? search = null)
        {
            var filteredQuery = base.AddFilter(query,search);
            if (search.IsAccepted.HasValue)
            {
                filteredQuery = query.Where(x => x.IsAccepted == search.IsAccepted);
            }

            if (!string.IsNullOrWhiteSpace(search?.IdGTE) && search.IdGTE.All(char.IsDigit))
            {
                filteredQuery = filteredQuery.Where(x => x.Id.ToString().StartsWith(search.IdGTE));
            }
            filteredQuery = filteredQuery.Include("OrderHasOrderDetails.OrderDetail.Customer");
            filteredQuery = filteredQuery.Include("OrderHasOrderDetails.OrderDetail.Product");
            if (search?.SortByCreatedAtDesc == true)
            {
                filteredQuery = query.OrderByDescending(x => x.CreatedAt);
            }
            else
            {
                filteredQuery = query.OrderBy(x => x.CreatedAt);
            }
            return filteredQuery;
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
                throw new UserException($"Order {id} does not exist");
            }
            var state = _baseState.CreateState(entity.StateMachine);

            return await state.Cancel(id);
        }
        public async Task<Model.Order> Accept(int id)
        {
            var entity = await _context.Orders.FindAsync(id);
            if (entity == null)
            {
                throw new UserException($"Order {id} does not exist");
            }
            var state = _baseState.CreateState(entity.StateMachine);

            return await state.Accept(id);
        }
        public async Task<Model.Order> InProgress(int id)
        {
            var entity = await _context.Orders.FindAsync(id);
            if (entity == null)
            {
                throw new UserException($"Order {id} does not exist");
            }
            var state = _baseState.CreateState(entity.StateMachine);

            return await state.InProgress(id);
        }
        public async Task<Model.Order> Finish(int id)
        {
            var entity = await _context.Orders.FindAsync(id);
            if (entity == null)
            {
                throw new UserException($"Order {id} does not exist");
            }
            var state = _baseState.CreateState(entity.StateMachine);

            return await state.Finish(id);
        }
        public async Task<Model.Order> Deliver(int id)
        {
            var entity = await _context.Orders.FindAsync(id);
            if (entity == null)
            {
                throw new UserException($"Order {id} does not exist");
            }
            var state = _baseState.CreateState(entity.StateMachine);

            return await state.Deliver(id);
        }
    }
}
