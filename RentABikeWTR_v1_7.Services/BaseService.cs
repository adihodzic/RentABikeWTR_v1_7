using MapsterMapper;
using RentABikeWTR_v1_7.Services.Database;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace RentABikeWTR_v1_7.Services
{
    public class BaseService<T, TSearch, TDatabase> : IService<T, TSearch> where TDatabase : class
    {
        protected readonly RentABikeWTR_v1_7Context _context;
        protected readonly IMapper _mapper;

        public BaseService(RentABikeWTR_v1_7Context context, IMapper mapper)
        {
            _context = context;
            _mapper = mapper;
        }

        public virtual List<T> Get(TSearch search)
        {
            var list = _context.Set<TDatabase>().ToList();
            return _mapper.Map<List<T>>(list);

        }

        public virtual T GetById(int id)
        {
            var entity = _context.Set<TDatabase>().Find(id);
            return _mapper.Map<T>(entity);
        }

    }
}
