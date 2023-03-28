using FoodKing.Model.Requests;
using FoodKing.Model.SearchObjects;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace FoodKing.Services
{
    public interface IUserService : IService<Model.User, UserSearchObject>
    {
        Model.User Insert(UserInsertRequest request);
        Task<Model.User> Update(int id, UserUpdateRequest request);
    }
}
