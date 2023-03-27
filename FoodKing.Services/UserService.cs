using AutoMapper;
using FoodKing.Model;
using FoodKing.Model.Requests;
using FoodKing.Services.Database;
using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Security.Cryptography;
using System.Text;
using System.Threading.Tasks;

namespace FoodKing.Services
{
    public class UserService : BaseService<Model.User, Database.User>, IUserService
    {
        public UserService(FoodKingContext context, IMapper mapper) : base(context, mapper)
        {
            _context = context;
            _mapper = mapper;
        }

        public Model.User Insert(UserInsertRequest request)
        {
            var entity = new Database.User();
            _mapper.Map(request, entity);

            entity.Password = ComputeHash(request.Password, new SHA256CryptoServiceProvider());

            _context.Users.Add(entity);
            _context.SaveChanges();

            return _mapper.Map<Model.User>(entity);

        }
        public string ComputeHash(string input, HashAlgorithm algorithm)
        {
            Byte[] inputBytes = Encoding.UTF8.GetBytes(input);

            Byte[] hashedBytes = algorithm.ComputeHash(inputBytes);

            return BitConverter.ToString(hashedBytes);
        }

        public async Task<Model.User> Update(int id, UserUpdateRequest request)
        {
            var result = await _context.Users.SingleOrDefaultAsync(b => b.Id == id);
            var user = new Model.User();
            if (result != null)
            {
                _mapper.Map(request, result);
                await _context.SaveChangesAsync();

                return _mapper.Map(result, user);
            }
            return await Task.FromResult(user);
        }

    }
}
