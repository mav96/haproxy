import falcon
from wsgiref import simple_server

class Health:
    def on_get(self, req, resp):
        """Handles GET requests"""
        res = {
            'Health': 'Ok'
        }

        resp.media = res


class Res:
    def on_get(self, req, resp):
        res = {
            'Hostname': req.host
        }

        resp.media = res


api = falcon.API()
api.add_route('/healthcheck',   Health())
api.add_route('/', Res())

if __name__ == '__main__':
    httpd = simple_server.make_server('0.0.0.0', 8080, api)
    httpd.serve_forever()


