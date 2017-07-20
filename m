From: Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: Re: [PATCH 2/2] pre-process: replace use of vla's with heap
 allocation
Date: Thu, 20 Jul 2017 17:44:48 +0100
Message-ID: <cce05c3f-a309-9fa7-3107-e6e6831972aa@ramsayjones.plus.com>
References: <5ffb141e-fdb2-a1b8-a5b7-c922d1a9ef08@ramsayjones.plus.com>
 <CANeU7QkmtVVPhhanR2M7=3P9cCse0B9rXJSfx8c1NCC4aHZ-qw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from avasout06.plus.net ([212.159.14.18]:38202 "EHLO
        avasout06.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755346AbdGTQox (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 20 Jul 2017 12:44:53 -0400
In-Reply-To: <CANeU7QkmtVVPhhanR2M7=3P9cCse0B9rXJSfx8c1NCC4aHZ-qw@mail.gmail.com>
Content-Language: en-GB
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, Sparse Mailing-list <linux-sparse@vger.kernel.org>



On 20/07/17 13:02, Christopher Li wrote:
> On Wed, Jul 19, 2017 at 4:13 PM, Ramsay Jones
> <ramsay@ramsayjones.plus.com> wrote:
>>
>> The 'selfcheck' make target issues warnings about using vla's in the
>> pre-processor code, like so:
>>
>>        CHECK    pre-process.c
>>   pre-process.c:712:25: warning: Variable length array is used.
>>   pre-process.c:2019:28: warning: Variable length array is used.
>>
>> A Makefile change to pass '-Wno-vla' to sparse when processing this
>> source file (or all source files) may be a better solution than the
>> one given here.
>>
>> Replace the use of vla's with heap allocation. This has performance
>> implications (although it may me safer), due to the dynamic memory
>> allocation and the zero initialisation of the memory (using calloc).
>> I have not done any timing measurements to see if this is a problem
>> in practice.
> 
> I purpose the following patch. Make the expand using stack for small
> argument numbers. That should not have much performance impact
> at all because long macro arguments are rare.

My first reaction was surprise that you didn't go for the Makefile
idea - setting '-Wno-vla' would be the simplest solution. ;-)

I can understand warning about vla usage (especially in the kernel),
but it a 'standard' supported feature. I don't use them myself, partly
because they are a 'relatively' new feature, but also because I have had
some bad experience in the past using alloca in similar circumstances.

My second thought was, have you done some timing tests (no I haven't)
and determined that this causes a noticeable slowdown?

> Incremental patch follows. If you think that is fine, I will apply the
> combined patch as yours.
> 
>> +       if (nargs > 0)
>> +               args = calloc(nargs, sizeof(*args));
> 
> Need to check alloc failed.

Yes, indeed! *blush*

>> +
>>         if (sym->arglist) {
>>                 if (!match_op(scan_next(&token->next), '('))
>>                         return 1;
> 
> Need to free alloc memory.

Ahem, I obviously didn't think about this patch too much! :-D

> 
> 
>> +       if (nargs > 0)
>> +               args = calloc(nargs, sizeof(*args));
> 
> Same here need to check alloc failed.
> 
> Chris
> 
> Purposed incremental fix up follows:

Hmm, dunno.

I did, briefly, think about adding an 'array' capability to the
sparse ALLOCATOR facility (you can only allocate single instances
from the current allocators - ignoring 'string' and 'bytes').

ATB,
Ramsay Jones

> 
> --- sparse.chrisl.orig/pre-process.c
> +++ sparse.chrisl/pre-process.c
> @@ -709,21 +709,30 @@ static int expand(struct token **list, s
>   struct ident *expanding = token->ident;
>   struct token **tail;
>   int nargs = sym->arglist ? sym->arglist->count.normal : 0;
> - struct arg *args = NULL;
> +#define ARG_LIMIT 8
> + struct arg arg_array[ARG_LIMIT], *args = arg_array;
> + int err = 0;
> 
>   if (expanding->tainted) {
>   token->pos.noexpand = 1;
>   return 1;
>   }
> 
> - if (nargs > 0)
> + if (nargs >= ARG_LIMIT) {
>   args = calloc(nargs, sizeof(*args));
> + if (!args)
> + die("calloc(%d, %lu) failed", nargs, sizeof(*args));
> + }
> 
>   if (sym->arglist) {
> - if (!match_op(scan_next(&token->next), '('))
> - return 1;
> - if (!collect_arguments(token->next, sym->arglist, args, token))
> - return 1;
> + if (!match_op(scan_next(&token->next), '(')) {
> + err = 1;
> + goto exit;
> + }
> + if (!collect_arguments(token->next, sym->arglist, args, token)) {
> + err = 1;
> + goto exit;
> + }
>   expand_arguments(nargs, args);
>   }
> 
> @@ -741,9 +750,11 @@ static int expand(struct token **list, s
>   (*list)->pos.whitespace = token->pos.whitespace;
>   *tail = last;
> 
> - free(args);
> +exit:
> + if (nargs >= ARG_LIMIT)
> + free(args);
> 
> - return 0;
> + return err;
>  }
> 
>  static const char *token_name_sequence(struct token *token, int
> endop, struct token *start)
> @@ -2024,8 +2035,11 @@ static void dump_macro(struct symbol *sy
>   struct token **args = NULL;
>   struct token *token;
> 
> - if (nargs > 0)
> + if (nargs > 0) {
>   args = calloc(nargs, sizeof(*args));
> + if (!args)
> + die("calloc %ld", nargs * sizeof(*args));
> + }
> 
>   printf("#define %s", show_ident(sym->ident));
>   token = sym->arglist;
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sparse" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
