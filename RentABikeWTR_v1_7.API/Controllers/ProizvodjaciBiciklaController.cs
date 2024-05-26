using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using RentABikeWTR_v1_7.Model.Requests;
using RentABikeWTR_v1_7.Services;

namespace RentABikeWTR_v1_7.API.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class ProizvodjaciBiciklaController : BaseCRUDController<Model.ProizvodjaciBicikla, ProizvodjaciBiciklaSearchRequest, ProizvodjaciBiciklaUpsertRequest, ProizvodjaciBiciklaUpsertRequest>
    {
        public ProizvodjaciBiciklaController(ICRUDService<Model.ProizvodjaciBicikla, ProizvodjaciBiciklaSearchRequest, ProizvodjaciBiciklaUpsertRequest, ProizvodjaciBiciklaUpsertRequest> service) : base(service)
        {
        }
    }
}
