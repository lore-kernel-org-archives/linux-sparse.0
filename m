From: "Alexey Zaytsev" <alexey.zaytsev@gmail.com>
Subject: Re: Odd sparse behaviour
Date: Mon, 7 Jul 2008 22:09:56 +0400
Message-ID: <f19298770807071109s529f2215sc4b7d7f1f7011208@mail.gmail.com>
References: <48713A18.7050103@cowlark.com>
	 <1215452912.3003.27.camel@josh-work.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from yx-out-2324.google.com ([74.125.44.30]:55856 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756816AbYGGSJ6 (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Mon, 7 Jul 2008 14:09:58 -0400
Received: by yx-out-2324.google.com with SMTP id 8so475052yxm.1
        for <linux-sparse@vger.kernel.org>; Mon, 07 Jul 2008 11:09:57 -0700 (PDT)
In-Reply-To: <1215452912.3003.27.camel@josh-work.beaverton.ibm.com>
Content-Disposition: inline
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Josh Triplett <josht@linux.vnet.ibm.com>
Cc: David Given <dg@cowlark.com>, linux-sparse@vger.kernel.org

On Mon, Jul 7, 2008 at 9:48 PM, Josh Triplett <josht@linux.vnet.ibm.com> wrote:
> On Sun, 2008-07-06 at 22:33 +0100, David Given wrote:
>> I've found a couple of places where sparse behaves rather oddly.
>>
>> Firstly, if you declare something static, and then try to define it
>> later, sparse appears to get confused:
>>
>> ---snip---
>> static int i;
>> int i = 0;
>> ---snip---
>>
>> $ ./test-parsing test.c
>> test.c:2:5: warning: symbol 'i' was not declared. Should it be static?
>>
>> .align 4
>> int static [signed] [toplevel] i,
>> .align 4
>> int [signed] [addressable] [toplevel] i =
>>       movi.32         v1,$0
>>
>> Enumeration of the list of defined symbols shows two different symbols
>> with the name 'i'. This isn't entirely obvious when using the test tools
>> as, of course, two strings with the same value look the same! This is
>> causing me issues with forward declarations of static functions:
>>
>> static void foo();
>> { ... foo(); ... }  // calls static foo
>>
>> foo() {}            // defines extern foo
>> { ... foo(); ... }  // calls extern foo
>>
>> This then leads to link errors as static foo hasn't been found.
>
> I've observed this problem before.  Alexey Zaytsev reported this as
> well.  I think he may have a fix in the works.  Alexey?

I did some research, but no working patch so far. If you'd like to
look at it yourself, I'd suggest lookign at parse.c:external_declaration().
Right now it reads:

        /* Parse declaration-specifiers, if any */
        token = declaration_specifiers(token, &ctype, 0);
        decl = alloc_symbol(token->pos, SYM_NODE);
        decl->ctype = ctype;
        token = declarator(token, decl, &ident);
        apply_modifiers(token->pos, &decl->ctype);

I think that after calling declaration_specifiers(), we should
check if token_type(token) == TOKEN_IDENT and lookup
the symbol in the relevant namespaces. If it is found, we shoud
check if the types and produce soe warnings. And reuse the
symbol, if the types match.

Josh, does this make any sense?

>
>> The second issue is with the following piece of C99 code:
>>
>> ---snip---
>> extern void nop(void)
>> void bar(void)
>> { for (int i=0; i<10; i++) nop(); }
>> ---snip---
>>
>> $ ./test-linearise test.c
>> test.c:3:6: warning: symbol 'bar' was not declared. Should it be static?
>> bar:
>> .L0xb7d7600c:
>>       <entry-point>
>>       br          .L0xb7d76038
>>
>> .L0xb7d76038:
>>       call        nop
>>       br          .L0xb7d76038
>>
>> The for loop seems to silently turn into an infinite loop. Which did
>> cause one of my benchmarks to, um, produce rather poor results...
>
> No kidding.  An interesting bug.  Does this go away if you declare "int
> i" at the top of the function?
>
>> (You may be interested to know that my compiler is now producing
>> working, running code for non-trivial apps. Big chunks of it do need
>> throwing away and rewriting, but it's actually *working*!)
>
> Awesome!
>
> - Josh Triplett
>
>
>
