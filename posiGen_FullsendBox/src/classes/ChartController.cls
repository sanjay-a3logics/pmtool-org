public class ChartController {

    public ChartController() {

    }

    //bar chart:

    @TestVisible private List<CustomerActualSavingsController.CASDisplay> cas;
    
    public ChartController(CustomerActualSavingsController controller) {
        this.cas = (List<CustomerActualSavingsController.CASDisplay>)controller.get_myCAS();
        
    }

    public class MonthNetSavings {
        public String month { get; private set; }        
        public Decimal netsav { get; private set; }
        MonthNetSavings (String month, Decimal netsav) {
            this.month = month;
            this.netsav = netsav;       
        }
    }
    public MonthNetSavings [] getMNS() {
        return new MonthNetSavings [] {    //NOTE: 2016-09 version excludes calculations involving lease cost and will use only total/gross savings
            new MonthNetSAvings(cas[0].monthending, cas[0].totalsavings),
            new MonthNetSAvings(cas[1].monthending, cas[1].totalsavings),
            new MonthNetSAvings(cas[2].monthending, cas[2].totalsavings),
            new MonthNetSAvings(cas[3].monthending, cas[3].totalsavings),
            new MonthNetSAvings(cas[4].monthending, cas[4].totalsavings),
            new MonthNetSAvings(cas[5].monthending, cas[5].totalsavings),
            new MonthNetSAvings(cas[6].monthending, cas[6].totalsavings),
            new MonthNetSAvings(cas[7].monthending, cas[7].totalsavings),
            new MonthNetSAvings(cas[8].monthending, cas[8].totalsavings),
            new MonthNetSAvings(cas[9].monthending, cas[9].totalsavings),
            new MonthNetSAvings(cas[10].monthending, cas[10].totalsavings),
            new MonthNetSAvings(cas[11].monthending, cas[11].totalsavings)
       };
    }

    //line/area chart of cumulative net savings:
    public List<Data> getData() {
        return this.getChartData();
    }
    
    // Wrapper class
    public class Data {
        public String name { get; set; }
        public Decimal data1 { get; set; }
        public Data(String name, Decimal data1) {
            this.name = name;
            this.data1 = data1.setscale(2);
        }
    }

    public List<Data> getChartData() {
        List<Data> data = new List<Data>();
        data.add(new Data(cas[0].monthending, cas[0].cumulsavings));
        data.add(new Data(cas[1].monthending, cas[1].cumulsavings));
        data.add(new Data(cas[2].monthending, cas[2].cumulsavings));
        data.add(new Data(cas[3].monthending, cas[3].cumulsavings));
        data.add(new Data(cas[4].monthending, cas[4].cumulsavings));
        data.add(new Data(cas[5].monthending, cas[5].cumulsavings));
        data.add(new Data(cas[6].monthending, cas[6].cumulsavings));
        data.add(new Data(cas[7].monthending, cas[7].cumulsavings));
        data.add(new Data(cas[8].monthending, cas[8].cumulsavings));
        data.add(new Data(cas[9].monthending, cas[9].cumulsavings));
        data.add(new Data(cas[10].monthending, cas[10].cumulsavings));
        data.add(new Data(cas[11].monthending, cas[11].cumulsavings));
        return data;
        }

    //line chart of monthly solar/PV savings:
    public List<Data> getEEData() {
        return this.getEEChartData();
    }

    public List<Data> getEEChartData() {
        List<Data> eeData = new List<Data>();
        eeData.add(new Data(cas[0].monthending, cas[0].eusavings));
        eeData.add(new Data(cas[1].monthending, cas[1].eusavings));
        eeData.add(new Data(cas[2].monthending, cas[2].eusavings));
        eeData.add(new Data(cas[3].monthending, cas[3].eusavings));
        eeData.add(new Data(cas[4].monthending, cas[4].eusavings));
        eeData.add(new Data(cas[5].monthending, cas[5].eusavings));
        eeData.add(new Data(cas[6].monthending, cas[6].eusavings));
        eeData.add(new Data(cas[7].monthending, cas[7].eusavings));
        eeData.add(new Data(cas[8].monthending, cas[8].eusavings));
        eeData.add(new Data(cas[9].monthending, cas[9].eusavings));
        eeData.add(new Data(cas[10].monthending, cas[10].eusavings));
        eeData.add(new Data(cas[11].monthending, cas[11].eusavings));
        
        return eeData;
        }

}