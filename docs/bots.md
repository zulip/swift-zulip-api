# Bots

`swift-zulip-api` supports writing Bots to automatically respond to users. Each
bot will respond when it is mentioned in a message.

## Running a Bot

 1. Register a bot with your Zulip account. Go to
    *Settings&nbsp;>&nbsp;Your&nbsp;bots* and add a new one. The *name* of the
    bot is what users will see, but is not related to which bot is used.

 2. Call

    ```bash
    swift run SwiftZulipAPIBotRunner
    ```

    from the terminal.

    You will be prompted for some information before the bot
    starts:

     - The *email* and *API key* for your specific bot are listed on the *Your
       bots* page.

     - The realm URL is the URL you access Zulip from (e.g.
       `https://chat.zulip.org`).

     - Each bot has its own name. The lists of bots and their names is at the
       bottom of this document.

     - Each bot requires different configuration options. You can see the config
       necessary in docs as well. From the command line, config should be given
       as JSON (so no configuration would be `{}`).

    The bot will run until you stop the terminal process (or will output an
    error if there is one).

## Writing a Bot

Writing a new bot is relatively simple, since all bots follow the same `Bot`
protocol.

 1. Create a new file in
    [`bots/sources/SwiftZulipAPI/bots/`](https://github.com/skunkmb/swift-zulip-api/blob/master/bots/sources/SwiftZulipAPI/bots)
    with the name of your new bot.

 2. Make a new class. It should adopt the `Bot` protocol. It is required to
    implement the functions:

     1. ```swift
        init(config: [String: Any])
        ```

        Initializes a bot.

         - `config`: A dictionary of config settings, which can be used for
           different things by different bots.

            - For some bots, config may not be necessary, so the value can be
              ignored.

            - For other bots, it may be useful to set `self.config = config`, so
              that it can be used later.

     2. ```swift
        handleMessage(
            message: [String: Any],
            contentWithoutMention: String,
            callback: (String?, Error?) -> Void
        )
        ```

        Handles and makes a response to a message.

         - `message`: The message to respond to.

         - `contentWithoutMention` The content of `message`, but with the bot's
            mention removed as well as a space between the mention and the main
            content (if there is one). E.g., `example` if the full content is
            `@**Some Bot** example`.

         - `callback`: A callback, which will be passed the content of the
           response, or an error if there is one.

    For a simple example of a `Bot` class, see
    [`echo-bot`](https://github.com/skunkmb/swift-zulip-api/blob/master/bots/sources/SwiftZulipAPI/bots/echo-bot.swift).

 3. Add the bot to the bot name `switch` statement at the bottom of
    [`bots/runner/SwiftZulipAPI/main.swift`](https://github.com/skunkmb/swift-zulip-api/blob/master/bots/runner/SwiftZulipAPI/main.swift).

 4. Add some tests for the bot in
    [`bots/tests/SwiftZulipAPI/bots/`](https://github.com/skunkmb/swift-zulip-api/blob/master/bots/tests/SwiftZulipAPI/bots/).

    See
    [the `echo-bot` tests](https://github.com/skunkmb/swift-zulip-api/blob/master/bots/tests/SwiftZulipAPI/bots/echo-bot.swift)
    for an example.

 5. Add docs for the bot at the bottom of this document.

## Full Bot Docs

### `echo-bot`

A bot that responds with the same content that is sent to it, for demonstration
purposes.

#### Config

*No config is necessary.*

#### Example Usage

 > @**Echo Bot** Testing

↓

 > Testing
