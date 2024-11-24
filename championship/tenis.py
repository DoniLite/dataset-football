import enum


class OfficialSites(str, enum):
    APT_TOUR = "https://www.atptour.com"
    WTA_TOUR = "https://www.wtatennis.com"
    GRAND_SLAM = {
            "Wimbledon": "https://www.wimbledon.com",
            "Roland-Garros": "https://www.rolandgarros.com",
            "US Open": "https://www.usopen.org",
            "Australian Open": "https://www.ausopen.com"
        }