From: Nicolai Stange <nicstange@gmail.com>
Subject: Re: [PATCH v2 07/13] evaluate: check static storage duration objects' intializers' constness
Date: Tue, 26 Jan 2016 17:08:16 +0100
Message-ID: <87h9i0b9xr.fsf@gmail.com>
References: <87twm1g1go.fsf@gmail.com> <87zivtemfq.fsf@gmail.com>
	<20160126014227.GE46188@macpro.local>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:36258 "EHLO
	mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964834AbcAZQIT (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Tue, 26 Jan 2016 11:08:19 -0500
Received: by mail-wm0-f65.google.com with SMTP id l65so18174046wmf.3
        for <linux-sparse@vger.kernel.org>; Tue, 26 Jan 2016 08:08:19 -0800 (PST)
In-Reply-To: <20160126014227.GE46188@macpro.local> (Luc Van Oostenryck's
	message of "Tue, 26 Jan 2016 02:42:28 +0100")
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Nicolai Stange <nicstange@gmail.com>, linux-sparse@vger.kernel.org, Christopher Li <sparse@chrisli.org>, Josh Triplett <josh@joshtriplett.org>

Luc Van Oostenryck <luc.vanoostenryck@gmail.com> writes:

> On Mon, Jan 25, 2016 at 03:57:45PM +0100, Nicolai Stange wrote:
>> Initializers of static storage duration objects shall be constant
>> expressions [6.7.8(4)].
>> 
>> Warn if that requirement is not met and the -Wstatic-initializer-not-const
>> flag has been given on sparse's command line.
>> 
>> Identify static storage duration objects by having either of
>> MOD_TOPLEVEL or MOD_STATIC set.
>> 
>> Check an initializer's constness at the lowest possible subobject
>> level, i.e. at the level of the "assignment-expression" production
>> in [6.7.8].
>> 
>> For compound objects, make handle_list_initializer() pass the
>> surrounding object's storage duration modifiers down to
>> handle_simple_initializer() at subobject initializer evaluation.
>
> Better here also to split the patch in two:
> one add the -W flag flag and another one which will use it.

Introducing a flag without any functionality attached to it feels wrong
for me. For example, where to update the manpage? Before or after actual
functionality is introduced?


>
> ch > Signed-off-by: Nicolai Stange <nicstange@gmail.com>
>> ---
>>  evaluate.c                  |  26 ++++++++++-
>>  lib.c                       |   2 +
>>  lib.h                       |   2 +-
>>  sparse.1                    |   7 +++
>>  validation/constexpr-init.c | 110 ++++++++++++++++++++++++++++++++++++++++++++
>>  5 files changed, 145 insertions(+), 2 deletions(-)
>>  create mode 100644 validation/constexpr-init.c
>> 
>> diff --git a/evaluate.c b/evaluate.c
>> index 70f419f..e3b08e4 100644
>> --- a/evaluate.c
>> +++ b/evaluate.c
>> @@ -2468,6 +2468,7 @@ static void handle_list_initializer(struct expression *expr,
>>  {
>>  	struct expression *e, *last = NULL, *top = NULL, *next;
>>  	int jumped = 0;
>> +	unsigned long old_modifiers;
>>  
>>  	FOR_EACH_PTR(expr->expr_list, e) {
>>  		struct expression **v;
>> @@ -2522,8 +2523,21 @@ found:
>>  		else
>>  			v = &top->ident_expression;
>>  
>> -		if (handle_simple_initializer(v, 1, lclass, top->ctype))
>> +		/*
>> +		 * Temporarily copy storage modifiers down from
>> +		 * surrounding type such that
>> +		 * handle_simple_initializer() can check
>> +		 * initializations of subobjects with static storage
>> +		 * duration.
>> +		 */
>> +		old_modifiers = top->ctype->ctype.modifiers;
>> +		top->ctype->ctype.modifiers =
>> +			old_modifiers | (ctype->ctype.modifiers & MOD_STORAGE);
>> +		if (handle_simple_initializer(v, 1, lclass, top->ctype)) {
>> +			top->ctype->ctype.modifiers = old_modifiers;
>>  			continue;
>> +		}
>> +		top->ctype->ctype.modifiers = old_modifiers;
>
> I don't understand why saving the mods is needed.
> It feels hackish to me. Isn't it because something is done wrongly at another
> level or maybe handle_simple_initializer() need an additional arg or so?

It _is_ hackish and I will change to add an additional argument to
handle_simple_initializer().

>> @@ -2633,6 +2647,16 @@ static int handle_simple_initializer(struct expression **ep, int nested,
> ...
>> +			warning(e->pos, "initializer for static storage duration object is not a constant expression");
>
> This is quite longish message.
> What about something like "non-constant initializer"?

That could be misleading:

  static const int a = 1;
  static const int b = a;

is forbidden, but obiously, 'a' is constant.

I'd like to keep the C99 term "constant expression", as well as
"initializer" and "static".

I could s/storage duration//.


>> diff --git a/lib.c b/lib.c
>> --- a/lib.c
>> +++ b/lib.c
>> @@ -241,6 +241,7 @@ int Wtypesign = 0;
>>  int Wundef = 0;
>>  int Wuninitialized = 1;
>>  int Wvla = 1;
>> +int Wstatic_initializer_not_const = 0;
>
> Here also it's quite longish. Yes I'm a lazy typer :)
> What about simply -Wconst-initializer ?

Josh Triplett wrote in his replies to my RFC series:
  Shouldn't it be something like -Wnon-constant-initializer,
  since that's what it checks for?

I conclude that we generally want to have -Wwhat-is-checked.
Now, it is the *non*-constant initializers that are being checked for.

Unfortunately, -WnoXXXXXXX seems to get misinterpreted as "switch
XXXXXXX" off by sparse's command line parsing.
In this case "switch n-constant-initializer off".
(I did not verify that by reading code, just by trying it out and
failing, so just a guess).

The -Wstatic-initializer-not-const choice made in the current series is
simply a workaround, any better suggestions welcome!

I'm also fine with -Wstatic-initializer.

Comments?

>   
> One thing that could be added (later and in another patch) is to 
> set it by default when the C99 variant is selected.
>
>>  enum {
>> diff --git a/lib.h b/lib.h
>> index 15b69fa..1b38db2 100644
>> --- a/lib.h
>> +++ b/lib.h
>> @@ -127,7 +127,7 @@ extern int Wtypesign;
>>  extern int Wundef;
>>  extern int Wuninitialized;
>>  extern int Wvla;
>> -
>> +extern int Wstatic_initializer_not_const;
>
> Better to leave the blank line where it was.

Yes, indeed :P.

>
> Luc
