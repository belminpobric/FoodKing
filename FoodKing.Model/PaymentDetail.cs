namespace FoodKing.Model
{

    public partial class PaymentDetail
    {
        public int Id { get; set; }

        public int OrderNumber { get; set; }

        public DateTime CreatedAt { get; set; } = DateTime.Now;
        public DateTime UpdatedAt { get; set; } = DateTime.Now;
    }
}
