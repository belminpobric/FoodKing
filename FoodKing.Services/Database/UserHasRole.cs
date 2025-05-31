using System;
using System.Collections.Generic;

namespace FoodKing.Services.Database;

public partial class UserHasRole
{
    public int Id { get; set; }

    public int UserId { get; set; }

    public int RoleId { get; set; }
    public DateTime CreatedAt { get; set; } = DateTime.Now;
    public DateTime UpdatedAt { get; set; } = DateTime.Now;
    public virtual Role Role { get; set; } = null!;

    public virtual User User { get; set; } = null!;
    public bool? SoftDelete { get; set; }

}
