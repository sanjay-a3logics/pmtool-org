public with sharing class ShowHouse{

    public  Attachment  file        { set; get; }
    public  Boolean     hasPicture  { set; get; }
    private String      parentId    { set; get; }
    
    /**
    * Constructor
    */
    public ShowHouse( ApexPages.StandardController stdController ){
        
        this.parentId       = stdController.getId();
        this.hasPicture     = false;
                
        List<Attachment> attList = [ Select ParentId, Name, Id, ContentType, BodyLength 
                                        From Attachment 
                                        where ParentId =: this.parentId and name = 'House Photo' limit 1];
        if( attList.size() > 0 ){
            this.file       = attList.get( 0 );
            this.file.Body  = Blob.valueOf('AuxString');
            this.hasPicture = true;
        }
    }
}