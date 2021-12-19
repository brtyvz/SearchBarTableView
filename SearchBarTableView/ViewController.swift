//
//  ViewController.swift
//  SearchBarTableView
//
//  Created by Berat Yavuz on 19.12.2021.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    var ulkeler:[String]=[String]()
    var aramaSonucuUlkeler:[String]=[String]()
    var aramaYapılıyorMu = false
    override func viewDidLoad() {
        super.viewDidLoad()
       ulkeler=["Kosova","Sırbistan","İspanya","Kıbrıs","Moritanya","Almanya","İsveç","Meksika","Japonya"]
        
        tableView.delegate = self
        tableView.dataSource = self
        
        searchBar.delegate = self
        
    }


}

//tableView için extension
extension ViewController:UITableViewDelegate,UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if aramaYapılıyorMu {
            return aramaSonucuUlkeler.count
        }
        else{ return ulkeler.count}
      
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let  cell = tableView.dequeueReusableCell(withIdentifier: "ulkeHucre", for: indexPath)
        
        if aramaYapılıyorMu {
            cell.textLabel?.text = aramaSonucuUlkeler[indexPath.row]
        }
        else{cell.textLabel?.text = ulkeler[indexPath.row]}
        
        return cell
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Seçilen Ülke \(ulkeler[indexPath.row])")
    }
    
    
}

//searchBar için ViewController
extension ViewController:UISearchBarDelegate{
    //searchBarda aranan her harfi tek tek çekebiliriz textdidchange metodu ile
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print("Search \(searchText)")
        if searchText == "" {
            aramaYapılıyorMu = false
            //arama işlemi
           
            }
        else{aramaYapılıyorMu = true
            aramaSonucuUlkeler = ulkeler.filter({ $0.lowercased().contains(searchText.lowercased())
             } )
            
        }
            
       
            //her aramadan sonra tableview.reloaddata dememiz gerekli verilerin tekrar yazdırılıması için
            tableView.reloadData()

        }
    }



