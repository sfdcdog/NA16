public class awsAmazonS3 {

    public static String formattedDateString = Datetime.now().formatGMT('EEE, dd MMM yyyy HH:mm:ss z'); 
    public static String key = System.Label.AWS_Key;
    public static String secret = System.Label.AWS_Secret;
    public static String bucketname = 'sfdcattcmnts';
    public static String host = 's3-ap-northeast-1.amazonaws.com';
    public static String putfilename = 'testo';



    public static void upldToAmazonS3() {
        Document attach = [SELECT Body, ContentType, Name, developername FROM Document LIMIT 1];
        
        //Setting values for url parameters for creating the EndPoint.
        String attachmentBody = attach.Body.tostring();//EncodingUtil.base64Encode(attach.Body)
        String method = 'PUT';


        //Creating the HTTP Request 
        HttpRequest req = new HttpRequest();
        req.setMethod(method);
        req.setEndpoint('https://'+ host + '/' + bucketname + '/' + putfilename);
        req.setTimeout(2 * 60 * 1000);
        req.setHeader('Host', bucketname + '.' + host);
        req.setHeader('Content-Length', String.valueOf(attachmentBody.length()));
        req.setHeader('Content-Encoding', 'txt');
        req.setHeader('Content-type', attach.ContentType);
        req.setHeader('Connection', 'keep-alive');
        req.setHeader('Date', formattedDateString);
        req.setHeader('ACL', 'public-read');
        req.setBody(attachmentBody);
        req.setHeader('Authorization', createAuthHeader(method, putfilename, formattedDateString, bucketname, key, secret));
        //String decoded = EncodingUtil.urlDecode(encodedStringToSign, 'UTF-8');
        system.debug('#######' + req);

        try {
            Http http = new Http();
            HTTPResponse res = http.send(req);
            System.debug('*Resp:' + String.ValueOF(res.getBody()));
            System.debug('RESPONSE STRING: ' + res.toString());
            System.debug('RESPONSE STATUS: ' + res.getStatus());
            System.debug('STATUS_CODE: ' + res.getStatusCode());
        } catch (Exception e) {
            system.debug('Callout Exception occured: ' + e);
        }

    }

    
    public static string createAuthHeader(String method, String filename, String formattedDate, String bucket, String awskey, String awssecret) {
        string auth;
        String stringToSign;
        String ContentType = 'text/plain';
        if(method == 'PUT'){
            stringToSign = method +'\n\n' +
            ContentType + '\n' +
            formattedDate + '\n' +
            '/' + bucketname + '/' + bucketname + '/' + filename;
    
        }else if(method == 'GET'){
            stringToSign = method + '\n\n\n' + formattedDate + '\n/' + bucket + '/' + filename;   
        }
        system.debug('#####ss'+stringToSign);
        Blob mac = Crypto.generateMac('HMACSHA1', blob.valueof(stringToSign), blob.valueof(awssecret));
        String sig = EncodingUtil.base64Encode(mac);
        auth = 'AWS' + ' ' + awskey + ':' + sig;
        return auth;

    }
    
    public static void FileDownLoad() {
        String method = 'GET';
        String getfilename = '21276-bleach-ichigo-hollow-chaos-wallpaper.jpg';
        HttpRequest req = new HttpRequest();
        req.setMethod(method);
        req.setHeader('Date', formattedDateString);
        req.setHeader('Authorization', createAuthHeader(method, getfilename, formattedDateString, bucketname, key, secret));
        req.setTimeout(2 * 60 * 1000);
        Set < String > getParams = new Set < String > {
            'prefix=' + EncodingUtil.urlEncode(getfilename + '/', 'UTF-8'),
            'delimiter=' + EncodingUtil.urlEncode('/', 'UTF-8')
        };

        String endpointBase = 'https://'+ host + '/' +bucketname+'/'+ getfilename;

        req.setEndpoint(endpointBase);

        system.debug('######'+req);

        try {
            Http http = new Http();
            HTTPResponse res = http.send(req);
            System.debug('*Resp:' + String.ValueOF(res.getBody()));
            System.debug('RESPONSE STRING: ' + res.toString());
            System.debug('RESPONSE STATUS: ' + res.getStatus());
            System.debug('STATUS_CODE: ' + res.getStatusCode());
        } catch (Exception e) {
            system.debug('Callout Exception occured: ' + e);
        }
    }

    

}