using System;
using System.Collections.Generic;

namespace FoodKing.Services.Database;

public partial class Customer
{
    public int Id { get; set; }

    public string FirstName { get; set; } = null!;

    public string LastName { get; set; } = null!;
    public string? Photo { get; set; }
    public string? Address { get; set; }
    public string? Username { get; set; }

    public string PhoneNumber { get; set; } = null!;
    public DateTime CreatedAt { get; set; } = DateTime.Now;
    public DateTime UpdatedAt { get; set; } = DateTime.Now;
    public string Email { get; set; } = null!;
    public bool? SoftDelete { get; set; }
    public int? UserId { get; set; }
    public virtual User? User { get; set; }
    public virtual ICollection<OrderDetail> OrderDetails { get; } = new List<OrderDetail>();
}
