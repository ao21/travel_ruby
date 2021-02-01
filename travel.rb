class Plan
    attr_reader :name, :price
    def initialize(plan_params)
        @name = plan_params[:name]
        @price = plan_params[:price]
    end
end

class Agent
    attr_reader :plans
    def initialize(plan_params)
        @plans = []
        plan_params.map { |param| @plans << Plan.new(param) } 
    end

    def ask_plan
        puts "旅行プランを選択して下さい。"
        @plans.each.with_index(1) do |plan, i|
            puts "#{i}. #{plan.name}(#{plan.price}円)"
        end
    end

    def ask_count(chosen_plan)
        puts "#{chosen_plan.name}ですね。"
        puts "何名で予約されますか？"
    end

    def calculate_total_price(user)
        puts "#{user.count_people}名ですね。"
        total_price = user.chosen_plan.price * user.count_people
        if user.count_people >= 5
            total_price *= 0.9
            puts "5名以上なので10％割引となります"
        end
        puts "合計金額は#{total_price.floor}円になります。"
    end
end

class User
    attr_reader :chosen_plan, :count_people

    def choose_plan(plans)
        while true
            print "プランの番号を選択 > "
            select_num_plan = gets.to_i
            @chosen_plan = plans[select_num_plan - 1]
            break if (1..3).include?(select_num_plan)
            puts "1〜3の番号を入力して下さい。"
        end
    end

    def decide_count
        while true 
            print "人数を入力 > "
            @count_people = gets.to_i
            break if @count_people >= 1
            puts "1以上を入力して下さい。"
        end
    end
end

plan_params = [
    {name: "沖縄旅行", price: 10000},
    {name: "北海道旅行", price: 20000},
    {name: "九州旅行", price: 15000}
]

agent = Agent.new(plan_params)
user = User.new
agent.ask_plan
user.choose_plan(agent.plans)
agent.ask_count(user.chosen_plan)
user.decide_count
agent.calculate_total_price(user)