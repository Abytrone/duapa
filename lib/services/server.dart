const String protocol = 'https://';

//------------SERVER DOMAIN-------------------------
const String baseUrl = 'con.duapa.online';

//------------AUTH-ROUTES-----------------------
const String signupRoute = '/api/v1/auth/register';
const String loginRoute = '/api/v1/auth/login';
const String edituser = '/api/v1/auth/users/profile-update';
const String questionsRoute = '/api/v1/auth/secret-questions';
const String ansRoute = '/api/v1/auth/users/set-answers';
const String qaRoute = '/api/v1/auth/users/secret-questions';
const String farmerRoute = '/api/v1/users/auth-user';
const String companyRoute = '/api/v1/farmer/auth-company';
const String governmentRoute = '/api/v1/extension_officers/list';
const String driversRoute = '/api/v1/drivers/list';
const String coporateGroupsRoute = '/api/v1/corporative_groups/list';
const String createcoporateGroupRoute = '/api/v1/corporative_groups/create';
const String joincoporateGroupRoute = '/api/v1/farmer/join-group';
//------------FARMERS-ROUTES-----------------------
const String farmersRoute = '/api/v1/farmers';

//------------COMPANIES-ROUTES-----------------------
const String companiesRoute = '/api/v1/companies';

//------------PRODUCTS-ROUTES-----------------------
const String productsRoute = '/api/v1/product/list';
const String createProductRoute = '/api/v1/product/create';
const String catRoute = '/api/v1/product/categories/list';
const String productByCat = '/api/v1/product/list/category';
const String categoryRoute =
    'https://con.duapa.online/api/v1/product/categories/list'; // for dio package

//------------Farms-ROUTES-------------------------
const String addFarmRoute = '/api/v1/farmer/farm/add';
const String farmsRoute = '/api/v1/farmer/farm/list';

//------------POSTS-ROUTES-------------------------
const String postsRoute = '/api/v1/post/list';
const String commentRoute = '/api/v1/post/comments';
const String likeRoute = '/api/v1/post/like';

const String galleryRoute = '/api/v1/gallery/list';
const String adsRoute = '/api/v1/gallery/list/animations';
const String videosRoute = '/api/v1/video/list';

//------------LOGOUT-ROUTES-----------------------
const String logoutRoute = '/api/v1/logout';

//------------FIDELITY-API------------------------

// Customer Key
const String fidelityCustomerKey = '397b497b-e955-4710-b11c-8a4803a8d5b5';

// Consumer Secret
const String fidelityConsumerSecret = 'e3ab4d08-6ba7-4c53-a0c8-e1f115ed2d96';

// Access Token
const String fidelityAccessToken =
    'eyJhbGciOiJFZERTQSIsImtpZCI6ImZBNEdnUzE4X3VCOGJ6OS1ncVQ5NUFKV2ZrOHJlVGI0SjBtaGZ4RHpHT0EifQ.eyJsYW5ndWFnZSI6eyJsYW5ndWFnZUlkIjoiMSIsImlzbzJDb2RlIjoiZW4iLCJuYW1lIjoiRW5nbGlzaCIsImxvY2FsZSI6ImVuX0dCIn0sImNoZWNrU2Vzc2lvbiI6ZmFsc2UsInR5cCI6IkJlYXJlciIsInNlcyI6IkQyMDlDNTI3LUM3MEYtNDc5Qi1CRDk1LTY2NUVCMUZCOEY5RiIsInBlciI6IkFBSUFCRkFBalFJQURnQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFCQUFBQUFBQUFBQUFRQUFBRUFCQUFBRE1BZ0VBQUFBQUFBQUFnQUFBQUFBQUFTQUJRQUFBQUR3QndBQUJRQVFBQUNBQWdRQUlBQUFBQkFJQUFBQUFQd3ZCWDRBQUFBQUFBQUFvRUFRRWtnQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQT09IiwiaWF0IjoxNjg4MDM1ODAzLCJzdWIiOiIxMjY0IiwiaXNzIjoidXQtbG9naW4iLCJhdWQiOiJ1dC1idXMiLCJleHAiOjE2ODgwMzY3MDN9.4m_phjkPOaxjumJUQeGjlOEdRykSCQ-gkdBAN5ChIz-UrrKBG1jDGC6YplEOr593kXYrWZnL4ckGI98YF-5bDg';
