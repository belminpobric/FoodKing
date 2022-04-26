using FoodKing.Services.Database;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace FoodKing.Services
{
    public class FoodService : IFoodService
    {
        public FoodKingContext _context { get; set; }
        public FoodService(FoodKingContext context)
        {
            _context = context;
        }
        public IEnumerable<FoodItem> GetFoodItems()
        {
            return _context.FoodItems.ToList();
        }
    }
}
