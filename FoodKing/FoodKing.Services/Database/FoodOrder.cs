using System;
using System.Collections.Generic;

namespace FoodKing.Services.Database
{
    public partial class FoodOrder
    {
        public FoodOrder()
        {
            Chefs = new HashSet<Chef>();
            Payments = new HashSet<Payment>();
        }

        public int OrderId { get; set; }
        public DateTime? OrderDate { get; set; }
        public int? CustomerId { get; set; }
        public double? Quantity { get; set; }
        public DateTime? PickupDate { get; set; }

        public virtual Customer? Customer { get; set; }
        public virtual ICollection<Chef> Chefs { get; set; }
        public virtual ICollection<Payment> Payments { get; set; }
    }
}
