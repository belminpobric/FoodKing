using System;
using System.Collections.Generic;

namespace FoodKing.Services.Database;

public partial class Product
{
    public int Id { get; set; }

    public string Title { get; set; } = null!;

    public virtual ICollection<MenuHasProduct> MenuHasProducts { get; } = new List<MenuHasProduct>();

    public virtual ICollection<OrderDetail> OrderDetails { get; } = new List<OrderDetail>();
}
