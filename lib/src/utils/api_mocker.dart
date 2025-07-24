part of '../../darturbation.dart';

/// API response mocker for testing HTTP requests and API integrations.
class ApiMocker {
  /// Generates mock REST API responses with realistic data and structure.
  static Map<String, dynamic> restResponse({
    required String endpoint,
    String method = 'GET',
    Map<String, Type> dataSchema = const {'id': String, 'name': String},
    int itemCount = 10,
    int statusCode = 200,
    bool includeMetadata = true,
    double errorRate = 0.0,
  }) {
    // Simulate network errors
    if (Darturbation.randomBool(errorRate)) {
      return _generateErrorResponse();
    }

    final response = {
      'status': statusCode,
      'statusText': _getStatusText(statusCode),
      'headers': {
        'content-type': 'application/json',
        'x-request-id': Darturbation.generateId(),
        'x-response-time': '${Darturbation.randomInt(10, 500)}ms',
        'server': 'Darturbation-Mock/1.0',
        'date': DateTime.now().toUtc().toIso8601String(),
      },
      'url': endpoint,
      'method': method.toUpperCase(),
    };

    // Generate response body based on method and status
    if (statusCode >= 200 && statusCode < 300) {
      switch (method.toUpperCase()) {
        case 'GET':
          if (endpoint.contains(RegExp(r'/\d+$'))) {
            // Single item endpoint
            response['data'] =
                Darturbation._genericGenerator.generate(dataSchema);
          } else {
            // List endpoint
            final items = List.generate(itemCount,
                (i) => Darturbation._genericGenerator.generate(dataSchema));

            response['data'] = items;

            if (includeMetadata) {
              response['meta'] = {
                'total': itemCount + Darturbation.randomInt(0, 100),
                'count': itemCount,
                'page': 1,
                'pageSize': itemCount,
                'totalPages':
                    ((itemCount + Darturbation.randomInt(0, 100)) / itemCount)
                        .ceil(),
              };
            }
          }
          break;

        case 'POST':
          response['data'] =
              Darturbation._genericGenerator.generate(dataSchema);
          response['message'] = 'Resource created successfully';
          break;

        case 'PUT':
        case 'PATCH':
          response['data'] =
              Darturbation._genericGenerator.generate(dataSchema);
          response['message'] = 'Resource updated successfully';
          break;

        case 'DELETE':
          response['message'] = 'Resource deleted successfully';
          break;
      }
    } else {
      response['error'] = {
        'code': statusCode,
        'message': _getErrorMessage(statusCode),
        'details': Darturbation._faker.lorem.sentence(),
        'timestamp': DateTime.now().toIso8601String(),
      };
    }

    return response;
  }

  /// Generates mock GraphQL responses with proper query structure.
  static Map<String, dynamic> graphqlResponse({
    required String query,
    Map<String, dynamic>? variables,
    Map<String, Type> dataSchema = const {},
    bool hasErrors = false,
    int itemCount = 10,
  }) {
    final response = <String, dynamic>{};

    if (!hasErrors) {
      // Generate successful response
      final data = <String, dynamic>{};

      dataSchema.forEach((key, type) {
        if (type == List) {
          // Generate list data
          data[key] = List.generate(
              itemCount,
              (i) => {
                    'id': Darturbation.generateId(),
                    'name': Darturbation._faker.person.name(),
                    'email': Darturbation._faker.internet.email(),
                    'createdAt': DateTime.now()
                        .subtract(Duration(days: i))
                        .toIso8601String(),
                  });
        } else if (type == Map) {
          // Generate object data
          data[key] = Darturbation._genericGenerator.generate({
            'id': String,
            'name': String,
            'value': double,
          });
        } else {
          // Generate primitive data
          data[key] = Darturbation._genericGenerator.generate({key: type})[key];
        }
      });

      response['data'] = data;
    } else {
      // Generate error response
      response['data'] = null;
      response['errors'] = [
        {
          'message': 'Field "nonExistentField" doesn\'t exist on type "User"',
          'locations': [
            {'line': 2, 'column': 9}
          ],
          'path': ['user', 'nonExistentField'],
        }
      ];
    }

    return response;
  }

  /// Generates mock WebSocket message data.
  static Map<String, dynamic> websocketMessage({
    required String type,
    Map<String, Type> dataSchema = const {},
    Map<String, dynamic>? metadata,
  }) {
    final Map<String, dynamic> message = {
      'id': Darturbation.generateId(),
      'type': type,
      'timestamp': DateTime.now().toIso8601String(),
    };

    if (dataSchema.isNotEmpty) {
      message['data'] = Darturbation._genericGenerator.generate(dataSchema);
    }

    if (metadata != null) {
      message['metadata'] = metadata;
    }

    // Add WebSocket-specific fields
    message['channel'] = Darturbation.randomChoice(
        ['general', 'notifications', 'updates', 'chat', 'system']);
    message['version'] = '1.0';
    message['source'] = 'server';

    return message;
  }

  /// Generates mock HTTP error responses for testing error handling.
  static Map<String, dynamic> errorResponse({
    int? statusCode,
    String? message,
    bool includeStack = false,
    Map<String, dynamic>? details,
  }) {
    final int code = statusCode ??
        Darturbation.randomChoice([400, 401, 403, 404, 422, 500, 502, 503]);

    final response = {
      'status': code,
      'statusText': _getStatusText(code),
      'error': {
        'code': code,
        'message': message ?? _getErrorMessage(code),
        'type': _getErrorType(code),
        'timestamp': DateTime.now().toIso8601String(),
        'requestId': Darturbation.generateId(),
      },
      'headers': {
        'content-type': 'application/json',
        'x-request-id': Darturbation.generateId(),
        'server': 'Darturbation-Mock/1.0',
      },
    };

    if (details != null) {
      (response['error'] as Map<String, dynamic>)['details'] = details;
    }

    return response;
  }

  // Helper methods
  static Map<String, dynamic> _generateErrorResponse() {
    final statusCode =
        Darturbation.randomChoice([400, 401, 403, 404, 422, 500, 502, 503]);
    return errorResponse(statusCode: statusCode);
  }

  static String _getStatusText(int code) {
    final statusTexts = {
      200: 'OK',
      201: 'Created',
      204: 'No Content',
      400: 'Bad Request',
      401: 'Unauthorized',
      403: 'Forbidden',
      404: 'Not Found',
      422: 'Unprocessable Entity',
      500: 'Internal Server Error',
      502: 'Bad Gateway',
      503: 'Service Unavailable',
    };
    return statusTexts[code] ?? 'Unknown';
  }

  static String _getErrorMessage(int code) {
    final messages = {
      400: 'The request was invalid or cannot be served',
      401: 'Authentication is required and has failed or has not been provided',
      403: 'The request is forbidden and cannot be completed',
      404: 'The requested resource could not be found',
      422: 'The request was well-formed but contains semantic errors',
      500: 'An internal server error occurred',
      502: 'Bad gateway - invalid response from upstream server',
      503: 'The server is currently unavailable',
    };
    return messages[code] ?? 'An error occurred';
  }

  static String _getErrorType(int code) {
    if (code >= 400 && code < 500) return 'client_error';
    if (code >= 500) return 'server_error';
    return 'unknown_error';
  }
}
