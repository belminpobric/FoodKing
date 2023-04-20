using System;
using System.Collections.Generic;

namespace FoodKing.Services.Database;

public partial class User
{
    public string UserName { get; set; } = null!;

    public string FirstName { get; set; } = null!;

    public string LastName { get; set; } = null!;

    public string PhoneNumber { get; set; } = null!;

    public string Email { get; set; } = null!;

    public string Address { get; set; } = null!;

    public string CurrentAddress { get; set; } = null!;

    public string Password { get; set; } = null!;

    public string? Photo { get; set; }

    public int Id { get; set; }

    public virtual ICollection<UserHasRole> UserHasRoles { get; } = new List<UserHasRole>();
}
