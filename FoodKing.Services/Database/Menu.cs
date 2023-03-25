using System;
using System.Collections.Generic;

namespace FoodKing.Services.Database;

public partial class Menu
{
    public int Id { get; set; }

    public string Title { get; set; } = null!;

    public virtual ICollection<MenuHasProduct> MenuHasProducts { get; } = new List<MenuHasProduct>();
}
