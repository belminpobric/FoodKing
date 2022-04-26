using FoodKing.Services.Database;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace FoodKing.Services
{
    public interface IFoodService
    {
        IEnumerable<FoodItem> GetFoodItems();
    }
}
