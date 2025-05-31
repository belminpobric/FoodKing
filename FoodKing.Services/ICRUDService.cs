using FoodKing.Model;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace FoodKing.Services
{
    public interface ICRUDService<TModel, TSearch, TInsert, TUpdate> : IService<TModel, TSearch> where TSearch : class
    {
        Task<TModel> Insert(TInsert obj);
        Task<TModel> Update(int id, TUpdate obj);
        Task Delete(int id);
    }
}
