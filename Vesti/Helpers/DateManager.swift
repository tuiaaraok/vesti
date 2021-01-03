//
//  DateManager.swift
//  Vesti
//
//  Created by Айсен Шишигин on 03/01/2021.
//  Copyright © 2021 Туйаара Оконешникова. All rights reserved.
//

import Foundation

class DateManager {
    
   func translatePubdate(from dateString: String) -> String {
       var date = ""
       let weekStartIndex = dateString.startIndex
       let weekEndIndex = dateString.index(dateString.startIndex, offsetBy: 3)
       let monthStartIndex = dateString.index(dateString.startIndex, offsetBy: 8)
       let monthEndIndex = dateString.index(dateString.startIndex, offsetBy: 11)
       var week = dateString[weekStartIndex ..< weekEndIndex]
       var month = dateString[monthStartIndex ..< monthEndIndex]
       
       switch week {
       case "Mon":
           week = "Пн."
       case "Tue":
           week = "Вт."
       case "Wed":
           week = "Ср."
       case "Thu":
           week = "Чт."
       case "Fri":
           week = "Пт."
       case "Sat":
           week = "Сб."
       case "Sun":
           week = "Вс."
       default:
           break
       }
       
       switch month {
       case "Jan":
           month = "Янв"
       case "Feb":
           month = "Фев"
       case "Mar":
           month = "Март"
       case "Apr":
           month = "Апр"
       case "May":
           month = "Май"
       case "Jun":
           month = "Июнь"
       case "Jul":
           month = "Июль"
       case "Aug":
           month = "Авг"
       case "Sep":
            month = "Сен"
       case "Oct":
            month = "Окт"
       case "Nov":
            month = "Ноя"
       case "Dec":
            month = "Дек"
       default:
           break
       }
       date = week + dateString[weekEndIndex..<monthStartIndex] + String(month) + dateString[monthEndIndex..<dateString.endIndex]
       
       return date
   }
}
