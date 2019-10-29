From: Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: Re: [PATCH] compiler*.h: Add '__' prefix and suffix to all
 __attribute__ #defines
Date: Tue, 29 Oct 2019 18:54:00 +0000
Message-ID: <ede574e5-d18d-f30c-b9f0-a39b73d57ff3@ramsayjones.plus.com>
References: <7a15bc8ad7437dc3a044a4f9cd283500bd0b5f36.camel@perches.com>
 <CANiq72=B6XKwfkC9L4=+OxWtjxCp-94TWRG1a=pC=y636gzckA@mail.gmail.com>
 <19fd23e98bab65a1ee624445193bd2ed86108881.camel@perches.com>
 <20191028221523.vlzdk6dkcglxei6v@desk.local>
 <00c5ef125a4e62f538de7ddddc9d8fe7085794a3.camel@perches.com>
 <20191028230349.xlhm42ripxktx43y@desk.local>
 <61eb73ad-5c30-0005-5031-6584df72ad5f@ramsayjones.plus.com>
 <20191029080701.qpvscbz3xptadhbd@ltop.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191029080701.qpvscbz3xptadhbd@ltop.local>
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Joe Perches <joe@perches.com>, Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, linux-sparse@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, linux-kernel <linux-kernel@vger.kernel.org>, clang-built-linux <clang-built-linux@googlegroups.com>
List-Id: linux-sparse@vger.kernel.org



On 29/10/2019 08:07, Luc Van Oostenryck wrote:
> On Tue, Oct 29, 2019 at 02:38:54AM +0000, Ramsay Jones wrote:
>> On 28/10/2019 23:03, Luc Van Oostenryck wrote:
>>> diff --git a/parse.c b/parse.c
>>> index 4464e2667..4b0a1566c 100644
>>> --- a/parse.c
>>> +++ b/parse.c
>>> @@ -345,6 +345,7 @@ static struct symbol_op goto_op = {
>>>  
>>>  static struct symbol_op __context___op = {
>>>  	.statement = parse_context_statement,
>>> +	.attribute = attribute_context,
>>
>> Hmm, so why is do we have a context_op and a __context___op?
>>
>>>  };
>>>  
>>>  static struct symbol_op range_op = {
>>> @@ -537,6 +538,7 @@ static struct init_keyword {
>>>  	{ "while",	NS_KEYWORD, .op = &while_op },
>>>  	{ "do",		NS_KEYWORD, .op = &do_op },
>>>  	{ "goto",	NS_KEYWORD, .op = &goto_op },
>>> +	{ "context",	NS_KEYWORD, .op = &context_op },
>>>  	{ "__context__",NS_KEYWORD, .op = &__context___op },
>>
>> So, can '__context__' be used in a statement, as well as an
>> attribute, while 'context' can only be used in an attribute?
> 
> Yes, indeed.

OK, so I wasn't quite as confused as I thought! ;-)

> '__context__' was only parsed as a statement and 'context'
> only as an attribute. But now we also want to be able to use
> '__context__' as an attribute (because 'context' is not a
> reserved keyword and can thus be a used defined macro).
> 
> There is no reason, though, we should now also want to use
> 'context' as a statement since it's a sparse extension. Hence
> adding attribute_context to '__context___op' and keeping
> 'context_op' as such (but moving them together).

Thanks for the explanation.

ATB,
Ramsay Jones
