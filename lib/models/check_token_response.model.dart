class CheckTokenResponse {
  String? message;
  bool? error;
  int? statusCode;
  int? optionalCode;
  CheckTokenData? data;

  CheckTokenResponse(
      {this.message,
        this.error,
        this.statusCode,
        this.optionalCode,
        this.data});

  CheckTokenResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    error = json['error'];
    statusCode = json['statusCode'];
    optionalCode = json['optionalCode'];
    data = json['data'] != null ? CheckTokenData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    data['error'] = error;
    data['statusCode'] = statusCode;
    data['optionalCode'] = optionalCode;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class CheckTokenData {
  AppUserFull? user;

  // AppUserDefault? user;
  ConnectionInfo? connectionInfo;
  DeviceInfo? deviceInfo;
  Options? options;
  Config? config;

  CheckTokenData({this.user, this.connectionInfo,this.config});

  CheckTokenData.fromJson(Map<String, dynamic> json) {
    user = json['user'] != null ? AppUserFull.fromJson(json['user']) : null;
    // user = json['user'] != null ? AppUserDefault.fromJson(json['user']) : null;
    connectionInfo = json['connection_info'] != null
        ? ConnectionInfo.fromJson(json['connection_info'])
        : null;
    deviceInfo = json['device_info'] != null
        ? DeviceInfo.fromJson(json['device_info'])
        : null;
    config = json['config'] != null ? Config.fromJson(json['config']) : null;
  }

  Map<String, dynamic> toJson() {
    print("hittoJsonData");
    final Map<String, dynamic> data = <String, dynamic>{};
    if (user != null) {
      data['user'] = user!.toJson();
    }
    if (connectionInfo != null) {
      data['connection_info'] = connectionInfo!.toJson();
    }
    if (deviceInfo != null) {
      data['device_info'] = deviceInfo!.toJson();
    }
    print("dataOfToJson: ${data.toString()}");
    return data;
  }
}

class ConnectionInfo {
  bool? isConnected;
  Server? server;

  ConnectionInfo({this.isConnected, this.server});

  factory ConnectionInfo.fromJson(Map<String, dynamic> json) {
    return ConnectionInfo(
      isConnected: json['is_connected'],
      server: json['server'] != null ? Server.fromJson(json['server']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['is_connected'] = this.isConnected;
    if (this.server != null) {
      data['server'] = this.server!.toJson();
    }
    return data;
  }
}

class DeviceInfo {
  int? id;
  String? deviceId;
  int? vpnCodeId;
  int? userId;
  int? isActive;
  String? byteIn;
  String? byteOut;
  String? ip;
  String? os;
  String? deviceName;
  String? loginType;
  String? createdAt;
  String? updatedAt;

  DeviceInfo(
      {this.id,
        this.deviceId,
        this.vpnCodeId,
        this.userId,
        this.isActive,
        this.byteIn,
        this.byteOut,
        this.ip,
        this.os,
        this.deviceName,
        this.loginType,
        this.createdAt,
        this.updatedAt});

  DeviceInfo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    deviceId = json['device_id'];
    vpnCodeId = json['vpn_code_id'];
    userId = json['user_id'];
    isActive = json['is_active'];
    byteIn = json['byte_in'];
    byteOut = json['byte_out'];
    ip = json['ip'];
    os = json['os'];
    deviceName = json['device_name'];
    loginType = json['login_type'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['device_id'] = deviceId;
    data['vpn_code_id'] = vpnCodeId;
    data['user_id'] = userId;
    data['is_active'] = isActive;
    data['byte_in'] = byteIn;
    data['byte_out'] = byteOut;
    data['ip'] = ip;
    data['os'] = os;
    data['device_name'] = deviceName;
    data['login_type'] = loginType;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}

class Server {
  int? id;
  String? name;
  String? subTitle;
  int? locationId;
  String? ip;
  String? config;
  dynamic lastPingCheckTime;
  int? isPaid;
  int? isActive;
  int? totalUsed;
  int? ping;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? isOpenGate;
  String? sPort;
  String? vPort;
  int? status;
  dynamic configFile;
  String? configUrl;
  String? location;
  String? locationFlag;
  List<String>? categoryArray;
  String? categories;

  Server({
    this.id,
    this.name,
    this.subTitle,
    this.locationId,
    this.ip,
    this.config,
    this.lastPingCheckTime,
    this.isPaid,
    this.isActive,
    this.totalUsed,
    this.ping,
    this.createdAt,
    this.updatedAt,
    this.isOpenGate,
    this.sPort,
    this.vPort,
    this.status,
    this.configFile,
    this.configUrl,
    this.location,
    this.locationFlag,
    this.categoryArray,
    this.categories,
  });

  factory Server.fromJson(Map<String, dynamic> json) {
    return Server(
      id: json['id'],
      name: json['name'],
      subTitle: json['sub_title'],
      locationId: json['location_id'],
      ip: json['ip'],
      config: json['config'],
      lastPingCheckTime: json['last_ping_check_time'],
      isPaid: json['is_paid'],
      isActive: json['is_active'],
      totalUsed: json['total_used'],
      ping: json['ping'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      isOpenGate: json['is_open_gate'],
      sPort: json['s_port'],
      vPort: json['v_port'],
      status: json['status'],
      configFile: json['config_file'],
      configUrl: json['config_url'],
      location: json['location'],
      locationFlag: json['location_flag'],
      categoryArray: json['category_array'] != null
          ? List<String>.from(json['category_array'])
          : null,
      categories: json['categories'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = this.id;
    data['name'] = this.name;
    data['sub_title'] = this.subTitle;
    data['location_id'] = this.locationId;
    data['ip'] = this.ip;
    data['config'] = this.config;
    data['last_ping_check_time'] = this.lastPingCheckTime;
    data['is_paid'] = this.isPaid;
    data['is_active'] = this.isActive;
    data['total_used'] = this.totalUsed;
    data['ping'] = this.ping;
    data['created_at'] = this.createdAt?.toIso8601String();
    data['updated_at'] = this.updatedAt?.toIso8601String();
    data['is_open_gate'] = this.isOpenGate;
    data['s_port'] = this.sPort;
    data['v_port'] = this.vPort;
    data['status'] = this.status;
    data['config_file'] = this.configFile;
    data['config_url'] = this.configUrl;
    data['location'] = this.location;
    data['location_flag'] = this.locationFlag;
    if (this.categoryArray != null) {
      data['category_array'] = this.categoryArray;
    }
    data['categories'] = this.categories;
    return data;
  }
}

class Options {

  int? connectionTimeInterval;

  Options({this.connectionTimeInterval});

  Options.fromJson(Map<String, dynamic> json) {
    connectionTimeInterval = json['connection_time_interval'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['connection_time_interval'] = this.connectionTimeInterval;
    return data;
  }
}

class GetInfoResponse {
  String? message;
  bool? error;
  int? statusCode;
  int? optionalCode;
  GetInfoData? getInfoData;

  GetInfoResponse(
      {this.message,
        this.error,
        this.statusCode,
        this.optionalCode,
        this.getInfoData});

  GetInfoResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    error = json['error'];
    statusCode = json['statusCode'];
    optionalCode = json['optionalCode'];
    getInfoData =
    json['data'] != null ? GetInfoData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    data['error'] = error;
    data['statusCode'] = statusCode;
    data['optionalCode'] = optionalCode;
    if (getInfoData != null) {
      data['data'] = getInfoData!.toJson();
    }
    return data;
  }
}

class GetInfoData {
  String? token;
  AppUserFull? user;
  Config? config;

  GetInfoData({this.token, this.user, this.config});

  GetInfoData.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    user = json['user'] != null ? AppUserFull.fromJson(json['user']) : null;
    config = json['config'] != null ? Config.fromJson(json['config']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['token'] = token;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    if (config != null) {
      data['config'] = config!.toJson();
    }
    return data;
  }
}

class AppUserFull {
  int? id;
  int? playerId;
  int? roleId;
  String? name;
  String? email;
  String? emailVerifiedAt;
  String? fcmToken;
  String? avatar;
  String? facebookId;
  String? googleId;
  String? ip;
  String? countryCode;
  String? status;
  int? isApiAllowed;
  String? position;
  String? createdAt;
  String? updatedAt;
  String? userAccessKey;
  String? tokenKey;
  String? isLogout;
  int? createForPayment;
  int? isWelcomeEmailSent;
  String? regType;
  String? os;
  String? firebaseId;
  int? isGuest;
  String? deviceId;
  String? deletedAt;
  int? isDeleted;
  String? tokenExpirationTime;
  int? hasChangedPassword;
  int? isCodeUser;
  String? currentAccessKey;
  String? sessionChatKey;
  String? crispSession;
  String? lastConnectedServerId;
  ActivePackage? activePackage;
  ActiveCode? activeCode;
  MyTime? myTime;

  AppUserFull(
      {this.id,
        this.playerId,
        this.roleId,
        this.name,
        this.email,
        this.emailVerifiedAt,
        this.fcmToken,
        this.avatar,
        this.facebookId,
        this.googleId,
        this.ip,
        this.countryCode,
        this.status,
        this.isApiAllowed,
        this.position,
        this.createdAt,
        this.updatedAt,
        this.userAccessKey,
        this.tokenKey,
        this.isLogout,
        this.createForPayment,
        this.isWelcomeEmailSent,
        this.regType,
        this.os,
        this.firebaseId,
        this.isGuest,
        this.deviceId,
        this.deletedAt,
        this.isDeleted,
        this.tokenExpirationTime,
        this.hasChangedPassword,
        this.isCodeUser,
        this.currentAccessKey,
        this.sessionChatKey,
        this.crispSession,
        this.lastConnectedServerId,
        this.activePackage,
        this.activeCode,
        this.myTime});

  AppUserFull.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    playerId = json['player_id'];
    roleId = json['role_id'];
    name = json['name'];
    email = json['email'];
    emailVerifiedAt = json['email_verified_at'];
    fcmToken = json['fcm_token'];
    avatar = json['avatar'];
    facebookId = json['facebook_id'];
    googleId = json['google_id'];
    ip = json['ip'];
    countryCode = json['country_code'];
    status = json['status'];
    isApiAllowed = json['is_api_allowed'];
    position = json['position'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    userAccessKey = json['user_access_key'];
    tokenKey = json['token_key'];
    isLogout = json['is_logout'];
    createForPayment = json['create_for_payment'];
    isWelcomeEmailSent = json['is_welcome_email_sent'];
    regType = json['reg_type'];
    os = json['os'];
    firebaseId = json['firebase_id'];
    isGuest = json['is_guest'];
    deviceId = json['device_id'];
    deletedAt = json['deleted_at'];
    isDeleted = json['is_deleted'];
    tokenExpirationTime = json['token_expiration_time'];
    hasChangedPassword = json['has_changed_password'];
    isCodeUser = json['is_code_user'];
    currentAccessKey = json['current_access_key'];
    sessionChatKey = json['session_chat_key'];
    crispSession = json['crisp_session'];
    lastConnectedServerId = json['last_connected_server_id'];
    activePackage = json['activePackage'] != null
        ? ActivePackage.fromJson(json['activePackage'])
        : null;
    activeCode = json['activeCode'] != null
        ? ActiveCode.fromJson(json['activeCode'])
        : null;
    myTime = json['my_time'] != null ? MyTime.fromJson(json['my_time']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['player_id'] = playerId;
    data['role_id'] = roleId;
    data['name'] = name;
    data['email'] = email;
    data['email_verified_at'] = emailVerifiedAt;
    data['fcm_token'] = fcmToken;
    data['avatar'] = avatar;
    data['facebook_id'] = facebookId;
    data['google_id'] = googleId;
    data['ip'] = ip;
    data['country_code'] = countryCode;
    data['status'] = status;
    data['is_api_allowed'] = isApiAllowed;
    data['position'] = position;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['user_access_key'] = userAccessKey;
    data['token_key'] = tokenKey;
    data['is_logout'] = isLogout;
    data['create_for_payment'] = createForPayment;
    data['is_welcome_email_sent'] = isWelcomeEmailSent;
    data['reg_type'] = regType;
    data['os'] = os;
    data['firebase_id'] = firebaseId;
    data['is_guest'] = isGuest;
    data['device_id'] = deviceId;
    data['deleted_at'] = deletedAt;
    data['is_deleted'] = isDeleted;
    data['token_expiration_time'] = tokenExpirationTime;
    data['has_changed_password'] = hasChangedPassword;
    data['is_code_user'] = isCodeUser;
    data['current_access_key'] = currentAccessKey;
    data['session_chat_key'] = sessionChatKey;
    data['crisp_session'] = crispSession;
    data['last_connected_server_id'] = lastConnectedServerId;
    if (activePackage != null) {
      data['activePackage'] = activePackage!.toJson();
    }
    if (activeCode != null) {
      data['activeCode'] = activeCode!.toJson();
    }
    if (myTime != null) {
      data['my_time'] = myTime!.toJson();
    }
    return data;
  }
}

class ActivePackage {
  int? id;
  String? name;
  String? packageId;
  String? productId;
  String? productPriceId;
  double? basePrice;
  double? price;
  int? packageType;
  num? discount;
  String? discountType;
  double? totalDiscount;
  int? isSubscription;
  String? reccurringType;
  int? reccurringInterval;
  String? createdAt;
  String? updatedAt;
  String? icon;
  int? isActive;
  String? deletedAt;
  String? monthlySave;
  int? isFreeTrial;
  int? isPopular;
  int? order;
  String? title;
  String? subTitle;
  String? titleData;
  String? descriptionText;
  String? promoText;
  List<String>? feature;
  double? finalPrice;
  double? saved;
  String? savePercent;
  String? showMonthlyPrice;
  String? showMonthlyText;
  String? packageSubscription;
  String? packageSubscriptionType;
  String? packageSubscriptionInterval;
  String? type;

  ActivePackage(
      {this.id,
        this.name,
        this.packageId,
        this.productId,
        this.productPriceId,
        this.basePrice,
        this.price,
        this.packageType,
        this.discount,
        this.discountType,
        this.totalDiscount,
        this.isSubscription,
        this.reccurringType,
        this.reccurringInterval,
        this.createdAt,
        this.updatedAt,
        this.icon,
        this.isActive,
        this.deletedAt,
        this.monthlySave,
        this.isFreeTrial,
        this.isPopular,
        this.order,
        this.title,
        this.subTitle,
        this.titleData,
        this.descriptionText,
        this.promoText,
        this.feature,
        this.finalPrice,
        this.saved,
        this.savePercent,
        this.showMonthlyPrice,
        this.showMonthlyText,
        this.packageSubscription,
        this.packageSubscriptionType,
        this.packageSubscriptionInterval,
        this.type});

  ActivePackage.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    packageId = json['package_id'];
    productId = json['product_id'];
    productPriceId = json['product_price_id'];
    basePrice = double.parse(json['base_price'].toString());
    price = json['price'];
    packageType = json['package_type'];
    discount = json['discount'];
    discountType = json['discount_type'];
    totalDiscount = json['total_discount'];
    isSubscription = json['is_subscription'];
    reccurringType = json['reccurring_type'];
    reccurringInterval = json['reccurring_interval'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    icon = json['icon'];
    isActive = json['is_active'];
    deletedAt = json['deleted_at'];
    monthlySave = json['monthly_save'];
    isFreeTrial = json['is_free_trial'];
    isPopular = json['is_popular'];
    order = json['order'];
    title = json['title'];
    subTitle = json['sub_title'];
    titleData = json['title_data'];
    descriptionText = json['description_text'];
    promoText = json['promo_text'];
    feature = json['feature'].cast<String>();
    finalPrice = json['finalPrice'];
    saved = json['saved'];
    savePercent = json['save_percent'];
    showMonthlyPrice = json['show_monthly_price'];
    showMonthlyText = json['show_monthly_text'];
    packageSubscription = json['package_subscription'];
    packageSubscriptionType = json['package_subscription_type'];
    packageSubscriptionInterval = json['package_subscription_interval'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['package_id'] = this.packageId;
    data['product_id'] = this.productId;
    data['product_price_id'] = this.productPriceId;
    data['base_price'] = this.basePrice;
    data['price'] = this.price;
    data['package_type'] = this.packageType;
    data['discount'] = this.discount;
    data['discount_type'] = this.discountType;
    data['total_discount'] = this.totalDiscount;
    data['is_subscription'] = this.isSubscription;
    data['reccurring_type'] = this.reccurringType;
    data['reccurring_interval'] = this.reccurringInterval;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['icon'] = this.icon;
    data['is_active'] = this.isActive;
    data['deleted_at'] = this.deletedAt;
    data['monthly_save'] = this.monthlySave;
    data['is_free_trial'] = this.isFreeTrial;
    data['is_popular'] = this.isPopular;
    data['order'] = this.order;
    data['title'] = this.title;
    data['sub_title'] = this.subTitle;
    data['title_data'] = this.titleData;
    data['description_text'] = this.descriptionText;
    data['promo_text'] = this.promoText;
    data['feature'] = this.feature;
    data['finalPrice'] = this.finalPrice;
    data['saved'] = this.saved;
    data['save_percent'] = this.savePercent;
    data['show_monthly_price'] = this.showMonthlyPrice;
    data['show_monthly_text'] = this.showMonthlyText;
    data['package_subscription'] = this.packageSubscription;
    data['package_subscription_type'] = this.packageSubscriptionType;
    data['package_subscription_interval'] = this.packageSubscriptionInterval;
    data['type'] = this.type;
    return data;
  }
}

class ActiveCode {
  int? id;
  int? userId;
  int? packageId;
  String? code;
  int? isActive;
  String? deviceId;
  String? subscriptionId;
  int? isCustom;
  String? platform;
  int? isUsed;
  String? validatedAt;
  String? createdAt;
  int? totalUsage;
  String? price;
  String? store;
  int? isTest;
  double? buyPrice;
  String? paymentType;
  String? webhookUpdate;
  int? subscriptionEnabled;
  int? appSumoStatus;
  int? status;
  int? isTrial;
  int? isCustomSubscription;
  String? email;
  String? purchaseFrom;

  ActiveCode(
      {this.id,
        this.userId,
        this.packageId,
        this.code,
        this.isActive,
        this.deviceId,
        this.subscriptionId,
        this.isCustom,
        this.platform,
        this.isUsed,
        this.validatedAt,
        this.createdAt,
        this.totalUsage,
        this.price,
        this.store,
        this.isTest,
        this.buyPrice,
        this.paymentType,
        this.webhookUpdate,
        this.subscriptionEnabled,
        this.appSumoStatus,
        this.status,
        this.isTrial,
        this.isCustomSubscription,
        this.email,
        this.purchaseFrom});

  ActiveCode.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    packageId = json['package_id'];
    code = json['code'];
    isActive = json['is_active'];
    deviceId = json['device_id'];
    subscriptionId = json['subscription_id'];
    isCustom = json['is_custom'];
    platform = json['platform'];
    isUsed = json['is_used'];
    validatedAt = json['validated_at'];
    createdAt = json['created_at'] != null ? json['created_at'] : null;
    totalUsage = json['total_usage'];
    price = json['price'];
    store = json['store'];
    isTest = json['is_test'];
    buyPrice = double.parse(json['buy_price'].toString());
    paymentType = json['payment_type'];
    webhookUpdate = json['webhook_update'];
    subscriptionEnabled = json['subscription_enabled'];
    appSumoStatus = json['app_sumo_status'];
    status = json['status'];
    isTrial = json['is_trial'];
    isCustomSubscription = json['is_custom_subscription'];
    email = json['email'];
    purchaseFrom = json['purchase_from'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user_id'] = userId;
    data['package_id'] = packageId;
    data['code'] = code;
    data['is_active'] = isActive;
    data['device_id'] = deviceId;
    data['subscription_id'] = subscriptionId;
    data['is_custom'] = isCustom;
    data['platform'] = platform;
    data['is_used'] = isUsed;
    data['validated_at'] = validatedAt;
    data['created_at'] = createdAt;
    data['total_usage'] = totalUsage;
    data['price'] = price;
    data['store'] = store;
    data['is_test'] = isTest;
    data['buy_price'] = buyPrice;
    data['payment_type'] = paymentType;
    data['webhook_update'] = webhookUpdate;
    data['subscription_enabled'] = subscriptionEnabled;
    data['app_sumo_status'] = appSumoStatus;
    data['status'] = status;
    data['is_trial'] = isTrial;
    data['is_custom_subscription'] = isCustomSubscription;
    data['email'] = email;
    data['purchase_from'] = purchaseFrom;
    return data;
  }
}

class MyTime {
  int? id;
  int? userId;
  int? time;
  int? usedTime;
  int? total;
  String? createdAt;
  String? updatedAt;
  String? firstAdSeenAt;
  String? appFirstAdTime;

  MyTime(
      {this.id,
        this.userId,
        this.time,
        this.usedTime,
        this.total,
        this.createdAt,
        this.updatedAt,
        this.firstAdSeenAt,
        this.appFirstAdTime});

  MyTime.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    time = json['time'];
    usedTime = json['used_time'];
    total = json['total'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    firstAdSeenAt = json['first_ad_seen_at'];
    appFirstAdTime = json['app_first_ad_time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['time'] = this.time;
    data['used_time'] = this.usedTime;
    data['total'] = this.total;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['first_ad_seen_at'] = this.firstAdSeenAt;
    data['app_first_ad_time'] = this.appFirstAdTime;
    return data;
  }
}

class Config {
  int? adTryTotalSeconds;
  int? adTryAttempts;
  String? adTitle;
  String? adSubTitle;


  Config({
    this.adTryTotalSeconds,
    this.adTryAttempts,
    this.adTitle,
    this.adSubTitle,
  });

  factory Config.fromJson(Map<String, dynamic> json) {
    return Config(
      adTryTotalSeconds: json['ad_try_total_seconds'] ?? '',
      adTryAttempts: json['ad_try_attempts'] ?? '',
      adTitle: json['ad_title'] ?? '',
      adSubTitle: json['ad_sub_title'] ?? '',
    );
  }


  Map<String, dynamic> toJson() {
    return {
      'ad_try_total_seconds': adTryTotalSeconds,
      'ad_try_attempts': adTryAttempts,
      'ad_title': adTitle,
      'ad_sub_title': adSubTitle,
    };
  }
}
