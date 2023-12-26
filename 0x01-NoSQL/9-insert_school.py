#!/usr/bin/env python3
"""
unction that inserts a new document in a collection based on kwarg
"""


def insert_school(mongo_collection, **kwargs):
    """
    """
    result = mongo_collection.insert_one(kwargs)
    return result.inserted_id
