using AutoMapper;
using FoodKing.Model;
using FoodKing.Model.Requests;
using FoodKing.Model.SearchObjects;
using FoodKing.Services.Database;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Logging.Abstractions;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Security.Cryptography;
using System.Text;
using System.Threading.Tasks;

namespace FoodKing.Services
{
    public class UserService : BaseCRUDService<Model.User, Database.User, UserSearchObject, UserInsertRequest, UserUpdateRequest>, IUserService
    {
        public UserService(FoodKingContext context, IMapper mapper) : base(context, mapper)
        {
            _context = context;
            _mapper = mapper;
        }
        public override async Task BeforeInsert(Database.User entity, UserInsertRequest insert)
        {
            entity.Password = ComputeHash(insert.Password, new SHA256CryptoServiceProvider());
        }
        public string ComputeHash(string input, HashAlgorithm algorithm)
        {
            Byte[] inputBytes = Encoding.UTF8.GetBytes(input);

            Byte[] hashedBytes = algorithm.ComputeHash(inputBytes);

            return BitConverter.ToString(hashedBytes);
        }

        public override IQueryable<Database.User> AddFilter(IQueryable<Database.User> query, UserSearchObject? search = null)
        {
            if (!string.IsNullOrWhiteSpace(search?.FirstName))
            {
                query = query.Where(x => x.FirstName.StartsWith(search.FirstName));
            }

            if (!string.IsNullOrWhiteSpace(search?.LastName))
            {
                query = query.Where(x => x.LastName.StartsWith(search.LastName));
            }

            return query;
        }

        public async Task<Model.User> Login(string username, string password)
        {
            var entity = await _context.Users.Include("UserHasRoles.Role").FirstOrDefaultAsync(x => x.UserName == username);

            if (entity == null)
            {
                return null;
            }
            var hash = ComputeHash(password, new SHA256CryptoServiceProvider());

            if (hash != entity.Password)
            {
                return null;
            }
            return _mapper.Map<Model.User>(entity);
        }
    }
}
