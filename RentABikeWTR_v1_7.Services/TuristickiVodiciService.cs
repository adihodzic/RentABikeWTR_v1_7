using MapsterMapper;
using Microsoft.AspNetCore.Mvc;
using RentABikeWTR_v1_7.Model.Requests;
using RentABikeWTR_v1_7.Services.Database;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace RentABikeWTR_v1_7.Services
{
    public class TuristickiVodiciService : ITuristickiVodiciService
    {
        private readonly RentABikeWTR_v1_7Context _context;
        private readonly IMapper _mapper;

        public TuristickiVodiciService(RentABikeWTR_v1_7Context context, IMapper mapper)
        {
            _context = context;
            _mapper = mapper;
        }


        public  List<Model.TuristickiVodici> Get(TuristickiVodiciSearchRequest? request)
        {
            var query = _context.TuristickiVodici.AsQueryable();
            //if (!string.IsNullOrWhiteSpace(request?.Naziv))
            //{
            //    query = query.Where(x => x.Naziv.StartsWith(request.Naziv));
            //}

            if (!string.IsNullOrWhiteSpace(request?.Naziv))
            {
                query = query.Where(x => x.Naziv.StartsWith(request.Naziv));
            }
            var list = query.ToList();
            return _mapper.Map<List<Model.TuristickiVodici>>(list);
        }
        public List<Model.TuristickiVodici> GetVodici(TuristickiVodiciSearchRequest? request)
        {
            var query = _context.TuristickiVodici.AsQueryable();
            //if (!string.IsNullOrWhiteSpace(request?.Naziv))
            //{
            //    query = query.Where(x => x.Naziv.StartsWith(request.Naziv));
            //}

            if (!string.IsNullOrWhiteSpace(request?.Naziv))
            {
                query = query.Where(x => x.Naziv.StartsWith(request.Naziv));
            }
            var list = query.ToList();
            return _mapper.Map<List<Model.TuristickiVodici>>(list);
        }

        public  Model.TuristickiVodici GetById(int id)
        {
            var entity = _context.TuristickiVodici.Where(x => x.TuristickiVodicId == id).FirstOrDefault();
            return _mapper.Map<Model.TuristickiVodici>(entity);
        }
        public Model.Korisnici Update(int id, KorisniciUpsertRequest request)
        {
            var entity = _context.TuristickiVodici.Where(x => x.TuristickiVodicId == id).FirstOrDefault();
            _context.TuristickiVodici.Attach(entity);
            _context.TuristickiVodici.Update(entity);
            
            _context.SaveChanges();
            
            _mapper.Map(request, entity);
            _context.SaveChanges();
            return _mapper.Map<Model.Korisnici>(entity);
        }
        public Model.TuristickiVodici Insert(TuristickiVodiciUpsertRequest request)
        { 

            var entity = _mapper.Map<Database.TuristickiVodici>(request);
            _context.TuristickiVodici.Add(entity);
            _context.SaveChanges();

            return _mapper.Map<Model.TuristickiVodici>(entity);
        }
        public Model.TuristickiVodici Patch(int id, TuristickiVodiciUpsertRequest request)
        {
            var entity = _context.TuristickiVodici.Where(x => x.TuristickiVodicId == id).FirstOrDefault();
            _context.TuristickiVodici.Attach(entity);
            //_context.Korisnici.Patch(entity);
            //entity.TuristickiVodicId = id;
            entity.Naziv = request.Naziv ?? entity.Naziv;
            entity.Jezik = request.Jezik ?? entity.Jezik;
            entity.CijenaVodica = request.CijenaVodica;
            
            _context.SaveChanges();

            _mapper.Map(request, entity);
            _context.SaveChanges();
            return _mapper.Map<Model.TuristickiVodici>(entity);
        }

        public Model.TuristickiVodici Update(int id, TuristickiVodiciUpsertRequest request)
        {
            throw new NotImplementedException();
        }
    }
}
