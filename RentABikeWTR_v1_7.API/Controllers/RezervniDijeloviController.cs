using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using RentABikeWTR_v1_7.Model.Requests;
using RentABikeWTR_v1_7.Services;

namespace RentABikeWTR_v1_7.API.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class RezervniDijeloviController : BaseCRUDController<Model.RezervniDijelovi, RezervniDijeloviSearchRequest, RezervniDijeloviUpsertRequest, RezervniDijeloviUpsertRequest>
    {
        public RezervniDijeloviController(ICRUDService<Model.RezervniDijelovi, RezervniDijeloviSearchRequest, RezervniDijeloviUpsertRequest, RezervniDijeloviUpsertRequest> service) : base(service)
        {
        }
    }
}
