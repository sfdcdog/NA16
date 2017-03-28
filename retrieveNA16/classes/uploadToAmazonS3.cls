public class uploadToAmazonS3 {

    /*public void uploadToAmazonS3 (Attachment attach, String folderName) {
     
        String filename = folderName+'/' + attach.Name;
        String attachmentBody = EncodingUtil.base64Encode(attach.Body);
        String formattedDateString = DateTime.now().formatGMT('EEE, dd MMM yyyy HH:mm:ss z');
        String bucketname = '';//you can write the bucket name where files should be uploaded
        String host = '';//aws server base url
         
        HttpRequest req = new HttpRequest();
        req.setMethod('PUT');
        req.setEndpoint('https://' + bucketname + '.' + host + '/' + filename);
        req.setHeader('Host', bucketname + '.' + host);
        req.setHeader('Content-Length', String.valueOf(attachmentBody.length()));
        req.setHeader('Content-Type', attach.ContentType);
        req.setHeader('Connection', 'keep-alive');
        req.setHeader('Date', formattedDateString);
        req.setHeader('ACL', 'public-read-write');
        Blob blobBody = EncodingUtil.base64Decode(attachmentBody);
        req.setBodyAsBlob(blobBody);
    }*/

    public static void uploadAmazonS3() {
        Document attach = [
            select Body,
            ContentType,
            Name,developername
            from Document
            limit 1
        ];
        system.debug('#####'+attach.developername);
        String attachmentBody = attach.Body.tostring();//EncodingUtil.base64Encode(attach.Body)
        system.debug('#####'+attach.Body.tostring());
        String formattedDateString = Datetime.now().formatGMT('EEE, dd MMM yyyy HH:mm:ss z');
        String key = 'AKIAI5OMXF2IRQRN3NLQ';
        String secret = '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';
        String bucketname = 'sfdcattcmnts';
        String host = 's3-ap-northeast-1.amazonaws.com';
        String method = 'PUT';
        String filename = 'testo';
        system.debug('%%%%%%%%%%%%%%%%'+String.valueOf(attachmentBody.length()));
        HttpRequest req = new HttpRequest();
        req.setMethod(method);
        req.setEndpoint('https://'+ host + '/' + bucketname + '/' + filename);
        req.setTimeout(2 * 60 * 1000);
        req.setHeader('Host', bucketname + '.' + host);
        req.setHeader('Content-Length', String.valueOf(attachmentBody.length()));
        req.setHeader('Content-Encoding', 'txt');
        req.setHeader('Content-type', attach.ContentType);
        req.setHeader('Connection', 'keep-alive');
        req.setHeader('Date', formattedDateString);
        req.setHeader('ACL', 'public-read');
        req.setBody(attachmentBody);

        String stringToSign = 'PUT\n\n' +
            attach.ContentType + '\n' +
            formattedDateString + '\n' +
            '/' + bucketname + '/' + bucketname + '/' + filename;
        system.debug('#####ss'+stringToSign);
        String encodedStringToSign = EncodingUtil.urlEncode(stringToSign, 'UTF-8');
        Blob mac = Crypto.generateMac('HMACSHA1', blob.valueof(stringToSign), blob.valueof(secret));
        String signed = EncodingUtil.base64Encode(mac);
        String authHeader = 'AWS' + ' ' + key + ':' + signed;
        req.setHeader('Authorization', authHeader);
        String decoded = EncodingUtil.urlDecode(encodedStringToSign, 'UTF-8');
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

    /*public static void dwnldAmazonS3() {
        String stringToSign = 'GET\n\n\n' +
            attach.ContentType + '\n' +
            formattedDateString + '\n' +
            '/' + bucketname + '/' + bucketname + '/' + filename;

        String encodedStringToSign = EncodingUtil.urlEncode(stringToSign, 'UTF-8');
        Blob mac = Crypto.generateMac('HMACSHA1', blob.valueof(stringToSign), blob.valueof(secret));
        String signed = EncodingUtil.base64Encode(mac);
        String authHeader = 'AWS' + ' ' + key + ':' + signed;
        req.setHeader('Authorization', authHeader);
        String decoded = EncodingUtil.urlDecode(encodedStringToSign, 'UTF-8');
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
    }*/
    
    public static string createAuthHeader(String method, String filename, String formattedDateString, String bucket, String key, String secret) {
        string auth;
        String stringToSign = method + '\n\n\n' + formattedDateString + '\n/' + bucket + '/' + filename;
        Blob mac = Crypto.generateMac('HMACSHA1', blob.valueof(stringToSign), blob.valueof(secret));
        String sig = EncodingUtil.base64Encode(mac);
        auth = 'AWS' + ' ' + key + ':' + sig;
        return auth;

    }
    
    public static void FileDownLoad() {
        String formattedDateString = String.valueOf(Datetime.now().formatGMT('EEE, dd MMM yyyy HH:mm:ss z'));
        String key = 'AKIAI5OMXF2IRQRN3NLQ';
        String secret = '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';
        String bucketname = 'sfdcattcmnts';
        String host = 's3-ap-northeast-1.amazonaws.com';
        String method = 'GET';
        String filename = '21276-bleach-ichigo-hollow-chaos-wallpaper.jpg';
        HttpRequest req = new HttpRequest();
        req.setMethod(method);
        req.setHeader('Date', formattedDateString);
        req.setHeader('Authorization', createAuthHeader(method, filename, formattedDateString, bucketname, key, secret));
        req.setTimeout(2 * 60 * 1000);
        Set < String > getParams = new Set < String > {
            'prefix=' + EncodingUtil.urlEncode(filename + '/', 'UTF-8'),
            'delimiter=' + EncodingUtil.urlEncode('/', 'UTF-8')
        };

        String endpointBase = 'https://'+ host + '/' +bucketname+'/'+ filename;

        req.setEndpoint(endpointBase);
        /*String stringToSign = 'PUT\n\n' +
            attach.ContentType + '\n' +
            formattedDateString + '\n' +
            '/' + bucketname + '/' + bucketname + '/' + filename;*/

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