public class ParkLocator {

    public static String[] country(String country) {
        ParkService.ParksImplPort parksinCountry = new ParkService.ParksImplPort();
        String[] parks = parksinCountry.byCountry(country);
        system.debug(parks);
        return parks;
    }

}