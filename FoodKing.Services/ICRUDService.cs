using FoodKing.Model;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace FoodKing.Services
{
    public interface ICRUDService<T, TSearch, TInsert, TUpdate> : IService<T, TSearch> where TSearch : class
    {
        Task<T> Insert(TInsert obj);
        Task<T> Update(int id, TUpdate obj);
    }
}
