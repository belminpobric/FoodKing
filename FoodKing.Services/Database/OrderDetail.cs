using System;
using System.Collections.Generic;

namespace FoodKing.Services.Database;

public partial class OrderDetail
{
    public int Id { get; set; }

    public string Details { get; set; } = null!;

    public string Price { get; set; } = null!;

    public bool? IsAccepted { get; set; }

    public int ProductId { get; set; }

    public int UserId { get; set; }

    public virtual Product Product { get; set; } = null!;

    public virtual User User { get; set; } = null!;
}
