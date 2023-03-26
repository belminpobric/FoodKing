using FoodKing.Model.Requests;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace FoodKing.Services
{
    public interface IUserService
    {
        Task<List<Model.User>> Get();
        Model.User Insert(UserInsertRequest request);
        Model.User Update(int id, UserUpdateRequest request);
    }
}
