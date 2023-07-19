#!/usr/bin/env python3
"""
This module models a Caching System that stores the runtime values stored data
"""
import uuid
from typing import Union

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

    def __del__(self) -> None:
        """
        :return: None
        :rtype: None
        """
        self._redis.close()
