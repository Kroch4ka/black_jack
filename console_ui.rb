# frozen_string_literal: true
require_relative 'game'
require_relative 'player/player'
require_relative 'player/dealer'
class ConsoleUI
  @player = nil
  @dealer = nil
  @game = nil

  AGAIN_WORD = 'да'

  SUIT_MAP = {
    diamond: '<>',
    heart: '<3',
    club: '+',
    spade: '^'
  }.freeze

  RANK_MAP = {
    '2' => '2',
    '3' => '3',
    '4' => '4',
    '5' => '5',
    '6' => '6',
    '7' => '7',
    '8' => '8',
    '9' => '9',
    :jack => 'J',
    :queen => 'Q',
    :king => 'K',
    :ace => 'A'
  }.freeze
  def self.run
    puts 'Введите, пожалуйста, имя пользователя: '
    print 'Имя: '
    name = gets.chomp
    loop do
      @player = Player.new name
      @dealer = Dealer.new
      @game = Game.new(@player, @dealer)
      loop do
        player_actions = @game.player_actions
        dealer_actions = @game.dealer_actions
        draw_play_field
        case @game.current_move_player
        when @player
          player_action = choose_variant(player_actions) { |action| actions[action] }
          @game.send(player_action)
        when @dealer
          @game.send(dealer_actions.sample)
        end

        if @game.finished?
          show_winner
          break
        end
      end

      print 'Хотите сыграть ещё? - '
      play_again = gets.chomp.downcase

      break unless play_again == AGAIN_WORD
    end
  end

  private_class_method def self.draw_play_field
    draw_dealer_side
    puts
    puts '_________'
    puts
    draw_player_side
    puts
  end

  private_class_method def self.draw_player_side
    draw_cards @player.cards
    print "Количество очков: #{@player.total}"
  end

  private_class_method def self.draw_dealer_side
    if @game.finished?
      draw_cards @dealer.cards
    else
      draw_cards @dealer.cards, '*'
    end
    print "Количество очков: #{@dealer.total}"
  end

  private_class_method def self.draw_cards(cards, placeholder = nil)
    cards.each do |card|
      rank = rank_icon card.rank
      suit = suit_icon card.suit
      icon = placeholder || "#{rank}#{suit}"
      print " #{icon} "
    end
  end

  private_class_method def self.rank_icon(rank)
    RANK_MAP[rank]
  end

  private_class_method def self.suit_icon(suit)
    SUIT_MAP[suit]
  end

  private_class_method def self.draw_numbered_list(iterable, &block)
    iterable.each_with_index do |elem, index|
      puts "#{index + 1}) #{block_given? ? block.call(elem) : elem}"
    end
  end

  private_class_method def self.choose_variant(variants, &block)
    loop do
      draw_numbered_list(variants, &block)
      print 'Вариант: '
      chosen_number = gets.chomp.to_i
      if chosen_number.zero? || variants[chosen_number - 1].nil?
        puts 'Некорректный вариант'
        redo
      end

      return variants[chosen_number - 1]
    end
  end

  private_class_method def self.show_winner
    case @game.winner
    when @player then puts 'Победил игрок!'
    when @dealer then puts 'Победил дилер!'
    when Game::DRAW then puts 'Ничья!'
    else raise 'Undefined winner!'
    end
  end

  private_class_method def self.actions
    {
      skip_move: 'Пропустить ход',
      add_card: 'Добавить карту',
      open_cards: 'Открыть карты'
    }
  end
end
