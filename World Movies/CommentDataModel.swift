//
//  CommentDataModel.swift
//  World Movies
//
//  Created by mino on 7/5/18.
//  Copyright © 2018 mino. All rights reserved.
//

import Foundation

class CommentDataModel
{
    var AuthUser: String!
    var Post_ID : Int!
    var User_Comment : String!
    
    init(AUser:String , pID: Int , UComment: String ) {
        
        self.AuthUser = AUser
        self.Post_ID = pID
        self.User_Comment = UComment

    }
    
}
