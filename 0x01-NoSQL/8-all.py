#!/usr/bin/python3
"""
unction that lists all documents in a collection
"""


def list_all(mongo_collection):
    """
    """
    return [doc for doc in mongo_collection.find()]
