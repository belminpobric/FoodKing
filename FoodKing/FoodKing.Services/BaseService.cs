using AutoMapper;
using FoodKing.Services.Database;

namespace FoodKing.Services
{
    public class BaseService<T, TDb> : IService<T> where T : class where TDb: class
    {
        public FoodKingContext _context { get; set; }
        public IMapper Mapper { get; set; }

        public BaseService(FoodKingContext foodKingContext, IMapper mapper)
        {
            this._context = foodKingContext;
            this.Mapper = mapper;
        }
        public IEnumerable<T> Get()
        {
            var entity = _context.Set<TDb>();

            var list = entity.ToList();

            return Mapper.Map<IEnumerable<T>>(list);
        }

        public T GetById(int id)
        {
            var set = _context.Set<TDb>();

            var entity = set.Find(id);

            return Mapper.Map<T>(entity);
        }
    }
}
