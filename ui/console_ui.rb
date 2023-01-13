# frozen_string_literal: true

require_relative 'base_console_ui'
require_relative '../player'
require_relative '../game'
require_relative '../dealer_bot'
class ConsoleUI < BaseConsoleUI

  EXIT_TERMINATOR = 'нет'

  def self.start
    puts 'Введите, пожалуйста, имя игрока'
    name = gets.chomp
    player = Player.new name
    dealer = Player.new 'Dealer'

    loop do
      game_session = Game.new(player, dealer)
      dealer_bot = DealerBot.new game_session

      loop do
        if game_session.over?
          draw_game_field game_session

          puts 'Выйграл дилер!' if game_session.winner == :dealer
          puts 'Выйграл игрок!' if game_session.winner == :player
          puts 'Ничья!' if game_session.winner == Game::DEAD_HEAT
          break
        end

        if game_session.player_move?
          draw_game_field game_session
          puts 'Ход игрока: '
          action = choose_variant(game_session.player.permitted_actions) { |key| actions[key] }
          game_session.move action
        elsif game_session.dealer_move?
          draw_game_field game_session
          puts 'Ход дилера: '
          dealer_move = dealer_bot.move
          puts "Дилер выбрал действие: '#{actions[dealer_move]}'"
          game_session.move dealer_move
        end
      end

      puts 'Хотите ещё сыграть?'
      break if gets.chomp.downcase == EXIT_TERMINATOR
    end
  end

  private_class_method def self.draw_game_field(game)
    puts %(
      Дилер - количество очков: #{current_points(game.dealer.points)}
      Текущий банк: #{game.dealer.player.bank}
      #{dealer_cards_images game}
      _______________________________________________________________
      #{cards_images game.player.hand}
      #{game.player.player.name} - количество очков: #{current_points(game.player.points)}
      Текущий банк: #{game.player.player.bank}
    )
  end

  private_class_method def self.current_points(points)
    "Количество очков: #{points}"
  end

  private_class_method def self.dealer_cards_images(game)
    return cards_images(game.dealer.hand) if game.over?

    cards_images(game.dealer.hand).gsub(/(\p{Any}\w)/, '*')
  end

  private_class_method def self.cards_images(cards)
    cards_images = []

    cards.each do |card|
      cards_images << "#{suit_map[card.suit]}#{card.rank}" if card.digit_rank?
      cards_images << "#{suit_map[card.suit]}#{images_ranks_map[card.rank]}" unless card.digit_rank?
    end

    cards_images.join ' '
  end

  private_class_method def self.images_ranks_map
    {
      ace: 'A',
      jack: 'J',
      queen: 'Q',
      king: 'K'
    }
  end

  private_class_method def self.suit_map
    {
      diamond: "\u2662",
      club: "\u2667",
      heart: "\u2661",
      spade: "\u2664"
    }
  end

  private_class_method def self.actions
    {
      add_card: 'Добавить карту',
      skip_move: 'Пропустить ход',
      open_cards: 'Вскрыть карты'
    }
  end
end
