namespace FoodKing.Model
{
    public class Order
    {
        public int Id { get; set; }

        public decimal? Price { get; set; }

        public bool? IsAccepted { get; set; }

        public string? StateMachine { get; set; }
        public DateTime CreatedAt { get; set; } = DateTime.Now;
        public DateTime UpdatedAt { get; set; } = DateTime.Now;
    }
}
