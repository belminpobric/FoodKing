using System;
using System.Collections.Generic;

namespace FoodKing.Services.Database;

public partial class Order
{
    public int Id { get; set; }

    public decimal? Price { get; set; }

    public bool? IsAccepted { get; set; }

    public string? StateMachine { get; set; }
    public DateTime CreatedAt { get; set; } = DateTime.Now;
    public DateTime UpdatedAt { get; set; } = DateTime.Now;
    public virtual ICollection<OrderHasOrderDetail> OrderHasOrderDetails { get; } = new List<OrderHasOrderDetail>();
    public virtual PaymentDetail? PaymentDetail { get; set; }
    //public int? PaymentDetailsId { get; set; } 

}
