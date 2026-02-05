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
            entity.Password = ComputeHash(insert.Password);
            var role = await _context.Roles.FirstOrDefaultAsync(x => x.Id == insert.Role);
            if (role != null)
            {
                var userHasRole = new Database.UserHasRole
                {
                    User = entity,
                    Role = role
                };
                _context.UserHasRoles.Add(userHasRole);
                await _context.SaveChangesAsync();
            }
            await base.BeforeInsert(entity, insert);
        }
        public static string ComputeHash(string value)
        {
            using var hash = SHA256.Create();
            var byteArray = hash.ComputeHash(Encoding.UTF8.GetBytes(value));
            return Convert.ToHexString(byteArray);
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

            if (search?.isRoleIncluded == true)
            {
                query = query.Include("UserHasRoles.Role");
            }
            if (search?.SortByCreatedAtDesc == true)
            {
                query = query.OrderByDescending(x => x.CreatedAt);
            }
            else
            {
                query = query.OrderBy(x => x.CreatedAt);
            }
            query  = query.Where(x => x.SoftDelete == false || x.SoftDelete == null);
            return query;
        }

        public async Task<Model.User> Login(string username, string password)
        {
            var entity = await _context.Users.Include("UserHasRoles.Role").FirstOrDefaultAsync(x => x.UserName == username);

            if (entity == null)
            {
                return null;
            }
            var hash = ComputeHash(password);

            if (hash != entity.Password)
            {
                return null;
            }
            return _mapper.Map<Model.User>(entity);
        }
        public async Task<Model.User> GetByID(int id)
        {
            var entity = await _context.Users.Include("UserHasRoles.Role").Where(x => x.Id == id).FirstOrDefaultAsync();
            if (entity == null)
            {
                return null;
            }
            return _mapper.Map<Model.User>(entity);
        }
        public async Task Delete(int id)
        {
            var entity = await _context.Users.FindAsync(id);
            if (entity == null)
            {
                throw new Exception("Entity does not exist.");
            }
            entity.SoftDelete = true;
            await _context.SaveChangesAsync();
        }
    }
}
