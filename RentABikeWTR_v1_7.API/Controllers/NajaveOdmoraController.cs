using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using RentABikeWTR_v1_7.Model.Requests;
using RentABikeWTR_v1_7.Services;

namespace RentABikeWTR_v1_7.API.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class NajaveOdmoraController : BaseCRUDController<Model.NajaveOdmora, NajaveOdmoraSearchRequest, NajaveOdmoraUpsertRequest, NajaveOdmoraUpsertRequest>
    {
        public NajaveOdmoraController(ICRUDService<Model.NajaveOdmora, NajaveOdmoraSearchRequest, NajaveOdmoraUpsertRequest, NajaveOdmoraUpsertRequest> service) : base(service)
        {
        }
    }
}
