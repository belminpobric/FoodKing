using System;
using System.Collections.Generic;

namespace FoodKing.Services.Database
{
    public partial class Payment
    {
        public int PaymentId { get; set; }
        public int? CustomerId { get; set; }
        public int? OrderId { get; set; }
        public DateTime? PaymentDate { get; set; }
        public double? Amount { get; set; }
        public string? PaymentType { get; set; }

        public virtual FoodOrder? Order { get; set; }
    }
}
