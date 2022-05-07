using System;

namespace FoodKing.Model
{
    public partial class Customer
    {

        public int CustomerId { get; set; }
        public string Email { get; set; } 
        public string Phone { get; set; }
        public string FirstName { get; set; } 
        public string LastName { get; set; } 
        public int? PaymentId { get; set; }
        public int? FoodId { get; set; } 

        //public virtual ICollection<FoodOrder> FoodOrders { get; set; }
    }
}
