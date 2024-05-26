using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using RentABikeWTR_v1_7.Model.Requests;
using RentABikeWTR_v1_7.Services;

namespace RentABikeWTR_v1_7.API.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class PoziviDezurnomVoziluController : BaseCRUDController<Model.PoziviDezurnomVozilu, PoziviDezurnomVoziluSearchRequest, PoziviDezurnomVoziluUpsertRequest, PoziviDezurnomVoziluUpsertRequest>
    {
        public PoziviDezurnomVoziluController(ICRUDService<Model.PoziviDezurnomVozilu, PoziviDezurnomVoziluSearchRequest, PoziviDezurnomVoziluUpsertRequest, PoziviDezurnomVoziluUpsertRequest> service) : base(service)
        {
        }
    }
}
