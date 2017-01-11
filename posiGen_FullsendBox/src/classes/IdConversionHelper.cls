public class IdConversionHelper
{
    public static String ID15to18(String inID) {
  if (inID.length() == 18) { return inID; }
  else if (inID.length() != 15) { return ''; }
  else {
    String suffix = '';
    for (Integer i = 0; i < 3; i++) {
      Integer flags = 0;
      for (Integer j = 0; j < 5; j++) {
        String c = inID.substring(i*5+j, i*5+j+1);
        if ( ( c.compareTo('A') >= 0 ) && ( c.compareTo('Z') <= 0 ) ) {
          flags += 1 << j;
        }
      }
      suffix = suffix + 'ABCDEFGHIJKLMNOPQRSTUVWXYZ012345'.substring(flags, flags+1);
    }
    return inID + suffix;
  }
}
}