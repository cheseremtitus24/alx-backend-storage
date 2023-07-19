#!/usr/bin/env python3
"""
Lists all documents in a collection
"""
def list_all(mongo_collection):
    """ Returns a list of all documents in a collection"""
    if not mongo_collection:
        return []
    return list(mongo_collection.find())
