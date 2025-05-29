using AutoMapper;
using FoodKing.Model;
using FoodKing.Model.SearchObjects;
using FoodKing.Services.Database;
using Microsoft.EntityFrameworkCore;
using System.Linq;

namespace FoodKing.Services
{
    public class BaseService<TModel, TDb, TSearch> : IService<TModel, TSearch> where TModel : class where TDb : class where TSearch : BaseSearchObject
    {
        protected FoodKingContext _context;
        protected IMapper _mapper { get; set; }

        public BaseService(FoodKingContext context, IMapper mapper)
        {
            _context = context;
            _mapper = mapper;
        }

        public virtual async Task<PagedResult<TModel>> Get(TSearch? search = null)
        {
            var query = _context.Set<TDb>().AsQueryable();

            PagedResult<TModel> result = new PagedResult<TModel>();

            query = AddFilter(query, search);

            result.Count = await query.CountAsync();

            if (search?.Page.HasValue == true && search?.PageSize.HasValue == true)
            {
                query = query.Take(search.PageSize.Value).Skip(search.Page.Value * search.PageSize.Value);  
            }
            result.Result = _mapper.Map<List<TModel>>(await query.ToListAsync());
            return result;
        }

        public virtual async Task<TModel> GetByID(int id)
        {
            var entity = await _context.Set<TDb>().FindAsync(id);
            if (entity  == null)
            {
                return null;
            }
            return _mapper.Map<TModel>(entity);
        }

        public virtual IQueryable<TDb> AddFilter(IQueryable<TDb> query, TSearch? search = null)
        {
            return query;
        }
    }
}
