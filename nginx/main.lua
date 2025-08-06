local opts = {
    ssl_verify = "no",
    redirect_uri = "http://localhost/redirect_uri",
    discovery = "https://sso-test.exodushk.com/.well-known/openid-configuration",
    client_id = "headlamp-default-test",
    client_secret = "d1515790ce6d0a31f3a2",
    refresh_session_interval = 3600,
    access_token_expires_in = 3600,
    session_contents = {
        id_token = true,
        user = true,
    },
}

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
