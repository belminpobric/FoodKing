using System;
using System.Collections.Generic;

namespace FoodKing.Services.Database;

public partial class MenuHasProduct
{
    public int Id { get; set; }

    public int? ProductId { get; set; }

    public int? MenuId { get; set; }
    public DateTime CreatedAt { get; set; } = DateTime.Now;
    public DateTime UpdatedAt { get; set; } = DateTime.Now;
    public virtual Menu? Menu { get; set; }

    public virtual Product? Product { get; set; }
    public bool? SoftDelete { get; set; }

}
