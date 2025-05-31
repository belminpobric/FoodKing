using System;
using System.Collections.Generic;

namespace FoodKing.Services.Database;

public partial class Role
{
    public int Id { get; set; }

    public string Name { get; set; } = null!;
    public DateTime CreatedAt { get; set; } = DateTime.Now;
    public DateTime UpdatedAt { get; set; } = DateTime.Now;
    public virtual ICollection<UserHasRole> UserHasRoles { get; } = new List<UserHasRole>();
    public bool? SoftDelete { get; set; }

}
