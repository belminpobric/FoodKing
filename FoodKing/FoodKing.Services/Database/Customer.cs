using System;
using System.Collections.Generic;

namespace FoodKing.Services.Database
{
    public partial class Customer
    {
        public Customer()
        {
            FoodOrders = new HashSet<FoodOrder>();
        }

        public int CustomerId { get; set; }
        public string Email { get; set; } = null!;
        public string? Phone { get; set; }
        public string FirstName { get; set; } = null!;
        public string LastName { get; set; } = null!;
        public int? PaymentId { get; set; }
        public int? FoodId { get; set; }

        public virtual ICollection<FoodOrder> FoodOrders { get; set; }
    }
}
