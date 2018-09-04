import Foundation


class DebugChatRoomFactory {

    private var _nextRoomId: Int = 1
    private var _nextChatRoomId: Int = 1
    private var _nextCharaId: Int = 1
    private var _nextMessagerId: Int = 1
    private var _sampleChara: ChatChara!

    var sampleChara: ChatChara {
        get {
            if _sampleChara == nil {
                _sampleChara = self.charas(number: 1)[0]
            }
            return _sampleChara
        }
    }

    func chatSource(numCharas: Int, numMessages: Int) -> ChatSource {
        let factory = DebugChatRoomFactory()
        let room = factory.room()
        let charas = factory.charas(number: numCharas)
        let messages = factory.messages(number: numMessages, charas: charas)

        let chatSource = ChatSource(room: room, charas: charas, messages: messages, messageCreator: ChatMessageCreator())
        return chatSource
    }

    func room() -> ChatRoom {
        let room = _ChatRoomImpl(id: _nextRoomId, title: "秘密の部屋\(_nextRoomId)")
        _nextRoomId += 1
        return room
    }

    func charas(number: Int) -> [ChatChara] {
        return (0..<number).map { (_) -> ChatChara in
            let charaId = _nextCharaId
            _nextCharaId += 1
            return _ChatCharaImpl(id: charaId, nickname: _nameSamples[(charaId - 1) % _nameSamples.count])
        }
    }

    func messages(number: Int, charas: [ChatChara]) -> [MutableChatMessage] {
        return (0..<number).map { (index: Int) -> MutableChatMessage in
            let chara = charas[ Int(arc4random_uniform(UInt32(charas.count))) ]
            let text = _messageSamples[ Int(arc4random_uniform(UInt32(_messageSamples.count))) ]
            let messageId = _nextMessagerId
            _nextMessagerId += 1
            let order = index + ChatModelSpecialIDs.initialMessageOrder
            return MutableChatMessageImpl(id: messageId, order: order, chara: chara, text: text)
        }
    }

    func message(withText text: String, chara: ChatChara? = nil, order: Int = 1) -> MutableChatMessage {
        let message = MutableChatMessageImpl(id: _nextMessagerId, order: order,
                                       chara: chara ?? sampleChara, text: text)
        _nextMessagerId += 1
        return message
    }

    private let _nameSamples = [
        "ベンジャミン", "カミーラ", "チョウライ", "ツェリードニヒ", "ツベッパ", "タイソン", "ルズールス",
        "サレサレ", "ハルケンブルグ", "カチョウ", "フウゲツ", "モモゼ", "マラヤーム", "ワブル", "オイト"
    ]
    private let _messageSamples = [
        "わざとけられてやったわけだが",
        "そうだ！まず合格してからゴンを殺そう！",
        "もう遅いよ。\nもう知っちゃったんだから。\nオレもゴンも。",
        "ちなみにこの名はヒソカが子供の頃大好きだったチューインガムの商標名からとっている！",
        "そろそろ狩るか…♠",
        "念を使うと殺す\n声を出しても殺す",
        "相手が「もう帰ってくれ」って言ってからが本当の商談だぜ",
        "冥府に繋いでおかねばならないような連中が、この世で野放しになっているからだろう。",
        "おそろしく速い手刀。\nオレでなきゃ見逃しちゃうね。",
        "馬…鹿な。\n胆で…胆でオレが圧倒されるなど",
        "それを言ったら言えない内容を言ったも同然なのでやはり言えない。",
        "動機の言語化か…\n余り好きじゃないしな。\nしかし案外…いや、やはりというべきか、自分を掴むカギはそこにあるか…",
        "すまんウソだ\n2人は無傷だ\n許してくれ",
        "バカかお前\nそうなったらその後鎖野郎を殺して終いだろうが",
        "そん時は操作されてるヤツ全員ぶっ殺して旅団再生だ。\n簡単なことだろうが？"
    ]
}
