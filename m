From: Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: Re: [PATCH] compiler*.h: Add '__' prefix and suffix to all
 __attribute__ #defines
Date: Tue, 29 Oct 2019 02:38:54 +0000
Message-ID: <61eb73ad-5c30-0005-5031-6584df72ad5f@ramsayjones.plus.com>
References: <7a15bc8ad7437dc3a044a4f9cd283500bd0b5f36.camel@perches.com>
 <CANiq72=B6XKwfkC9L4=+OxWtjxCp-94TWRG1a=pC=y636gzckA@mail.gmail.com>
 <19fd23e98bab65a1ee624445193bd2ed86108881.camel@perches.com>
 <20191028221523.vlzdk6dkcglxei6v@desk.local>
 <00c5ef125a4e62f538de7ddddc9d8fe7085794a3.camel@perches.com>
 <20191028230349.xlhm42ripxktx43y@desk.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191028230349.xlhm42ripxktx43y@desk.local>
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, Joe Perches <joe@perches.com>
Cc: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, linux-sparse@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, linux-kernel <linux-kernel@vger.kernel.org>, clang-built-linux <clang-built-linux@googlegroups.com>
List-Id: linux-sparse@vger.kernel.org



On 28/10/2019 23:03, Luc Van Oostenryck wrote:
> On Mon, Oct 28, 2019 at 03:28:17PM -0700, Joe Perches wrote:
>> On Mon, 2019-10-28 at 23:15 +0100, Luc Van Oostenryck wrote:
>>> On Mon, Oct 28, 2019 at 10:59:47AM -0700, Joe Perches wrote:
>>>> On Mon, 2019-10-28 at 18:37 +0100, Miguel Ojeda wrote:
>>>>> Just in case: for these ones (i.e. __CHECKER__), did you check if
>>>>> sparse handles this syntax? (I don't recall myself if it does).
>>>>>
>>>>> Other than that, thanks for the cleanup too! I can pick it up in the
>>>>> the compiler-attributes tree and put it in -next.
>>>>
>>>> Thanks for asking and no, I did  not until just now.
>>>> Turns out sparse does _not_ handle these changes and
>>>> the checking fails for these __<changes>__.
>>>>
>>>> sparse would have to update parse.c or the __CHECKER__
>>>> changes would need to be reverted.
>>>>
>>>> Perhaps update parse.c like:
>>>
>>> ...
>>>
>>> Yes, this was missing. Thanks.
>>> Can I have your SoB for this?
>>
>> I'm not sure this actually works as there's
>> some possible sparse parsing changes in the
>> use of __context__.
> 
> Yes, indeed. The following shoud be squashed on top of
> your patch (not tested yet on linux side):
> 
> -- Luc
> 
> diff --git a/parse.c b/parse.c
> index 4464e2667..4b0a1566c 100644
> --- a/parse.c
> +++ b/parse.c
> @@ -345,6 +345,7 @@ static struct symbol_op goto_op = {
>  
>  static struct symbol_op __context___op = {
>  	.statement = parse_context_statement,
> +	.attribute = attribute_context,

Hmm, so why is do we have a context_op and a __context___op?

>  };
>  
>  static struct symbol_op range_op = {
> @@ -537,6 +538,7 @@ static struct init_keyword {
>  	{ "while",	NS_KEYWORD, .op = &while_op },
>  	{ "do",		NS_KEYWORD, .op = &do_op },
>  	{ "goto",	NS_KEYWORD, .op = &goto_op },
> +	{ "context",	NS_KEYWORD, .op = &context_op },
>  	{ "__context__",NS_KEYWORD, .op = &__context___op },

So, can '__context__' be used in a statement, as well as an
attribute, while 'context' can only be used in an attribute?

Confused.

ATB,
Ramsay Jones

>  	{ "__range__",	NS_KEYWORD, .op = &range_op },
>  	{ "asm",	NS_KEYWORD, .op = &asm_op },
> @@ -560,8 +562,6 @@ static struct init_keyword {
>  	{ "__bitwise__",NS_KEYWORD,	MOD_BITWISE,	.op = &attr_bitwise_op },
>  	{ "address_space",NS_KEYWORD,	.op = &address_space_op },
>  	{ "__address_space__",NS_KEYWORD,	.op = &address_space_op },
> -	{ "context",	NS_KEYWORD,	.op = &context_op },
> -	{ "__context__",NS_KEYWORD,	.op = &context_op },
>  	{ "designated_init",	NS_KEYWORD,	.op = &designated_init_op },
>  	{ "__designated_init__",	NS_KEYWORD,	.op = &designated_init_op },
>  	{ "transparent_union",	NS_KEYWORD,	.op = &transparent_union_op },
> 
