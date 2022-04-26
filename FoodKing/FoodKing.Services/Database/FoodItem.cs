using System;
using System.Collections.Generic;

namespace FoodKing.Services.Database
{
    public partial class FoodItem
    {
        public FoodItem()
        {
            Menus = new HashSet<Menu>();
            OrderItems = new HashSet<OrderItem>();
        }

        public int FoodId { get; set; }
        public string Name { get; set; } = null!;
        public double Quantity { get; set; }
        public double UnitPrice { get; set; }
        public string ItemCategory { get; set; } = null!;

        public virtual ICollection<Menu> Menus { get; set; }
        public virtual ICollection<OrderItem> OrderItems { get; set; }
    }
}
