namespace FoodKing.Model
{
    public class Order
    {
        public int Id { get; set; }

        public decimal? Price { get; set; }

        public bool? IsAccepted { get; set; }

        public string? StateMachine { get; set; }
        public DateTime CreatedAt { get; set; }
        public DateTime UpdatedAt { get; set; } = DateTime.Now;
        public virtual ICollection<OrderHasOrderDetail> OrderHasOrderDetails { get; } = new List<OrderHasOrderDetail>();

        public virtual PaymentDetail? PaymentDetail { get; set; }

    }
}
