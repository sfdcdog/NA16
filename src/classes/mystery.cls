public class mystery{

    public String MysteryMethod1(String str) {
    if ((null == str) || (str.length()  <= 1)) {
        return str;
    }
    return MysteryMethod1(str.substring(1)) + str.charAt(0);
}
}