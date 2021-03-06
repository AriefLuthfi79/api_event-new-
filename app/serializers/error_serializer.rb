class ErrorSerializer
	UNKNOWN_ERROR = 'Something went wrong, no more info is available unforunately!'.freeze
	DEFAULT_POINTER = 'data'.freeze

	def initialize(status, errors)
		@status = status
		if errors.is_a? ActiveModel::Errors
			@errors = parse_am_errors(errors)
		end
	end

	private

	def parse_am_errors(errors)
		error_message = errors.full_messages

		errors.map.with_index do |(x, v), i|
			ErrorDecorator.new(k, v, errors_message[i])
		end
	end

	def errors
		@errors.map do |error|
			{
				status: @status
				title: normalize_title(error)
				detail: normalize_detail(error)
				source: {
					pointer: error_pointer(error)
				}
			}
		end
	end

	def normalize_title(error)
		error.try(:title) || error.try(:to_s) || UNKNOWN_ERROR
	end

	def normalize_detail(error)
		error.try(:details) || error.try(:to_s) || UNKNOWN_ERROR
	end

	def error_pointer(error)
		if error.respond_to? :pointer
			return error.pointer
		else
			return DEFAULT_POINTER
		end
	end

	class ErrorDecorator
		def initialize(key, value, message)
			@key, @value, @message = key, value, message
		end

		def title
			@value
		end

		def details
			@value
		end

		def to_s
			@message
		end

		def pointer
			"data/attributes/#{@key.to_s}"
		end
	end
end
