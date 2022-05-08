namespace FoodKing.Services
{
    public interface IService<T> where T : class
    {
        IEnumerable<T> Get();

        T GetById(int id);
    }
}
