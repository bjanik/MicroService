import json
import os
import redis

import azure.functions as func

REDIS_SSL_PORT = 6380

def main(req: func.HttpRequest) -> func.HttpResponse:
    user_id = req.body.get('user_id')
    if not user_id:
        return func.HttpResponse("Missing user_id", status=404)

    redis_client = redis.StrictRedis(host=os.environ['REDIS_HOST'],
                                     port=REDIS_SSL_PORT,
                                     password=os.environ['REDIS_PASSWORD'],
                                     ssl=True)
    user_balance = redis_client.get(user_id)
    if not user_balance:
        user_balance = 0
        redis_client.set(user_id, user_balance)
    return func.HttpResponse(json.dumps({'balance': user_balance}, status=200))