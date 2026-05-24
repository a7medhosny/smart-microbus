import 'session_manager.dart';

enum GuestFeature {
  submitReport,

  addFavourite,

  profile,

  removeFavourite,

  getFavouriteRoutes,

  getAllReports,

  getReportById,

  updateReport,

  deleteReport,

  routeFavourite,

  liveLocation,
}

class GuestGuard {
  static bool canAccess(GuestFeature feature) {
    if (!SessionManager.isGuest) {
      return true;
    }

    switch (feature) {
      case GuestFeature.submitReport:
      case GuestFeature.addFavourite:
      case GuestFeature.removeFavourite:
      case GuestFeature.getFavouriteRoutes:
      case GuestFeature.getAllReports:
      case GuestFeature.getReportById:
      case GuestFeature.updateReport:
      case GuestFeature.deleteReport:
      case GuestFeature.routeFavourite:
      case GuestFeature.liveLocation:
      case GuestFeature.profile:
        return false;
    }
  }
}
