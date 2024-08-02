using MapsterMapper;
using Microsoft.EntityFrameworkCore.Migrations.Operations;
using RentABikeWTR_v1_7.Model;
using RentABikeWTR_v1_7.Model.Requests;
using RentABikeWTR_v1_7.Services.Database;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace RentABikeWTR_v1_7.Services
{
    public class ServisiranjaService : IServisiranjaService
    {
        private readonly RentABikeWTR_v1_7Context _context;
        private readonly IMapper _mapper;

        public ServisiranjaService(RentABikeWTR_v1_7Context context, IMapper mapper)
        {
            _context = context;
            _mapper = mapper;
        }

        public List<Model.Servisiranja> Get(int? biciklid)
        {
            var query = _context.Servisiranja.AsQueryable();
            if (biciklid.HasValue)
            {
                query = query.Where(x => x.BiciklID == biciklid);
                var list = query.ToList();
                return _mapper.Map<List<Model.Servisiranja>>(list);
            }
            else
            {
                var lista = query.ToList();
                return _mapper.Map<List<Model.Servisiranja>>(lista);
            }



        }
        public Model.Servisiranja GetById(int id)
        {
            var entity = _context.Servisiranja.Where(x => x.ServisiranjeId == id).FirstOrDefault();
            return _mapper.Map<Model.Servisiranja>(entity);
        }
        public Model.Servisiranja Update(int id, ServisiranjaUpsertRequest request)
        {
            var entity = _context.Servisiranja.Where(x => x.ServisiranjeId == id).FirstOrDefault();
            _context.Servisiranja.Attach(entity);
            _context.Servisiranja.Update(entity);

            _context.SaveChanges();

            _mapper.Map(request, entity);
            _context.SaveChanges();
            return _mapper.Map<Model.Servisiranja>(entity);
        }

        public Model.Servisiranja Insert(ServisiranjaUpsertRequest request)
        {
            var entity = _mapper.Map<Database.Servisiranja>(request);

            _context.Servisiranja.Add(entity);
            _context.SaveChanges();

            // Add new ServisiranjaDijelovi from request
            foreach (var item in request.RezervniDijelovi)
            {
                //bitno za update vrijednosti naStanju
                var rezervniDio = _context.RezervniDijelovi.Where(x => x.RezervniDijeloviId == item.RezervniDijeloviId).FirstOrDefault();
                if (rezervniDio != null)
                {
                    //rezervniDio.NaStanju = (int)item.NaStanju;  // Update the stock value
                    rezervniDio.NaStanju--;
                }
                var newDio = new ServisiranjaDijelovi
                {
                    RezervniDijeloviID = item.RezervniDijeloviId,
                    ServisiranjeID = entity.ServisiranjeId
                };
                _context.ServisiranjaDijelovi.Add(newDio);
            }

            _context.SaveChanges();


            return _mapper.Map<Model.Servisiranja>(entity);

        }

        public List<Model.ServisiranjaPregled> GetServisiranjaPregled(int? id)
        {
            {
                //var dijelovi= new List<Model.RezervniDijelovi>();
                //var lista = _context.ServisiranjaDijelovi.AsQueryable().ToList();
                if (id != null)
                {
                    var query = _context.Servisiranja.AsQueryable()
                    .Where(b => b.BiciklID == id)//ako bude trazena forma detalji ukljucicu ID-eve za vanjske tabele.

                    .Select(p => new
                    {
                        ServisiranjeId = p.ServisiranjeId,
                        OpisKvara = p.OpisKvara,
                        DatumServisiranja = p.DatumServisiranja,
                        KomentarServisera = p.KomentarServisera,
                        NazivBicikla = p.Bicikl.NazivBicikla,
                        BiciklID = id,
                        RezervniDijelovi = p.ServisiranjaDijelovi.Where(b => b.ServisiranjeID == p.ServisiranjeId).Select(rd => rd.RezervniDio).ToList()


                        //RezervniDijelovi = _context.ServisiranjaDijelovi.Where(g => g.ServisiranjeID == p.ServisiranjeId).ToList()


                    }).ToList();


                    return _mapper.Map<List<Model.ServisiranjaPregled>>(query);
                }
                else
                {
                    var query = _context.Servisiranja
                        .Select(r => new
                        {
                            ServisiranjeId = r.ServisiranjeId,
                            OpisKvara = r.OpisKvara,
                            DatumServisiranja = r.DatumServisiranja,
                            PreduzetaAkcija = r.PreduzetaAkcija,
                            KomentarServisera = r.KomentarServisera,
                            NazivBicikla = r.Bicikl.NazivBicikla,
                            BiciklID = r.BiciklID,
                            RezervniDijelovi = r.ServisiranjaDijelovi.Where(b => b.ServisiranjeID == r.ServisiranjeId).Select(rd => rd.RezervniDio).ToList()

                            //RezervniDijelovi = _context.ServisiranjaDijelovi.Where(g => g.ServisiranjeID == r.ServisiranjeId).ToList()


                        }).ToList();

                    return _mapper.Map<List<Model.ServisiranjaPregled>>(query);
                }


            }

        }

        public Model.Servisiranja Patch(int id, ServisiranjaUpsertRequest request)
        {
            var entity = _context.Servisiranja.Where(x => x.ServisiranjeId == id).FirstOrDefault();


            _context.Servisiranja.Attach(entity);
            entity.ServisiranjeId = id;
            entity.KomentarServisera = request.KomentarServisera ?? entity.KomentarServisera;
            entity.PreduzetaAkcija = request.PreduzetaAkcija ?? entity.PreduzetaAkcija;
            entity.OpisKvara = request.OpisKvara ?? entity.OpisKvara;

            _mapper.Map(request, entity);
            _context.SaveChanges();

            // Clear existing ServisiranjaDijelovi
            var existingDijelovi = _context.ServisiranjaDijelovi.Where(x => x.ServisiranjeID == id).ToList();
            if (existingDijelovi != null)
            {
                foreach (var item in existingDijelovi)
                {
                    var rezervniDio = _context.RezervniDijelovi.Where(p => p.RezervniDijeloviId == item.RezervniDijeloviID).FirstOrDefault();
                    if (rezervniDio != null)
                    {
                        rezervniDio.NaStanju++;
                    }

                }
                _context.ServisiranjaDijelovi.RemoveRange(existingDijelovi);
            }


            // Add new ServisiranjaDijelovi from request
            foreach (var item in request.RezervniDijelovi)
            {
                //bitno za update vrijednosti naStanju
                var rezervniDio = _context.RezervniDijelovi.Where(x => x.RezervniDijeloviId == item.RezervniDijeloviId).FirstOrDefault();
                if (rezervniDio != null)
                {
                    //rezervniDio.NaStanju = (int)item.NaStanju;  // Update the stock value
                    rezervniDio.NaStanju--;
                }
                var newDio = new ServisiranjaDijelovi
                {
                    RezervniDijeloviID = item.RezervniDijeloviId,
                    ServisiranjeID = id
                };
                _context.ServisiranjaDijelovi.Add(newDio);
            }

            _context.SaveChanges();

            return _mapper.Map<Model.Servisiranja>(entity);
        }

    }
}
