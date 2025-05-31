using System;
using System.Collections.Generic;

namespace FoodKing.Services.Database;

public partial class PaymentDetail
{
    public int Id { get; set; }

    public int OrderNumber { get; set; }

    public DateTime CreatedAt { get; set; } = DateTime.Now;
    public DateTime UpdatedAt { get; set; } = DateTime.Now;
    public bool? SoftDelete { get; set; }

}
