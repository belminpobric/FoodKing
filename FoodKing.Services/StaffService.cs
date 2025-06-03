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
    public class StaffService : BaseCRUDService<Model.Staff, Database.Staff, StaffSearchObject, StaffInsertRequest, StaffUpdateRequest>, IStaffService
    {
        public StaffService(FoodKingContext context, IMapper mapper) : base(context, mapper)
        {
            _context = context;
            _mapper = mapper;
        }


        public override IQueryable<Database.Staff> AddFilter(IQueryable<Database.Staff> query, StaffSearchObject? search = null)
        {
            if (!string.IsNullOrWhiteSpace(search?.FirstName))
            {
                query = query.Where(x => x.FirstName.StartsWith(search.FirstName));
            }

            if (!string.IsNullOrWhiteSpace(search?.LastName))
            {
                query = query.Where(x => x.LastName.StartsWith(search.LastName));
            }

            if (!string.IsNullOrWhiteSpace(search?.Email))
            {
                query = query.Where(x => x.Email.StartsWith(search.Email));
            }
            if (!string.IsNullOrWhiteSpace(search?.PhoneNumber))
            {
                query = query.Where(x => x.PhoneNumber.StartsWith(search.PhoneNumber));
            }
            if (search?.isRoleIncluded == true)
            {
                query = query.Include("StaffHasRoles.Role");
            }
            if (search?.SortByCreatedAtDesc == true)
            {
                query = query.OrderByDescending(x => x.CreatedAt);
            }
            else
            {
                query = query.OrderBy(x => x.CreatedAt);
            }
            query  = query.Where(x => x.SoftDelete == false);
            return query;
        }

        public async Task Delete(int id)
        {
            var entity = await _context.Staff.FindAsync(id);
            if (entity == null)
            {
                throw new Exception("Entity does not exist.");
            }
            entity.SoftDelete = true;
            await _context.SaveChangesAsync();
        }
    }
}
