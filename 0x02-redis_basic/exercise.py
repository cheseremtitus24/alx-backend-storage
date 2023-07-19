#!/usr/bin/env python3
"""
"""
import uuid
from typing import Union

import redis


class Cache:
    _redis: redis.Redis = redis.Redis()

    def __init__(self):
        # flush the instance
        self._redis.flushdb()

    def store(self, data: Union[str, bytes, int, float]) -> str:
        randkey: uuid.UUID = uuid.uuid4()
        rand_key_string: str = str(randkey)
        self._redis.set(name=rand_key_string, value=data)
        return rand_key_string

    def __del__(self):
        self._redis.close()
