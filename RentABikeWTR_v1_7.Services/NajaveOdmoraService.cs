using MapsterMapper;
using RentABikeWTR_v1_7.Model.Requests;
using RentABikeWTR_v1_7.Services.Database;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace RentABikeWTR_v1_7.Services
{
    public class NajaveOdmoraService : INajaveOdmoraService
    {
        private readonly RentABikeWTR_v1_7Context _context;
        private readonly IMapper _mapper;

        public NajaveOdmoraService(RentABikeWTR_v1_7Context context, IMapper mapper)
        {
            _context = context;
            _mapper = mapper;
        }
        public List<Model.NajaveOdmora> Get(NajaveOdmoraSearchRequest? request)
        {
            var query = _context.NajaveOdmora.AsQueryable();
            if (request != null) {
                query = _context.NajaveOdmora.Where(x => x.DatumOdmora.Date == request.DatumOdmora.Date);
                var lista = query.ToList();

                return _mapper.Map<List<Model.NajaveOdmora>>(lista);
            }
            else
            {
                var lista2=query.ToList();
                return _mapper.Map<List<Model.NajaveOdmora>>(lista2);

            }
            
        }

        public List<Model.NajaveOdmoraPregled> GetNajavePregled(DateTime? DatumOd, DateTime? DatumDo)
        {
            var query = _context.NajaveOdmora.AsQueryable()
                .Where(x => x.DatumOdmora.Date>= DatumOd && x.DatumOdmora.Date<= DatumDo)
                .Select(b => new
                {
                    NajavaOdmoraId = b.NajavaOdmoraId,
                    DatumOdmora = b.DatumOdmora,
                    PocetakOdmora = b.PocetakOdmora,
                    ZavrsetakOdmora = b.ZavrsetakOdmora,
                    NapitakKolicina = b.NapitakKolicina,
                    LaunchPaketKolicina = b.LaunchPaketKolicina,
                    LokacijaOdmoraID = b.LokacijaOdmoraID,
                    NazivLokacije = b.LokacijaOdmora.Naziv,
                    TuristickiVodicID = b.TuristickiVodicID,
                    NazivVodica = b.TuristickiVodic.Naziv

                });

            //query = _context.NajaveOdmora.Where(x => x.DatumOdmora.Date == request.DatumOdmora.Date);
            var lista = query.ToList();

            return _mapper.Map<List<Model.NajaveOdmoraPregled>>(lista);
        }
        public Model.NajaveOdmora GetById(int id)
        {
            var entity = _context.Poslovnice.Where(x => x.PoslovnicaId == id).FirstOrDefault();
            return _mapper.Map<Model.NajaveOdmora>(entity);
        }

        public Model.NajaveOdmora Update(int id, NajaveOdmoraUpsertRequest request)
        {
            var entity = _context.NajaveOdmora.Where(x => x.NajavaOdmoraId == id).FirstOrDefault();
            _context.NajaveOdmora.Attach(entity);
            _context.NajaveOdmora.Update(entity);

            _context.SaveChanges();

            _mapper.Map(request, entity);
            _context.SaveChanges();
            return _mapper.Map<Model.NajaveOdmora>(entity);
        }
        public Model.NajaveOdmora Insert(NajaveOdmoraUpsertRequest request)
        {

            var entity = _mapper.Map<Database.NajaveOdmora>(request);
            _context.NajaveOdmora.Add(entity);
            _context.SaveChanges();

            return _mapper.Map<Model.NajaveOdmora>(entity);
        }
        
        //public Model.NajaveOdmora Patch(int id, NajaveOdmoraUpsertRequest request)
        //{
        //    var entity = _context.Poslovnice.Where(x => x.PoslovnicaId == id).FirstOrDefault();
        //    _context.Poslovnice.Attach(entity);

        //    entity.NazivPoslovnice = request.NazivPoslovnice ?? entity.NazivPoslovnice;
        //    entity.EmailKontakt = request.EmailKontakt ?? entity.EmailKontakt;
        //    entity.Adresa = request.Adresa ?? entity.Adresa;
        //    entity.BrojTelefona = request.BrojTelefona ?? entity.BrojTelefona;

        //    _context.SaveChanges();

        //    _mapper.Map(request, entity);
        //    _context.SaveChanges();
        //    return _mapper.Map<Model.Poslovnice>(entity);
        //}

        
        
    }
}
