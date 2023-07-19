#!/usr/bin/env python3
"""
This module models a Caching System that stores the runtime values stored data
"""
import uuid
from functools import wraps
from typing import Union, Callable, Optional

import redis


def count_calls(method: Callable) -> Callable:
    """
    Decorator function that counts the number of times
    that a method has been called and uses the .inc method of
    redis
    :param method: Method to be wrapped
    :type method: Callable
    :return: value returned by original method
    :rtype: Callable
    """
    @wraps(method)
    def wrapper(self, *args, **kwargs):
        """
        :param self:
        :type self:
        :param args:
        :type args:
        :param kwargs:
        :type kwargs:
        :return:
        :rtype:
        """
        # Get the qualified name of the method.
        method_name = method.__qualname__

        # Increment the count for that key.
        self._redis.incr(method_name)

        # Return the value returned by the original method.
        return method(self, *args, **kwargs)

    return wrapper


def call_history(method: Callable) -> Callable:
    """
    Stores the history of inputs and outputs for a particular function.
    :param method:Store function
    :type method:Callable
    :return: the method's inputs
    :rtype: Callable
    """
    method_name = method.__qualname__
    inputs = method_name + ":inputs"
    outputs = method_name + ":outputs"

    @wraps(method)
    def wrapper(self, *args, **kwargs):
        """

        :param self:
        :type self:
        :param args:
        :type args:
        :param kwargs:
        :type kwargs:
        :return:
        :rtype:
        """
        self._redis.rpush(inputs, str(args))
        output = method(self, *args, **kwargs)
        self._redis.rpush(outputs, str(output))
        return output

    return wrapper


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

    @call_history
    @count_calls
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
