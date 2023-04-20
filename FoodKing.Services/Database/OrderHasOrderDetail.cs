using System;
using System.Collections.Generic;

namespace FoodKing.Services.Database;

public partial class OrderHasOrderDetail
{
    public int Id { get; set; }

    public int? OrderDetailId { get; set; }

    public int? OrderId { get; set; }

    public virtual Order? Order { get; set; }

    public virtual OrderDetail? OrderDetail { get; set; }
}
