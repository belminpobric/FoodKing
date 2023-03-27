using AutoMapper;
using FoodKing.Services.Database;
using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace FoodKing.Services
{
    public class BaseService<T, TDb> : IService<T> where T : class where TDb : class
    {
        protected FoodKingContext _context;
        protected IMapper _mapper { get; set; }

        public BaseService(FoodKingContext context, IMapper mapper)
        {
            _context = context;
            _mapper = mapper;
        }

        public async Task<List<T>> Get()
        {
            var entityList = await _context.Set<TDb>().ToListAsync();

            return _mapper.Map<List<T>>(entityList);
        }

        public async Task<T> GetByID(int id)
        {
            var entity = await _context.Set<TDb>().FindAsync(id);

            return _mapper.Map<T>(entity);
        }
    }
}
