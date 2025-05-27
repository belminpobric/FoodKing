namespace FoodKing.Model
{

    public partial class OrderHasOrderDetail
    {
        public int Id { get; set; }

        public int? OrderDetailId { get; set; }

        public int? OrderId { get; set; }

        public DateTime CreatedAt { get; set; } = DateTime.Now;
        public DateTime UpdatedAt { get; set; } = DateTime.Now;
        public virtual OrderDetail OrderDetail { get; set; } = null!;

    }
}
