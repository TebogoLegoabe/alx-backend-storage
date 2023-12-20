#!/usr/bin/env python3
import requests
import time
from functools import wraps
from typing import Dict

CACHE = {}

def count_access(func):
    @wraps(func)
    def wrapper(*args, **kwargs):
        url = args[0]
        count_key = f"count:{url}"
        CACHE.setdefault(count_key, 0)
        CACHE[count_key] += 1
        print(f"URL accessed {CACHE[count_key]} times")
        return func(*args, **kwargs)
    return wrapper

def cache_result(expiration=10):
    def decorator(func):
        @wraps(func)
        def wrapper(*args, **kwargs):
            url = args[0]
            cache_key = f"result:{url}"
            cached_result = CACHE.get(cache_key)
            if cached_result is not None:
                return cached_result

            result = func(*args, **kwargs)
            CACHE[cache_key] = result
            CACHE.set_expiry(cache_key, expiration)
            return result
        return wrapper
    return decorator

@count_access
@cache_result(expiration=10)
def get_page(url: str) -> str:
    response = requests.get(url)
    response.raise_for_status()
    return response.text
