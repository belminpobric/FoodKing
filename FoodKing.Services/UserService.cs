using FoodKing.Model;
using FoodKing.Services.Database;
using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace FoodKing.Services
{
    public class UserService : IUserService
    {
        FoodKingContext _context;
        public UserService(FoodKingContext context)
        {
            _context = context;
        }

        public async Task<List<Model.User>> Get()
        {
            var entityList = await _context.Users.ToListAsync();

            List<Model.User> users = new List<Model.User>();
            foreach (var user in entityList)
            {
                users.Add(new Model.User
                {
                    Address = user.Address,
                    PhoneNumber = user.PhoneNumber,
                    FirstName = user.FirstName,
                    LastName = user.LastName,
                    Email = user.Email,
                    CurrentAddress = user.CurrentAddress,
                    UserId = user.Id,
                    Username = user.UserName
                });
            }
            return users;
        }
    }
}
