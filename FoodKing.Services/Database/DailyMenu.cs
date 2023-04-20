using System;
using System.Collections.Generic;

namespace FoodKing.Services.Database;

public partial class DailyMenu
{
    public int Id { get; set; }

    public string Title { get; set; } = null!;
}
