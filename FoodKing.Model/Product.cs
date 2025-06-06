﻿namespace FoodKing.Model
{

    public partial class Product
    {
        public int Id { get; set; }

        public string Title { get; set; } = null!;
        public string? Photo { get; set; }

        public DateTime CreatedAt { get; set; } = DateTime.Now;
        public DateTime UpdatedAt { get; set; } = DateTime.Now;

    }
}
