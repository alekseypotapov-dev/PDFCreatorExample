// Credits
// project inspiration by: https://www.raywenderlich.com
// Data Sources:
// random names: http://listofrandomnames.com
// random addresses: https://www.randomlists.com
// random money: Float.random(in: 9...99)

import UIKit
import PDFKit

let names = ["Jenice Littler", "Marianna Harned", "Rosendo Laubach", "Lawrence Ritchie", "Dolores Mcnelly", "Jarred Edens", "Lakia Harten", "Jannette Duer", "Johnny Stinger", "Olympia Mclane", "Manda Kersh", "Clint Muller", "Anjanette Simkins", "Genny Mayhew", "Bonny Risser", "Bridgette Groth", "Glenda Mirarchi", "Omar Ashbrook", "Deedee Luker", "Caitlyn Borgeson", "Arden Maloy", "Orval Esper", "Carole Wendland", "Tiffanie Popp", "Whitley Davie", "Janett Carrara", "Rosia Stalvey", "Taunya Pinkney", "Bertram Hemmingway", "Dalia Hulett", "Alejandrina Heinz", "Marlena Goold", "Randa Cornish", "Nicolette Drexler", "Christi Collinson", "Harris Pesina", "Natasha Sommers", "Terrance Jarboe", "Avery Prouty", "Louise Shire", "Corrie Kapinos", "Bao Milstead", "Tran Mcpeak", "Cody Dewald", "Paris Newkirk", "Felisha Verona", "Milo Eno", "Nicole Bryand", "Anya Wierenga", "Dinah Levitsky"]

let addresses = ["667 Gates St. Paterson, NJ 07501", "6 Riverside Court Ellicott City, MD 21042", "282 Philmont Street Howell, NJ 07731", "120 N. Lake View Drive Wheaton, IL 60187", "748 S. Riverview St. Chapel Hill, NC 27516", "7038 Bridle Road Pottstown, PA 19464", "84 South Peninsula Dr. Merrick, NY 11566", "65 Blackburn Drive West Islip, NY 11795", "3 Whitemarsh Street Piscataway, NJ 08854", "8559 Mayfield Lane Taylor, MI 48180", "51 St Margarets Dr. Phoenixville, PA 19460", "224 East Bridgeton Circle Billings, MT 59101", "7 Arlington Drive Boca Raton, FL 33428", "74 Jennings St. Irwin, PA 15642", "9257 Mill Pond Street Painesville, OH 44077", "447 Rockaway Ave. Des Plaines, IL 60016", "34 Princess St. Waldorf, MD 20601", "8486 West Glen Creek Ave. Amsterdam, NY 12010", "748 Summer Rd. Los Angeles, CA 90008", "31 Victoria Lane Latrobe, PA 15650", "838 Central Ave. Utica, NY 13501", "123 Vine Rd. Lawndale, CA 90260", "632 Del Monte Dr. Williamstown, NJ 08094", "8626 Country Drive Williamsport, PA 17701", "4 Vermont St. Elizabethtown, PA 17022", "7752 Laurel Lane Ambler, PA 19002", "828 Creek Dr. Biloxi, MS 39532", "7950 South Pennsylvania Ave. Hollywood, FL 33020", "7645 Tunnel Ave. Culpeper, VA 22701", "199 Hudson St. Kaukauna, WI 54130", "689 Berkshire St. Apple Valley, CA 92307", "97A Lyme Ave. Janesville, WI 53546", "134 Cedarwood St. Middleton, WI 53562", "738 Coffee Street Elizabethton, TN 37643", "569 College Drive Buffalo, NY 14215", "87 Front Street State College, PA 16801", "8069 Kirkland Drive Portage, IN 46368", "48 Eagle Ave. Elmont, NY 11003", "833 Virginia Ave. Encino, CA 91316", "662 Boston Court Staten Island, NY 10301", "7233 Devonshire Court New Brunswick, NJ 08901", "65 Virginia Drive Seattle, WA 98144", "388 Sierra St. Middleburg, FL 32068", "641 SW. Gulf St. Waterbury, CT 06705", "8279 Mill Pond St. Staunton, VA 24401", "56 Deerfield St. Cranberry Twp, PA 16066", "9289 Hilldale Ave. Lakeland, FL 33801", "7486 Poplar St. Brainerd, MN 56401", "2 Berkshire Road Missoula, MT 59801", "160 Kirkland Ave. Clifton Park, NY 12065"]

let money = [55.08, 87.75, 72.00, 96.79, 17.07, 85.36, 75.44, 70.35, 28.39, 46.17, 84.70, 37.47, 23.22, 97.98, 56.23, 47.89, 40.56, 86.50, 30.93, 50.15, 22.19, 95.70, 26.48, 79.48, 15.27, 15.00, 45.36, 88.26, 11.49, 48.96, 58.58, 56.04, 95.31, 21.56, 63.44, 90.83, 22.12, 88.17, 19.75, 30.65, 47.00, 39.82, 26.83, 91.12, 54.61, 35.06, 16.54, 78.64, 90.66, 41.81]

struct TableDataItem {
    let name: String
    let address: String
    let money: Double

    init(name: String, address: String, money: Double) {
        self.name = name
        self.address = address
        self.money = money
    }
}

class ViewController: UIViewController {

    var pdfView: PDFView!

    override func viewDidLoad() {
        super.viewDidLoad()
        createUI()
        createPDF()
    }

    func createUI() {
        pdfView = PDFView()
        pdfView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(pdfView)
        pdfView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        pdfView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        pdfView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        pdfView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }

    func createPDF() {
        var tableDataItems = [TableDataItem]()
        for itemIndex in 0..<names.count {
            tableDataItems.append(TableDataItem(name: names[itemIndex], address: addresses[itemIndex], money: money[itemIndex]))
        }
        let sumItem = money.reduce(0, +)
        tableDataItems.append(TableDataItem(name: "", address: "sum:", money: sumItem))
        let tableDataHeaderTitles =  ["name", "address", "money"]
        let pdfCreator = PDFCreator(tableDataItems: tableDataItems, tableDataHeaderTitles: tableDataHeaderTitles)

        let data = pdfCreator.create()
        pdfView.document = PDFDocument(data: data)
        pdfView.autoScales = true
    }

}
