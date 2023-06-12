//
//  TimeZoneViewController.swift
//  TimeZoneOFDifferentCountries
//
//  Created by Tipu on 16/5/23.
//

import UIKit
import CoreLocation

class TimeZoneViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource, UICollectionViewDelegateFlowLayout,LocationVCDelegate {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var SwitchButtonName: UILabel!
    var isGrid: Bool = true
    var selectedCityNames: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.collectionViewLayout = CustomCollectionViewLayout()
        
        if let savedCities = UserDefaults.standard.stringArray(forKey: "SelectedCities") {
            selectedCityNames = savedCities
        }
        //collectionView.reloadData()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        collectionView.reloadData()
    }
    
    func saveSelectedCities() {
        UserDefaults.standard.set(selectedCityNames, forKey: "SelectedCities")
        UserDefaults.standard.synchronize()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destinationVC = segue.destination as? LocationVC {
            destinationVC.delegate = self
        }
    }
    
    func didSelectLocation(cityNames: [String]) {
        selectedCityNames.append(contentsOf: cityNames)
        collectionView.reloadData()
        saveSelectedCities() // Save the updated array
    }
    
    @IBAction func addButton(_ sender: Any?) {
    }
    
    @IBAction func refresh(_ sender: UIBarButtonItem) {
        collectionView.reloadData()
    }
    
    @IBAction func SwitchButtonAction(_ sender: UIButton) {
        isGrid.toggle()
        let layout = collectionView.collectionViewLayout as! CustomCollectionViewLayout
        layout.isGrid = isGrid
        layout.updateLayout()
        collectionView.reloadData()
        
        // Update the button label
        let buttonTitle = isGrid ? "SWITCH TO LIST VIEW" : "SWITCH TO GRID VIEW"
        SwitchButtonName.text = buttonTitle
    }
    
    //MARK: COLLECTIOBVIEW
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return selectedCityNames.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! TimeZoneCollectionViewCell
        let cityName = selectedCityNames[indexPath.item]
        
        if let timeZone = TimeZone(identifier: cityName) {
            let formatter = DateFormatter()
            formatter.timeZone = timeZone
            
            // Time (hour:minute)
            formatter.dateFormat = "HH:mm"
            let currentTime = formatter.string(from: Date())
            cell.cityTimes.text = currentTime
            
            // Date (Sunday, 14 August 2002)
            formatter.dateFormat = "EEEE, d MMMM yyyy"
            let currentDate = formatter.string(from: Date())
            cell.dates.text = currentDate
            
            // AM/PM indicator
            formatter.dateFormat = "a"
            let ampm = formatter.string(from: Date())
            cell.AMPM.text = ampm
            
            // GMT offset
            let gmtOffset = timeZone.secondsFromGMT() / 3600
            cell.gtmtimes.text = "GTM \(gmtOffset)"
            
            // Color mapping
            if let hour = Int(currentTime.prefix(2)) {
                switch hour {
                case 1:
                    cell.backgroundColor = UIColor(red: 128/255, green: 0, blue: 0, alpha: 1) // Burnt Orange
                case 2:
                    cell.backgroundColor = UIColor(red: 255/255, green: 191/255, blue: 0, alpha: 1) // Amber
                case 3:
                    cell.backgroundColor = UIColor(red: 255/255, green: 117/255, blue: 24/255, alpha: 1) // Pumpkin
                case 4:
                    cell.backgroundColor = UIColor(red: 204/255, green: 78/255, blue: 57/255, alpha: 1) // Terracotta
                case 5:
                    cell.backgroundColor = UIColor(red: 183/255, green: 65/255, blue: 14/255, alpha: 1) // Rust
                case 6:
                    cell.backgroundColor = UIColor(red: 255/255, green: 179/255, blue: 102/255, alpha: 1) // Light Orange
                case 7:
                    cell.backgroundColor = UIColor(red: 255/255, green: 223/255, blue: 191/255, alpha: 1) // Pale Orange
                case 8:
                    cell.backgroundColor = UIColor(red: 255/255, green: 218/255, blue: 185/255, alpha: 1) // Peach
                case 9:
                    cell.backgroundColor = UIColor(red: 251/255, green: 206/255, blue: 177/255, alpha: 1) // Apricot
                case 10:
                    cell.backgroundColor = UIColor(red: 255/255, green: 165/255, blue: 0, alpha: 1) // Tangerine
                case 11:
                    cell.backgroundColor = UIColor(red: 255/255, green: 127/255, blue: 80/255, alpha: 1) // Coral
                case 12:
                    cell.backgroundColor = UIColor(red: 250/255, green: 128/255, blue: 114/255, alpha: 1) // Salmon
                case 13:
                    cell.backgroundColor = UIColor(red: 0.62, green: 0.48, blue: 0.71, alpha: 1.00) // Lavender
                case 14:
                    cell.backgroundColor = UIColor(red: 200/255, green: 162/255, blue: 200/255, alpha: 1) // Lilac
                case 15:
                    cell.backgroundColor = UIColor(red: 224/255, green: 176/255, blue: 255/255, alpha: 1) // Mauve
                case 16:
                    cell.backgroundColor = UIColor(red: 218/255, green: 112/255, blue: 214/255, alpha: 1) // Orchid
                case 17:
                    cell.backgroundColor = UIColor(red: 221/255, green: 160/255, blue: 221/255, alpha: 1) // Plum
                case 18:
                    cell.backgroundColor = UIColor(red: 153/255, green: 102/255, blue: 204/255, alpha: 1) // Amethyst
                case 19:
                    cell.backgroundColor = UIColor(red: 111/255, green: 78/255, blue: 145/255, alpha: 1) // Grape
                case 20:
                    cell.backgroundColor = UIColor(red: 128/255, green: 0, blue: 128/255, alpha: 1) // Violet
                case 21:
                    cell.backgroundColor = UIColor(red: 75/255, green: 0, blue: 130/255, alpha: 1) // Indigo
                case 22:
                    cell.backgroundColor = UIColor(red: 25/255, green: 25/255, blue: 112/255, alpha: 1) // Midnight Blue
                case 23:
                    cell.backgroundColor = UIColor(red: 0, green: 0, blue: 128/255, alpha: 1) // Navy
                case 0:
                    cell.backgroundColor = UIColor.black
                default:
                    cell.backgroundColor = UIColor.clear
                }
            }
            
        } else {
            
        }
        
        cell.lable.text = cityName
        
        //hidden for gridview
        cell.gtmtimes.isHidden = self.isGrid
        cell.cityTimes.isHidden = self.isGrid
        cell.AMPM.isHidden = self.isGrid
        cell.lable.isHidden = self.isGrid
        cell.dates.isHidden = self.isGrid
        
        
        let spacing: CGFloat = 10 // Adjust spacing between cells as needed
        let columns: CGFloat = 2 // Number of columns in the grid
        
        let itemWidth = (collectionView.bounds.width - spacing * (columns - 1)) / columns
        let itemHeight = collectionView.bounds.height * 0.5
        
        let itemSize = CGSize(width: itemWidth, height: itemHeight)
        if self.isGrid {
            cell.resetCell()
            
            let itemWidth = collectionView.bounds.width / columns
            let itemHeight = collectionView.bounds.height * 0.25
            
            // Get the current time from the cell
            let cityName = selectedCityNames[indexPath.item]
            if let timeZone = TimeZone(identifier: cityName) {
                let formatter = DateFormatter()
                formatter.timeZone = timeZone
                formatter.dateFormat = "HH:mm"
                let currentTime = formatter.string(from: Date())
                if let hour = Int(currentTime.prefix(2)), let minute = Int(currentTime.suffix(2)) {
                    // Create and configure the analog watch image view
                    let watchImageView = UIImageView(image: generateAnalogImage(hour: hour, minute: minute))
                    watchImageView.contentMode = .scaleAspectFit
                    watchImageView.frame = CGRect(x: (itemWidth - itemHeight) / 2, y: 0, width: itemHeight, height: itemHeight)
                    watchImageView.tag = 999

                    // Create and configure the AM/PM label
                    let ampmLabel = UILabel(frame: CGRect(x: itemWidth - 50, y: 5, width: 40, height: 20))
                    ampmLabel.text = hour >= 12 ? "PM" : "AM"
                    ampmLabel.textAlignment = .center
                    ampmLabel.textColor = .white
                    ampmLabel.tag = 999
               
                    // Create and configure the day/night icon
                    let iconImageView = UIImageView(image: hour >= 5 && hour < 19 ? UIImage(systemName: "sun.max") : UIImage(systemName: "moon"))
                    iconImageView.contentMode = .scaleAspectFit
                    iconImageView.frame = CGRect(x: itemWidth - 30, y: itemHeight - 30, width: 20, height: 20)
                    iconImageView.tintColor = .white // Set the tint color to white

                    iconImageView.tag = 999
                    
                    // Create and configure the location label
                    let locationLabel = UILabel(frame: CGRect(x: 0, y: itemHeight + 5, width: itemWidth, height: 20))
                    locationLabel.text = cityName
                    locationLabel.textAlignment = .center
                    locationLabel.textColor = .white
                    locationLabel.tag = 999
                    
                    // Create and configure the date label
                    let dateLabel = UILabel(frame: CGRect(x: 0, y: itemHeight + 30, width: itemWidth, height: 20))
                    
                    formatter.dateFormat = "EEEE, d MMMM yyyy"
                    let currentDate = formatter.string(from: Date())
                    dateLabel.text = currentDate
                    dateLabel.textAlignment = .center
                    dateLabel.textColor = .white
                    dateLabel.tag = 999
                    
                    // Add the subviews to the cell's content view
                    cell.contentView.addSubview(watchImageView)
                    cell.contentView.addSubview(ampmLabel)
                    cell.contentView.addSubview(iconImageView)
                    cell.contentView.addSubview(locationLabel)
                    cell.contentView.addSubview(dateLabel)
                }
            }
        } else {
            // Hide the labels
            cell.contentView.subviews.forEach { subview in
                if subview.tag == 999 {
                    subview.isHidden = true
                }
            }
        }
        return cell
    }
    
    // Enable swipe-to-delete functionality
    func collectionView(_ collectionView: UICollectionView, canEditItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        // Configure swipe-to-delete gesture recognizer for the cell
        let swipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipeGesture(_:)))
        swipeGesture.direction = .right
        cell.addGestureRecognizer(swipeGesture)
    }
    
    @objc func handleSwipeGesture(_ gestureRecognizer: UISwipeGestureRecognizer) {
        guard let indexPath = collectionView.indexPathForItem(at: gestureRecognizer.location(in: collectionView)) else {
            return
        }
        self.deleteItemAt(indexPath: indexPath)
    }
    
    private func deleteItemAt(indexPath: IndexPath) {
        selectedCityNames.remove(at: indexPath.item)
        collectionView.deleteItems(at: [indexPath])
        saveSelectedCities() // Save the updated array
    }
    func generateAnalogImage(hour: Int, minute: Int) -> UIImage? {
        // Create a graphics context
        UIGraphicsBeginImageContextWithOptions(CGSize(width: 100, height: 100), false, 0)
        guard let context = UIGraphicsGetCurrentContext() else {
            return nil
        }
        
        // Draw the hour hand
        let hourAngle = (CGFloat(hour % 12) + CGFloat(minute) / 60.0) * (CGFloat.pi / 6)
        context.setStrokeColor(UIColor.white.cgColor) // Set the color to white
        context.setLineWidth(3)
        context.move(to: CGPoint(x: 50, y: 50))
        context.addLine(to: CGPoint(x: 50 + 30 * sin(hourAngle), y: 50 - 30 * cos(hourAngle)))
        context.strokePath()
        
        // Draw the minute hand
        let minuteAngle = CGFloat(minute) * (CGFloat.pi / 30)
        context.setStrokeColor(UIColor.white.cgColor) // Set the color to white
        context.setLineWidth(2)
        context.move(to: CGPoint(x: 50, y: 50))
        context.addLine(to: CGPoint(x: 50 + 40 * sin(minuteAngle), y: 50 - 40 * cos(minuteAngle)))
        context.strokePath()
        
        // Draw the circle around the watch
        context.setStrokeColor(UIColor.white.cgColor) // Set the color to white
        context.setLineWidth(2)
        context.addEllipse(in: CGRect(x: 10, y: 10, width: 80, height: 80))
        context.strokePath()
        
        // Get the generated image
        let image = UIGraphicsGetImageFromCurrentImageContext()
        
        // End the graphics context
        UIGraphicsEndImageContext()
        
        return image
    }
}
