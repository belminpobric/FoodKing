using System;
using System.Collections.Generic;

namespace FoodKing.Services.Database;

public partial class DailyMenuHasProduct
{
    public int Id { get; set; }

    public int? ProductId { get; set; }

    public int? DailyMenuId { get; set; }
    public DateTime CreatedAt { get; set; } = DateTime.Now;
    public DateTime UpdatedAt { get; set; } = DateTime.Now;
    public virtual DailyMenu? DailyMenu { get; set; }

    public virtual Product? Product { get; set; }
    public bool? SoftDelete { get; set; }

}
