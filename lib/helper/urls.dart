String logoutUserUrl() => '/auth/token/token/logout/';
String usersMeUrl() => '/auth/users/me/';
String createSaleUrl() => '/v1/sale/sale/';
String deleteSaleUrl(String saleId) => '/v1/sale/sale/$saleId/';
String productAddToBasketUrl() => '/v1/sale/sale_product/';
String removeProductFromBasketUrl(String saleProductId) =>
    '/v1/sale/sale_product/$saleProductId/';
