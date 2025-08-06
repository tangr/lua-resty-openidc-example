local opts = {
    ssl_verify = ngx.var.oidc_ssl_verify,
    redirect_uri = ngx.var.oidc_redirect_uri,
    discovery = ngx.var.oidc_discovery_url,
    client_id = ngx.var.oidc_client_id,
    client_secret = ngx.var.oidc_client_secret,
    refresh_session_interval = ngx.var.oidc_refresh_session_interval,
    access_token_expires_in = ngx.var.oidc_access_token_expires_in,
    session_contents = {
        id_token = true,
        user = true,
    },
}

-- ngx.log(ngx.ERR, "openidc.authenticate opts: ", require("cjson").encode(opts))

local openidc = require("resty.openidc")
openidc.set_logging(nil, { DEBUG = ngx.DEBUG })
local res, err = openidc.authenticate(opts)
-- ngx.log(ngx.ERR, "openidc.authenticate res: ", require("cjson").encode(res))

if err then
    ngx.log(ngx.ERR, err)
    ngx.exit(ngx.HTTP_INTERNAL_SERVER_ERROR)
end
ngx.req.set_header("X-USER", res.id_token.sub)

ngx.var.pass="http://127.0.0.1:3000"
