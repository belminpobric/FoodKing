using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace FoodKing.Model.Requests
{
    public class ProductInsertRequest
    {
        public string Title { get; set; } = null!;
        public string? Photo { get; set; }
        public int MenuId { get; set; }

        public decimal? Price { get; set; }

    }
}
