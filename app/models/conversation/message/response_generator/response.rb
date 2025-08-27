class Conversation::Message::ResponseGenerator::Response
  attr_reader :answer, :input_tokens, :output_tokens, :model_id, :tool_calls, :tool_call_id

  def initialize(answer:, input_tokens:, output_tokens:, model_id:)
    @answer = answer
    @input_tokens = input_tokens
    @output_tokens = output_tokens
    @model_id = model_id
  end

  def cost
    @cost ||= Ai::UsageCost.from_llm_response(self)
  end
end
