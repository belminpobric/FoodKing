using FoodKing.Model.Requests;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace FoodKing.Services
{
    public interface IService<T>
    {
        Task<List<T>> Get();
        Task<T> GetByID(int id);
    }
}
