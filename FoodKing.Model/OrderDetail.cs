namespace FoodKing.Model
{

    public partial class OrderDetail
    {
        public int Id { get; set; }

        public string Details { get; set; } = null!;

        public int ProductId { get; set; }

        public int? CustomerId { get; set; }
        public DateTime CreatedAt { get; set; } = DateTime.Now;
        public DateTime UpdatedAt { get; set; } = DateTime.Now;
        public virtual Customer? Customer { get; set; }

        //public virtual ICollection<OrderHasOrderDetail> OrderHasOrderDetails { get; } = new List<OrderHasOrderDetail>();

        public virtual Product Product { get; set; } = null!;
    }
}
