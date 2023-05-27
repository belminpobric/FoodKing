using FoodKing.Services.Database;
using Newtonsoft.Json.Linq;
using System.Collections.Generic;
using System.Security.Cryptography;
using System.Text;

namespace FoodKing.DbSeed
{
    public class DbInitializer
    {
        public async static Task Initialize(FoodKingContext dbContext)
        {
            ArgumentNullException.ThrowIfNull(dbContext, nameof(dbContext));
            dbContext.Database.EnsureCreated();
            if (dbContext.Users.Any()) return;

            var password = ComputeHash("admin");

            var user = new User
            {
                FirstName = "Admin",
                LastName = "Admin",
                Password = password,
                UserName = "admin",
                PhoneNumber = "000-000-000",
                Email= "admin@admin.com",
                Address = "Admin Address",
                CurrentAddress = "current address",
                Photo = "pijas"
            };
            dbContext.Users.Add(user);


            var role = new Role
            {
                Name = "Administrator"
            };
            dbContext.Roles.Add(role);


            var userRole = new UserHasRole
            {
                User = user,
                Role = role
            };
            dbContext.UserHasRoles.Add(userRole);
            await dbContext.SaveChangesAsync();

        }
        public static string ComputeHash(string value)
        {
            using var hash = SHA256.Create();
            var byteArray = hash.ComputeHash(Encoding.UTF8.GetBytes(value));
            return Convert.ToHexString(byteArray);
        }
    }
}
