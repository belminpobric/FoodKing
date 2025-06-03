using AutoMapper;
using FoodKing.Model;
using FoodKing.Model.Requests;
using FoodKing.Services.Database;
using Microsoft.Extensions.DependencyInjection;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace FoodKing.Services.OrderStateMachine
{
    public class BaseState
    {
        protected FoodKingContext _context;
        
        protected IMapper _mapper;

        protected IServiceProvider _serviceProvider;

        public BaseState(IServiceProvider serviceProvider, IMapper mapper, FoodKingContext foodKingContext)
        {
            _context = foodKingContext;
            _mapper = mapper;
            _serviceProvider = serviceProvider;
        }

        public virtual Task<Model.Order> Insert(OrderInsertRequest request)
        {
            throw new UserException("Not allowed");
        }

        public virtual Task<Model.Order> Update(int id, OrderUpdateRequest request)
        {
            throw new UserException("Not allowed");
        }

        public virtual Task<Model.Order> Accept(int id)
        {
            throw new UserException("Not allowed");
        }

        public virtual Task<Model.Order> InProgress(int id)
        {
            throw new UserException("Not allowed");
        }
        public virtual Task<Model.Order> Finish(int id)
        {
            throw new UserException("Not allowed");
        }
        public virtual Task<Model.Order> Deliver(int id)
        {
            throw new UserException("Not allowed");
        }
        public virtual Task<Model.Order> Cancel(int id)
        {
            throw new UserException("Not allowed");
        }

        public BaseState CreateState(string stateName)
        {
            switch (stateName)
            {
                case "Initial":
                case null:
                    return _serviceProvider.GetService<InitialOrderState>();
                case "Accepted":
                    return _serviceProvider.GetService<AcceptedOrderState>();
                case "InProgress":
                    return _serviceProvider.GetService<InProgressOrderState>();
                case "Finished":
                    return _serviceProvider.GetService<FinishedOrderState>();
                case "Delivered":
                    return _serviceProvider.GetService<DeliveredOrderState>();
                case "Canceled":
                    return _serviceProvider.GetService<CanceledOrderState>();
                case "Updated":
                    return _serviceProvider.GetService<UpdatedOrderState>();
                default:
                    throw new UserException("Not allowed");
            }
        }
        public virtual async Task<List<string>> AllowedActions()
        {
            return new List<string>();
        }
    }
}
