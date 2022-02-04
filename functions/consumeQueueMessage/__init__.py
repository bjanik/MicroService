import azure.functions as func
import os
import redis

from azure.servicebus import ServiceBusClient

ACTIONS = {
    'payment': lambda balance, amount: balance + amount,
    'spending': lambda balance, amount: balance - amount,
}

REDIS_PORT = 6380

def main(msg: func.ServiceBusMessage):
    msg_body = msg.get_json().decode('utf-8')
    user_id = msg_body.get('user_id')
    amount = msg_body.get('amount')
    action = msg_body.get('action')

    if not user_id or not amount or not action:
        return func.HttpResponse("Missing parameters in message", status_code=404)
    if action not in ACTIONS:
        return func.HttpResponse("Invalid action", status_code=404) 
    
    redisClient = redis.StrictRedis(host=os.environ["REDIS_HOST"],
                                    port=REDIS_PORT,
                                    password=os.environ["REDIS_PASSWORD"])
    user_balance = redisClient.get(user_id)
    if not user_balance:
        user_balance = 0
    user_balance = ACTIONS[action](user_balance, amount)
    redisClient.set(user_id, user_balance)
    return func.HttpResponse(f"New user balance is {user_balance}")

