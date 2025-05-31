using System;
using System.Collections.Generic;

namespace FoodKing.Services.Database;

public partial class DailyMenu
{
    public int Id { get; set; }

    public string Title { get; set; } = null!;
    public DateTime CreatedAt { get; set; } = DateTime.Now;
    public DateTime UpdatedAt { get; set; } = DateTime.Now;
    public bool? SoftDelete { get; set; }

}
