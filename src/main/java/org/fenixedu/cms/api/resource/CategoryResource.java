package org.fenixedu.cms.api.resource;

import static org.fenixedu.cms.domain.PermissionEvaluation.ensureCanDoThis;
import static org.fenixedu.cms.domain.PermissionsArray.Permission.DELETE_CATEGORY;
import static org.fenixedu.cms.domain.PermissionsArray.Permission.EDIT_CATEGORY;
import static org.fenixedu.cms.domain.PermissionsArray.Permission.LIST_CATEGORIES;

import javax.ws.rs.Consumes;
import javax.ws.rs.DELETE;
import javax.ws.rs.GET;
import javax.ws.rs.PUT;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;
import javax.ws.rs.Produces;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;

import org.fenixedu.bennu.core.rest.BennuRestResource;
import org.fenixedu.cms.api.json.CategoryAdapter;
import org.fenixedu.cms.domain.Category;

@Path("/cms/categories")
public class CategoryResource extends BennuRestResource {

    //TODO: check permissions in all methods

    @GET
    @Produces(MediaType.APPLICATION_JSON)
    @Path("/{oid}")
    public String getCategory(@PathParam("oid") Category category) {
        return view(category, CategoryAdapter.class);
    }

    @PUT
    @Consumes(MediaType.APPLICATION_JSON)
    @Produces(MediaType.APPLICATION_JSON)
    @Path("/{oid}")
    public String updateCategory(@PathParam("oid") Category category, String json) {
        return updateCategoryFromJson(category, json);
    }

    private String updateCategoryFromJson(Category category, String json) {
        return view(update(json, category, CategoryAdapter.class));
    }

    @DELETE
    @Produces(MediaType.APPLICATION_JSON)
    @Path("/{oid}")
    public Response deleteCategory(@PathParam("oid") Category category) {
        ensureCanDoThis(category.getSite(), LIST_CATEGORIES, EDIT_CATEGORY, DELETE_CATEGORY);
        category.delete();
        return Response.ok().build();
    }
}