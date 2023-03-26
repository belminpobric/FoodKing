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
    public class UserService : IUserService
    {
        FoodKingContext _context;
        public IMapper _mapper { get; set; }

        public UserService(FoodKingContext context, IMapper mapper)
        {
            _context = context;
            _mapper = mapper;
        }

        public async Task<List<Model.User>> Get()
        {
            var entityList = await _context.Users.ToListAsync();

            return _mapper.Map<List<Model.User>>(entityList);
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

        public Model.User Update(int id, UserUpdateRequest request)
        {
            throw new NotImplementedException();
        }
    }
}
