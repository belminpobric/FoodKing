using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace FoodKing.Model
{
    public class MenuHasProduct
    {
        public int Id { get; set; }

        public int MenuId { get; set; }

        public int ProductId { get; set; }
        public DateTime CreatedAt { get; set; } = DateTime.Now;
        public DateTime UpdatedAt { get; set; } = DateTime.Now;

        public virtual Product Product { get; set; } = null!;

    }
}
