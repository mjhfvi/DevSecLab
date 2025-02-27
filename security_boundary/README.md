# boundary configuration file
# build a DB in postgres "boundary database init -config=config.hcl"
# CREATE DATABASE boundary WITH OWNER = adminuser ENCODING = 'UTF8' LOCALE_PROVIDER = 'libc' CONNECTION LIMIT = -1 IS_TEMPLATE = False;
# run boundary server "boundary server -config=config.hcl"
# get login information from "Initial login role information:"

# build token access "boundary config get-token"
# set token in environment variables "export BOUNDARY_TOKEN="
# run command "boundary authenticate password -auth-method-id ampw_yu3xMR2Jbj -login-name admin -keyring-type=none"
# get controller_generated_activation_token for worker ""
# list all targets
boundary targets list -scope-id=p_SmAB61QmKU


export BOUNDARY_ADDR="http://localhost:9200"
export BOUNDARY_TOKEN=
export BOUNDARY_AUTH_METHOD_ID="ampw_yu3xMR2Jbj"
export BOUNDARY_AUTHENTICATE_PASSWORD_PASSWORD=
export BOUNDARY_AUTHENTICATE_PASSWORD_LOGIN_NAME=

# testing my co
boundary targets list -scope-id=p_e4a1Sl678g -token file://token.hcl
boundary targets list -scope-id=p_e4a1Sl678g -token env://BOUNDARY_TOKEN

Initial auth information:
  Auth Method ID:     ampw_yu3xMR2Jbj
  Auth Method Name:   Generated global scope initial password auth method
  Login Name:         admin
  Password:           Zvg3zQUJig2y4gaGDOt7
  Scope ID:           global
  User ID:            u_c3Ky2oij3Z
  User Name:          admin

Authentication information:
  Account ID:      acctpw_v3Y9cQS6NH
  Auth Method ID:  ampw_yu3xMR2Jbj
  Expiration Time: Wed, 27 Nov 2024 18:47:56 IST
  User ID:         u_c3Ky2oij3Z

Authentication information:
  Account ID:      acctpw_v3Y9cQS6NH
  Auth Method ID:  ampw_yu3xMR2Jbj
  Expiration Time: Tue, 26 Nov 2024 18:51:04 IST
  User ID:         u_c3Ky2oij3Z
Error opening "pass" keyring: Specified keyring backend not available
The token was not successfully saved to a system keyring. The token is:

at_h3DDnmVRnP_s1QEoNuHZDWhJYdXigZ53HJYeU6pbruEg3pY9m8hLJ7qWQhNqjPDaHLyLPCEfYS6vr4G3aq85juHNJB8XTS2u9NCKSp8JAMzZMjKRzPp1dZByzWA7QJiUghu7YcUrXHWfYVxxjr47X

It must be manually passed in via the BOUNDARY_TOKEN env var or -token flag. Storing the token can also be disabled via -keyring-type=none.

boundary scopes create -scope-id=global -name=HomeLab -description="Home Lab For Testing"
# get id

# add project
boundary scopes create -scope-id=o_dGW5shh7a0 -name=HomeProject -description="Manage Home Lab Machines"
# get project
export PROJECT_ID=p_SmAB61QmKU

# add auth-methods
boundary auth-methods create password -scope-id=o_dGW5shh7a0 -name="org_auth_method" -description="Org auth method"
# get auth id
export BOUNDARY_AUTH_METHOD_ID=ampw_I4TeYUDD5t

# add host catalogs
boundary host-catalogs create static -scope-id=p_SmAB61QmKU -name=DevOps -description="For DevOps usage"
# get id
export HOST_CATALOG_ID=hcst_3yRDyCkbFV

# add host-catalogs
boundary hosts create static -name=postgres -description="Postgres host" -address="192.168.50.50" -host-catalog-id=hcst_3yRDyCkbFV

boundary hosts create static -name=localhost -description="Localhost for testing" -address="localhost" -host-catalog-id=hcst_3yRDyCkbFV

boundary host-sets create static -name="test-machines" -description="Test machine host set" -host-catalog-id=$HOST_CATALOG_ID
export HOST_SET_ID=hsst_tEIMvL00Gr

boundary hosts list -host-catalog-id=$HOST_CATALOG_ID

boundary host-sets add-hosts -id=$HOST_SET_ID -host=hst_YIXrHtEWex -host=hst_6BgfAiK4C3

boundary targets create tcp -name="postgres" -description="Postgres target" -default-port=5432 -scope-id=$PROJECT_ID -session-connection-limit="-1"
# get target id
export TARGET_ID=ttcp_oCQqZdXPPq

boundary targets add-host-sources -id=$TARGET_ID -host-source=$HOST_SET_ID

boundary sessions list -scope-id=$PROJECT_ID
boundary sessions read -id s_DAUsAegvCo

boundary authenticate password -auth-method-id ampw_yu3xMR2Jbj
boundary authenticate password -auth-method-id ampw_yu3xMR2Jbj -login-name admin
boundary authenticate password -login-name admin -token=file://token.hcl
boundary authenticate password -auth-method-id ampw_1234567890 -login-name foo
boundary authenticate password -scope-id global -auth-method-id ampw_yu3xMR2Jbj
boundary connect postgres db -token=file:///token.hcl

boundary auth-methods create password -recovery-config /tmp/recovery.hcl -scope-id <org_scope_id> -name 'my_method' -description 'My password auth method'
boundary accounts create password -recovery-config /tmp/recovery.hcl -login-name "admin" -auth-method-id <auth_method_id_from_last_step>
boundary accounts create password -auth-method-id=ampw_1234567890 -login-name="user" -name=test_account -description="Test password account"
boundary users create <truncated> -recovery-config /tmp/recovery.hcl

boundary targets list -scope-id=p_e4a1Sl678g -token env://BOUNDARY_TOKEN
boundary connect -scope-id=p_e4a1Sl678g -target-id=ttcp_5KXajBrREv -token=env://BOUNDARY_TOKEN
boundary targets authorize-session -id=acctpw_v3Y9cQS6NH
boundary targets authorize-session -id=ttcp_pmqFSzOHyr
boundary roles add-grants -id=ttcp_0kRjiQ797n -grant="id=hcst_9kF4FooBar;type=*;actions=create,delete,list,update"
