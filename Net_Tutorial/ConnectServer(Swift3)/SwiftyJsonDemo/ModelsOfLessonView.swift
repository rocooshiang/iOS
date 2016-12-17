//
//  Bookmarks.swift
//  Power
//
//  Created by Rocoo on 2016/10/27.
//  Copyright © 2016年 劉育睿. All rights reserved.
//

import Foundation

class Phase{
    var phaseId: String
    var phaseLabel = "nil"
    var phaseName = "nil"
    var member: [LessonViewCell]
    
    init?(phaseId: String?, phaseLabel: String?, phaseName: String?, member: [LessonViewCell]?){
        guard let phaseId = phaseId, let member = member else{
            return nil
        }
        
        if let phaseLabel = phaseLabel, !phaseLabel.isEmpty{
            self.phaseLabel = phaseLabel
        }
        
        if let phaseName = phaseName, !phaseName.isEmpty{
            self.phaseName = phaseName
        }
        
        self.phaseId = phaseId
        self.member = member
        
    }
}

class LessonViewCell{
}

class Lesson: LessonViewCell{    
    var lessonId: String
    var minutes = "nil"
    var lessonName = "nil"
    var lessonLabel = "nil"
    var isExpanded = false
    
    init?(lessonId: String?, lessonName: String?, lessonLabel: String?, minutes: String?){
        guard let lessonId = lessonId else{
            return nil
        }
        
        if let lessonName = lessonName, !lessonName.isEmpty{
            self.lessonName = lessonName
        }
        
        if let lessonLabel = lessonLabel, !lessonLabel.isEmpty{
            self.lessonLabel = lessonLabel
        }
        
        if let minutes = minutes, !minutes.isEmpty{
            self.minutes = minutes
        }
        
        self.lessonId = lessonId
        
        super.init()
    }
    
}

class Sections: LessonViewCell{
    var sectionsMember: [Section]
    
    init?(sectionsMember: [Section]?){
        guard let sectionsMember = sectionsMember else{
            return nil
        }
        self.sectionsMember = sectionsMember
        super.init()
    }
}

class Section{
    var sectionId: String
    var sectionTitle = "nil"
    var pages: [Page]
    
    init?(sectionId: String?, sectionTitle: String?, pages: [Page]?){
        guard let sectionId = sectionId, let pages = pages else{
            return nil
        }
        
        if let sectionTitle = sectionTitle, !sectionTitle.isEmpty{
            self.sectionTitle = sectionTitle
        }
        
        self.sectionId = sectionId
        self.pages = pages
        
    }
}

class Pages{
    var pagesMember: [Page]
    
    init?(pagesMember: [Page]?){
        guard let pagesMember = pagesMember else{
            return nil
        }
        self.pagesMember = pagesMember
    }
}

class Page{
    var pageId: String?
    var pageContent: String?
    var pageTitle = "nil"
    
    init?(pageId: String?, pageContent: String?, pageTitle: String?){
        guard let pageId = pageId, let pageContent = pageContent else{
            return nil
        }
        
        if let pageTitle = pageTitle, !pageTitle.isEmpty{
            self.pageTitle = pageTitle
        }
        
        self.pageId = pageId
        self.pageContent = pageContent
        
    }
}


