From: Konrad Eisele <eiselekd@gmail.com>
Subject: Re: dependency tee from c parser entities downto token
Date: Fri, 04 May 2012 23:46:37 +0200
Message-ID: <4FA44E3D.6020504@gmail.com>
References: <4F967865.60809@gaisler.com> <CANeU7Qku=Zk3OfY3h45M+ecu11A6eTH0Y0+9wwj9Fmu8TyWwRw@mail.gmail.com> <CAEjhO7+EKvFHmpcFHrweGQEa4SHf62AAy5_SyhSxD1bcguafyw@mail.gmail.com> <CANeU7QkWbvT-NN5vm=JXnmfDpbzNzTjNYxkB8GJsKCysiOe8tQ@mail.gmail.com> <4FA38635.5060300@gaisler.com> <CANeU7QnVjEmZC2SNX-arWP7ovRx1mgNRyQSe7N2STGa-5u=i7A@mail.gmail.com> <4FA3B14A.3070609@gaisler.com> <CANeU7Q=5T2aV2NBwoC5hgtYHaNR1ndELtyy6t-s7C1bNgdTT0A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:39917 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1759941Ab2EDVnH (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Fri, 4 May 2012 17:43:07 -0400
Received: by lahj13 with SMTP id j13so2333626lah.19
        for <linux-sparse@vger.kernel.org>; Fri, 04 May 2012 14:43:06 -0700 (PDT)
In-Reply-To: <CANeU7Q=5T2aV2NBwoC5hgtYHaNR1ndELtyy6t-s7C1bNgdTT0A@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Konrad Eisele <konrad@gaisler.com>, linux-sparse@vger.kernel.org

>
> I think you miss my point.  It is two separate thing. I already
> confirm your macro dependency is useful. I want sparse
> to support it.
>

Nice to hear this.
When I talk about macro dependency I mean not only the
macro expansion trace. I mean:
  1. The #if (and #include) nestings (with dependencies
     pointing to the macros used in the proprocessor line)
  2. The macro expansion trace
  3. The connection 1+2 into the AST.
Your macro_expand() hook addresses (2) only, but I cant
see how all the extra context for each token can be saved
in that sheme.
In my patch I have modeled (2) using 2 structs:
struct macro_expansion {
	int nargs;
	struct symbol *sym;
	struct token *m;
	struct arg args[0];
};
struct tok_macro_dep {
	struct macro_expansion *m;
	unsigned int argi;
	unsigned int isbody : 1;
	unsigned int visited : 1;
};
Each token from a macro expansion gets tagged with
tok_macro_dep. If it is an macro argument, <argi> shows the
index, if it is from the macro body <isbody> is 1.
Now, I didnt already think about special cases like
token concaternation, even more data is needed to
model this. Also when an macro argument is again used as an
macro argument inside the body expansion, then I kindof
loose the chain: I would also need a "token *dup_of" pointer
to point to the original token that the token is a copy
of (when arguments are created...) etc.

I have read your macro_expand() hook idea, however
when I understand it right you want to reuse position.stream and
position.line as a kind of pointer (to save the extra 4 bytes).
(Your goal is to minimize codebase change, however I wonder
weather you dont change semantic of struct position and then
need to change the code that uses struct position anyway...)
Maybe it is possible like this...I doubt it, where should
all the extra context, that each token has, be saved and
extracted from? using that sheme...

Maybe it is possible but I dont want to have as a design
goal to save 4 bytes (I'd use the void *custom sheme to
save all my extra data, also the pointers to tokens to
"sit around") and adujust everything else to
that. The consequence is that the code-complexity would
grow on the other end.

Here is my compromise then:
Keep the orignial "pos". But still grant me for
each struct a "void *custom" pointer that I can use
to store extradata i.e. pointer to token.

-- Konrad

> My suggestion is merely how to support it. You purpose
> embed the token inside AST. I purpose allow a macro_expand
> call back hook.
>
>> From my point of view, I can see using the macro_expand
> call back hook to accomplish the same macro dependency
> analyse, without significant impact the sparse internals.
>
> If you think the macro_expend hook is not good enough,
> please let me know where it is not sufficient.
>
>> Still I try: Tokens dont sit around, they are released when
>> the program finishes. Treating the preprocessing stage
>> like nonexisting doesnt reflect the way most people use
>> a compiler. They always use the preprocessor even if
>> there might be the possibility to use the compiler with only
>> a preprocessed file. Therefore tokens should sit around.
>
> Yes token should sit around for your macro dependency
> analyse. But I like it to be an option rather hard code the
> token in the to the AST. Sparse is a library, there are several
> program use it.
>
> I see a way to allow your do want you want to do on the
> macro dependency while not impact other program. Why
> not give it a try? The point is, I don't see it is necessary
> to force every one accept the expr->tok->pos. It is straightly
> worse for program that don't care about the macro expand
> dependency. As long as you can accomplish the same
> dependency analyse, why do you care it is using the
> "embed token" approach rather than macro_expand hook?
>
>>> It is still too invasive. I don't want to keep<tok>->pos in the statements
>>> and expression.
>>
>>
>> If this is invasive a little less than this would mean no change at
>> all.
>
> Yes, it would be no change at all from the AST point of view if
> we use the macro_expand hook. You just need to maintain
> a hash table from old<pos>  to new<pos>  mapping with the
> additional dependency information. You don't even need to
> generate the pre-processed file explicitly. I am using that as
> the thinking process how to get there.
>
>>> The the second step is just parsing on the pre-processed file. Using
>>> the macro expand history to map the position back to the original file.
>>> In this way, you can do your dependency analyse with minimal
>>> impact to sparse internals. The macro_expand hook can use to
>>> do other useful stuff as well. Will that address your need?
>>
>>
>> Thats not what I want, but rather what you want. If you
>> want a macro expand history, it would be faster, easier simpler
>> if you would hack it yourself, I dont want a macro expand,
>> i have my tool htmltag for that already. I want a macro dependency tree.
>> With only macro_expand hook and only file-scope<pos>  it is not
>> possible.
>
> Nope, it is possible, that is what I am purposing. Sorry I previous
> explain has been very high level, I haven't explain in the implementation
> detail of every stage.
>
> So the first patch would be adding the macro_expand hook into sparse.
> After a pre-processor macro expend, it will call the the macro_expand
> hook if the user register one. (the hook is not NULL).
>
> In the macro_expand hook, it will receive:
> - macro before the expand,
> - args for the macro
> - replacement tokens after the expand.
>
> This will give your macro dependency program a chance to
> exam and manipulate the token before it get insert back
> to original token list.
>
>
> Here is how your macro dependency program can use the
> macro_expand hook.
>
> The program should create a internal stream call "<pre-processor>".
> The content of the file is just the result of macro expand. One
> macro at a line, the the order they are expanded. You can use the
> pos->line to index when macro expand it is. Notice that you don't
> need to actually write out the stream into disk.
>
> Then, inside the macro_expand hook that receive the macro
> expand call back.
>
> There will be an array of data structure keep track of the
> macro expand. The first macro expand is on the first element
> of the array. Let's call this data structure "struct macro_deps".
>
> Inside "struct macro_deps", it will keep track of the original
> macro before the expand. The list of the tokens it depends on.
> That is your dependency information.
>
> It will allocate one "struct macro_deps" and fill it out, append
> to the end of the array.
>
> Before you macro_expand hook return, it walk the replacement
> token. For each "token->pos" in the replacement token, it will
> replace the stream number to to "pre-processor", and line number
> to the index of the "struct macro_deps" in the array. Before the
> replacement, if the original stream is already "<pre-processor>",
> that means you are expanding the result from another macro expand.
> Using the old pos->line to look up the inner macro expand, add
> inner macro's dependency list into the current macro dependency list.
>
> Then after the pre-processor stage. All the token from macro
> expand will look as if they are expand from the "pre-processor"
> file, line number can be use as index to lookup the array to find
> out the detail of this macro expand.
>
> Will that work for your dependency file. I notice that it not 100%
> the same with your dependency, but with the intact history. You
> should able to find that out.
>
>> And: until I would have come up with something that would fit your
>> requirements
>> months would be gone. It seems that you know exactly how
>> it should  be done, there is no way for me to know how
>> you think a noninvasive solution would look like. The communication
>> takes too long.
>
> So here it is. I already give you the details of the implementation.
> Of course, the first step for macro_expand hook is much smaller
> scope. Please let me know that works or not.
>
>>
>> If there is no need for the tool i proposed, there is no need.
>> At least I tried :-)
>
> I already confirm that is useful. Just how to implement it.
>
> Chris
>

