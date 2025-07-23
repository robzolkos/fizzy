class Admin::PromptSandboxesController < AdminController
  include DayTimelinesScoped

  MODELS = %w[
    chatgpt-4o-latest
    gpt-4.1
    gpt-3.5-turbo
    gpt-4.1-mini
    gpt-4.1-nano
    gpt-4o-mini
  ]

  def show
    @llm_models = MODELS.map { |model| [ model, model ] }
    @llm_model = params[:llm_model] || Event::Summarizer::LLM_MODEL

    if @prompt = cookies[:prompt].presence
      summarize
      cookies[:prompt] = nil
    else
      show_default_prompt
    end
  end

  def create
    @prompt = params[:prompt]
    @llm_model = params[:llm_model]
    cookies[:prompt] = @prompt
    redirect_to admin_prompt_sandbox_path(day: @day_timeline.day, llm_model: @llm_model)
  end

  private
    def summarize
      summarizer = Event::Summarizer.new(@day_timeline.events, prompt: @prompt, llm_model: @llm_model)
      @summary = Event::ActivitySummary.new(content: summarizer.summarize).to_html
      @summarizable_content == summarizer.summarizable_content.html_safe
    end

    def show_default_prompt
      @prompt = Event::Summarizer::PROMPT
      @summary = @day_timeline.summary&.to_html
    end
end
