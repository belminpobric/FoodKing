using System;
using System.Collections.Generic;

namespace FoodKing.Services.Database;

public partial class Role
{
    public int Id { get; set; }

    public string Name { get; set; } = null!;

    public virtual ICollection<UserHasRole> UserHasRoles { get; } = new List<UserHasRole>();
}
