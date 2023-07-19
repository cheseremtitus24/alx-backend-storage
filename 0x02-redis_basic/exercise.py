#!/usr/bin/env python3
"""
This module models a Caching System that stores the runtime values stored data
"""
import uuid
from typing import Union, Callable, Optional

import redis


class Cache:
    """
    Saves data to Redis DB
    """

    def __init__(self):
        """
        Flushes/Deletes all the keys in the Redis DB
        """
        self._redis: redis.Redis = redis.Redis()
        # flush the instance
        self._redis.flushdb()

    def store(self, data: Union[str, bytes, int, float]) -> str:
        """
        :param data: is saved as a value in the redis DB
        :type data: str | bytes | int | float
        :return: a unique dictionary key
        :rtype: str
        """
        randkey: uuid.UUID = uuid.uuid4()
        rand_key_string: str = str(randkey)
        self._redis.set(name=rand_key_string, value=data)
        return rand_key_string

    def get(self, key: str, fn: Optional[Callable]
            = None) -> Union[str, bytes, int, float]:
        """Retrieve Data from Redis DB"""
        val = self._redis.get(key)
        if fn:
            val = fn(val)
        return val

    def get_str(self, key: str) -> str:
        """
        Returns a decoded string
        :param key: Redis dictionary Unique access key
        :type key: string
        :return: a decoded string
        :rtype: string
        """
        val = self._redis.get(key)
        return val.decode("utf-8")

    def get_int(self, key: str) -> int:
        """
        Get Integer
        :param key: dictionary key
        :type key: str
        :return: decoded integer value
        :rtype: int
        """
        val = self._redis.get(key)
        try:
            val = int(val.decode("utf-8"))
        except Exception:
            val = 0
        return val

    def __del__(self) -> None:
        """
        Destroys the redis connection when object
        goes out of scope
        :return: None
        :rtype: None
        """
        self._redis.close()
