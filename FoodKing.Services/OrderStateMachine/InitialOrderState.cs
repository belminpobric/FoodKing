﻿using AutoMapper;
using FoodKing.Model.Requests;
using FoodKing.Services.Database;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace FoodKing.Services.OrderStateMachine
{
    public class InitialOrderState : BaseState
    {
        public InitialOrderState(IServiceProvider serviceProvider, IMapper mapper, FoodKingContext context) : base(serviceProvider, mapper, context)
        {
            
        }
        public override async Task<Model.Order> Insert(OrderInsertRequest request)
        {
            var set = _context.Set<Database.Order>();

            var entity = _mapper.Map<Database.Order>(request);

            entity.StateMachine = "initiated";
            set.Add(entity);

            await _context.SaveChangesAsync();

            return _mapper.Map<Model.Order>(entity);
        }

        public override async Task<List<string>> AllowedActions()
        {
            var list = await base.AllowedActions();

            list.Add("Cancel");

            return list;
        }
    }
}