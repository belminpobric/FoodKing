using FoodKing.Model;
using FoodKing.Model.Requests;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace FoodKing.Services
{
    public interface IService<TModel, TSearch> where TSearch : class
    {
        Task<PagedResult<TModel>> Get(TSearch search = null);
        Task<TModel> GetByID(int id);
    }
}
