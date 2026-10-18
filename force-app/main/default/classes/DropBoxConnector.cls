public class DropBoxConnector extends CloudeConnector {
     public override void connect()
    {
      System.debug('Using Dropbox JWT to Authenticate Creds');
   }
	 public override void uploadFile(String fileName){
      System.debug('Uploading '+fileName+' to Google Drive');
    }
}