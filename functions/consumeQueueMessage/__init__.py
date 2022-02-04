import azure.functions as func
import json
import logging
import os
import redis

from azure.servicebus import ServiceBusClient

REDIS_PORT = 6380

def get_user_balance(user_id, redisClient):
    user_balance = redisClient.get(user_id)
    if not user_balance:
        user_balance = 0
    user_balance = int(user_balance)

def main(msg: func.ServiceBusMessage):
    body = json.loads(msg.get_body().decode('utf8'))
    try:
        user_id = body['user_id']
        amount = body['amount']
        action = body['action']
    except KeyError as e:
        return "Missing parameter"
    if amount < 0:
        return "Amount must be non-negative"
    if action not in ["spending", "payment"]:
        return "Invalid action"
    redisClient = redis.StrictRedis(host=os.environ["REDIS_HOST"],
                                    port=REDIS_PORT,
                                    password=os.environ["REDIS_PASSWORD"],
                                    decode_responses=True,
                                    ssl=True)
    user_balance = get_user_balance(user_id, redisClient)
    new_user_balance = user_balance + amount if action == "payment" else user_balance - amount
    redisClient.set(user_id, new_user_balance)
    logging.info(f"user_balance = {new_user_balance}")
    return "New user balance is {new_user_balance}"
