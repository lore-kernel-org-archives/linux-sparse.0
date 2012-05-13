From: Konrad Eisele <eiselekd@gmail.com>
Subject: Re: Fwd: dependency tee from c parser entities downto token
Date: Sun, 13 May 2012 10:52:21 +0200
Message-ID: <4FAF7645.9040003@gmail.com>
References: <4F967865.60809@gaisler.com> <CANeU7QkJJx6A8zfZY9YRJ3GP-msxb3yjQpEO08RbNKE9asPTPA@mail.gmail.com> <4FA5B9E8.7010208@gmail.com> <CANeU7Qm-M7u0h6MswEMw3KZ7wxaxiikpChXJAuhkV0EzcHkH9A@mail.gmail.com> <4FA767BD.8060703@gaisler.com> <CANeU7Q=nHs+f1wKVM0bGDc-uxubBztPxXjiMvDRpph4RJWPHYg@mail.gmail.com> <4FA8BF7D.60606@gaisler.com> <CANeU7QkLrr1p8-Bofx9fnZ82BA2pc7sOxSOa-zim5NhWHXTNQA@mail.gmail.com> <4FAA3D50.8080901@gaisler.com> <CANeU7Q=mq1FsGViTp7L-83Wns6uDLcRKi7usNRiO1D3Ox_Dmww@mail.gmail.com> <4FAB5DEA.5060009@gaisler.com> <4FAB6268.7070908@gaisler.com> <CANeU7Qk-DTs+WL=u2g5WQ1L2J++ZBkCHi8_85bmUWto7rq0-9Q@mail.gmail.com> <4FAB8F9E.8040205@gaisler.com> <CANeU7QnnXk26ybnayuRZ2ZGSArMt1Bne4KGXxt+0d7tBjN=6Kw@mail.gmail.com> <4FABB132.1070308@gmail.com> <4FABB467.7030703@gmail.com> <CANe
 U7Q=_uqwk+ePbErQ9gsX3x945_gATUZ_mJeYuTo2SoYhCpQ@mail.gmail.com> <4FAD892B.8070709@gmail.com> <CANeU7QnEyUExcxaoVEeamhu1m+Z_pg0TpKBP00hh+gyPgdq66w@mail.gmail.com> <4FAEA208.3090601@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------050302060508070800010804"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:53368 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751924Ab2EMIsq (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sun, 13 May 2012 04:48:46 -0400
Received: by lbbgm6 with SMTP id gm6so2715090lbb.19
        for <linux-sparse@vger.kernel.org>; Sun, 13 May 2012 01:48:45 -0700 (PDT)
In-Reply-To: <4FAEA208.3090601@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Konrad Eisele <konrad@gaisler.com>, Linux-Sparse <linux-sparse@vger.kernel.org>

This is a multi-part message in MIME format.
--------------050302060508070800010804
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

On 05/12/2012 07:46 PM, Konrad Eisele wrote:
> On 05/12/2012 01:02 PM, Christopher Li wrote:
>> On Fri, May 11, 2012 at 2:48 PM, Konrad Eisele<eiselekd@gmail.com> wrote:
>>>
>>> This seems ok. expanding_macro has to be global not static to be
>>> used... (?)
>>
>> The expand_macro call back use the parent argument which get
>> from expanding_macro list. The caller should be able to create tree
>> from the leaf node using the parent pointer.
>>
>> Feel free to change to use the expanding_macro instead if that make
>> building the tree easier.
>>
>>> I think the fact that argument expansion is recursive and
>>> body expansion is non-recursive is one of the things that
>>> make the preprocessor kindof hard to grasp.
>>
>> The body expansion can't be recursive on same macro otherwise
>> it can result in unlimited expansion. The C stander specify
>> the macro expand this way.
>>
>>>
>>> I cannot say this before I've tried it.
>>>
>>> I'd like to straighten things out a bit: My last emails
>>> where a bit too harsh and I'd like to apologize. Sorry
>>> for that.
>>
>> No problem at all. I figure you just want to the patch to
>> get included.
>>
>>> The next step then is: I'll write a patch to add a
>>> test-prog that uses this api to trace the token generation
>>> and generate a tree for it.
>>> For a start I'll printout for all tokens of a preprocessor
>>> run all macros-expansions that generated them.
>>
>> That is great. I have a test-macro program in that
>> branch which is very close to print out all the tokens.
>
> Appended is a test-patch that adds test-mdep testcase.
> The file mdep.c is used to record that macro
> expansion, each token will have a reference to its
> source.
> test-mdep.c does pre-process (as test-macro.c) then
> prints out the token trace through macros for each
> token: @{ } is used to mark the active path.
>
> An example file is added: a.h
> $test-mdep a.h
> ...
> 0004: 8
> body in D1 :4 @{8} 10 9 5 <untaint: D1>
> arg0 in D1 :@{8} 10 9
> body in D0 :1 @{D1}(8 10 9) 2 D2(11) 3 <untaint: D0>
> a.h:6:6
> ...
> Token nr 4 of the preprocess stream is "8". The
> generation path of "8" is marked @{8}...
> Not 100%, still, I think already readable. (Actually
> the printout order should be reversed (starting from file scope
> and drilling down the macro expansions...)
>
> I still dont handle empty expansions. I'll see weather I can come up
> with something here...

I have thought about how to implement empty expansion tracing without
introducing a new token type. I came up with a solution, however I need
one callback, I called it substitute_arg(), see patch attached.
What do you think, is it apply-able?

I think I can use the address of the pointer to token (strict token
**,  which is normally &tok->next) as a hashing to propagate the empty
expansions...

Im not 100% shure it works but I need the extra hook to be able
to propagate the empty expansion from the arguments into the
substitution body...


>
>
>>
>>> Now, I've learned not to run too fast towards the
>>> goal, (which is still "dependency tee from c parser entities downto
>>> token"), maybe you can think about how to achieve the next steps
>>> in an API :
>>> - An #include #ifdef #else #endif pushdown-stack
>>> to record the nestings for each token
>>
>> Let me think about this. Just thinking out lound,
>> The #include and #ifdef can consider as a special kind
>> of predefine macro as well.
>
> No, only a linked list that model the nexting levels.
> Then a preprocessor hook that can register lookup_macro()
> macro lookups inside # preprocessor lines. An example
> makes it clear:
>
> #if defined(a) && defined(b)
> #if defined(c)
> #endif
> #if defined(e)
> #endif
> #endif
>
> Result in:
> [a b]+<-[c]
> +<-[e]
>
> This can be easily done with a push-pop brackets
> and a callback in lookup_macro().
>
>
> Also:
> #if defined(a)
> #elif defined(c)
> #endif
>
> [a]+<-[c]
>
> #if defined(a)
> #else
> #endif
>
> <-[empty]<-[a]
>
> ...
>
>
> Another point I also need is to have an option so that inside
> do_handle_define() the symbol structures are never reused but
> alloc_symbol() is always used for undef and define, this is
> because I need to be able to also track the undef and define
> history for a macro at a certain position. I think this should be
> easy to add because you just need to define define-undef on
> top of each other...
>
>
>>
>>> - How to connect all this to the AST.
>>
>> For symbol, it relative easy because symbol has pos range
>> and aux pointer.
>
> I thought about taking "struct symbol_list *syms = sparse(file)"
> as the root. Then mark all elements that are used by them as dependent.
> I dont have enough insight to say how I can determine things like
> which "static inline" are used or how to traverse the
> "typedef" dependency.
> The goal is to have a "shrink" application that can strip away
> all c-lines (pre-pre-process level) that are not used by a specific
> command invocation of the compiler. Also a tool that can quickly show
> for a specific identifier everything that is connected to it, again on
> pre-preprocessor source level. kind-of something like:
> ...
> func1() {
> struct string_list *filelist = NULL; int i;
> }
> ..
> I point to "string_list" and then all lines that are related
> to struct string_list, (#ifdef nestings, macros, all member typedefs)
> etc are shown and all the rest stripped away, again on human
> readable c source level.
>
>
>>
>> Do you need to attach the dependency for the statment and
>> expression as well?
>>
>> Chris
>>
>


--------------050302060508070800010804
Content-Type: text/plain; charset=ISO-8859-1;
 name="hook.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="hook.diff"

diff --git a/pre-process.c b/pre-process.c
index fb3430a..73a58be 100644
--- a/pre-process.c
+++ b/pre-process.c
@@ -573,6 +573,9 @@ static struct token **substitute(struct token **list, struct token *body, struct
 		case TOKEN_MACRO_ARGUMENT:
 			arg = args[body->argnum].expanded;
 			count = &args[body->argnum].n_normal;
+			if (preprocess_hook) {
+				preprocess_hook->substitute_arg (&added, &args[body->argnum].expanded);
+			}
 			if (eof_token(arg)) {
 				state = Normal;
 				continue;
@@ -650,7 +653,7 @@ static int expand(struct token **list, struct symbol *sym)
 		if (preprocess_hook && preprocess_hook->expand_arg) {
 			int i;
 			for (i = 0; i < nargs; i++) {
-				preprocess_hook->expand_arg(token, sym, i, args[i].orig, args[i].expanded);
+				preprocess_hook->expand_arg(token, sym, i, args[i].orig, &args[i].expanded);
 				free_preprocessor_line(args[i].orig);
 			}
 		}
diff --git a/token.h b/token.h
index 985d1f5..c45d6be 100644
--- a/token.h
+++ b/token.h
@@ -175,7 +175,8 @@ struct preprocess_hook {
 	void (*expand_macro)(struct token *macro, struct symbol *sym, struct token *parent,
 			     struct token **replace, struct token **replace_tail);
 	void (*expand_arg)(struct token *macro, struct symbol *sym, int arg,
-			   struct token *orig, struct token *expanded);
+			   struct token *orig, struct token **expanded);
+	void (*substitute_arg)(struct token **dest, struct token **argp);
 };
 
 #define MAX_STRING 4095

--------------050302060508070800010804--
