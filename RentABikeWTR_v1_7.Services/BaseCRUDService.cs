using MapsterMapper;
using Microsoft.EntityFrameworkCore;
using RentABikeWTR_v1_7.Services.Database;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace RentABikeWTR_v1_7.Services
{
    public class BaseCRUDService<T, TSearch, TInsert, TUpdate, TDatabase> : BaseService<T, TSearch, TDatabase>,
        ICRUDService<T, TSearch, TInsert, TUpdate> where TDatabase : class
    {

        public BaseCRUDService(RentABikeWTR_v1_7Context context, IMapper mapper) : base(context, mapper)
            {
            }

            public virtual T Delete(int id)
            {
                var entity = _context.Set<TDatabase>().Find(id);
                _context.Set<TDatabase>().Remove(entity);
                _context.SaveChanges();
                return _mapper.Map<T>(entity);
            }

            public virtual T Insert(TInsert request)
            {
                var entity = _mapper.Map<TDatabase>(request);
                _context.Set<TDatabase>().Add(entity);
                _context.SaveChanges();
                return _mapper.Map<T>(entity);
            }

            public virtual T Update(int id, TUpdate request)
            {
                var entity = _context.Set<TDatabase>().Find(id);
                _context.Set<TDatabase>().Attach(entity);
                _context.Set<TDatabase>().Update(entity);
                _mapper.Map(request, entity);
                _context.SaveChanges();
                return _mapper.Map<T>(entity);
            }
        }
    
}
