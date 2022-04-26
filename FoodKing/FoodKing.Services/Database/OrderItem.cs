using System;
using System.Collections.Generic;

namespace FoodKing.Services.Database
{
    public partial class OrderItem
    {
        public int OrderId { get; set; }
        public int? FoodId { get; set; }
        public double? Quantity { get; set; }
        public double? UnitPrice { get; set; }

        public virtual FoodItem? Food { get; set; }
    }
}
