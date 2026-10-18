public class GoogelDriveConnector extends CloudeConnector {
    public override void connect()
    {
      System.debug('Using Googlr Drive QAUTH2 to Authenticate Creds');  
    }
	
    public override void uploadFile(String fileName){
      System.debug('Uploading '+fileName+' to Google Drive');

    }
}