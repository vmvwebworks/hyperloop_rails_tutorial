#/app/hyperloop/components/helloworld.rb


class Helloworld < Hyperloop::Component

  before_mount do
    @helloworldmodels = Helloworldmodel.all
  end

  after_mount do
    MessagesOperations::GetMessages.run
  end

  render(DIV) do

    DIV(class: 'hyperloophelloword') do

      IMG(src: 'https://rawgit.com/ruby-hyperloop/hyperloop-js-helloworld/master/hyperloop-logo-medium-white.png?raw=true')
      H3 { "The complete isomorphic ruby framework" }
      BR{}

      InputMessage()
      show_button
      DIV(class: 'formdiv') do
        InputBox()
        show_text
      end if MyStore.show_field

      description_table

      if MessageStore.messages?
          Messages()
      end

    end

  end

  def self.toggle_logo(ev)
    ev.prevent_default
    logo = Element['img']
    MyStore.show_field ? logo.hide('slow') : logo.show('slow')
  end

  def show_button
    BUTTON(class: 'btn btn-info') do
      MyStore.show_field ? "Click to hide HelloWorld input field" : "Click to show HelloWorld input field"
    end.on(:click) do |ev|
      ShowButtonOp.run(ev: ev)
    end
  end

  def show_text
    H1 { "#{MyStore.field_value}" }
  end


  def description_table
    DIV do
      BR{}
      TABLE(class: 'table table-hover table-condensed') do
        THEAD do
          TR(class: 'table-danger') do
            TD(width: '33%') { "SAVED HELLO WORLD" }
          end
        end
        TBODY do
          @helloworldmodels.each do |helloworldmodel|
            DescriptionRow(descriptionparam: helloworldmodel.description)
          end
        end
      end
    end
  end

end
