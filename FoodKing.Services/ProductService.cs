﻿using AutoMapper;
using FoodKing.Model.Requests;
using FoodKing.Model.SearchObjects;
using FoodKing.Services.Database;

namespace FoodKing.Services
{
    public class ProductService: BaseCRUDService<Model.Product, Database.Product, ProductSearchObject, ProductInsertRequest, ProductUpdateRequest>, IProductService
    {
        public ProductService(FoodKingContext context, IMapper mapper) : base(context, mapper)
        {
            _context = context;
            _mapper = mapper;
        }
        public override IQueryable<Database.Product> AddFilter(IQueryable<Database.Product> query, ProductSearchObject? search = null)
        {
            if (!string.IsNullOrWhiteSpace(search?.Title))
            {
                query = query.Where(x => x.Title.StartsWith(search.Title));
            }
            if (search?.SortByCreatedAtDesc == true)
            {
                query = query.OrderByDescending(x => x.CreatedAt);
            }
            else
            {
                query = query.OrderBy(x => x.CreatedAt);
            }
            query = query.Where(x => x.SoftDelete == false || x.SoftDelete == null);

            return query;
        }
        public async Task Delete(int id)
        {
            var entity = await _context.Products.FindAsync(id);
            if (entity == null)
            {
                throw new Exception("Entity does not exist.");
            }
            entity.SoftDelete = true;
            await _context.SaveChangesAsync();
        }
    }
}
