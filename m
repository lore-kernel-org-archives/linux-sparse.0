From: Christopher Li <sparse@chrisli.org>
Subject: Re: dependency tee from c parser entities downto token
Date: Fri, 4 May 2012 11:02:06 -0700
Message-ID: <CANeU7Q=5T2aV2NBwoC5hgtYHaNR1ndELtyy6t-s7C1bNgdTT0A@mail.gmail.com>
References: <4F967865.60809@gaisler.com>
	<CANeU7Qku=Zk3OfY3h45M+ecu11A6eTH0Y0+9wwj9Fmu8TyWwRw@mail.gmail.com>
	<CAEjhO7+EKvFHmpcFHrweGQEa4SHf62AAy5_SyhSxD1bcguafyw@mail.gmail.com>
	<CANeU7QkWbvT-NN5vm=JXnmfDpbzNzTjNYxkB8GJsKCysiOe8tQ@mail.gmail.com>
	<4FA38635.5060300@gaisler.com>
	<CANeU7QnVjEmZC2SNX-arWP7ovRx1mgNRyQSe7N2STGa-5u=i7A@mail.gmail.com>
	<4FA3B14A.3070609@gaisler.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-gh0-f174.google.com ([209.85.160.174]:61516 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752616Ab2EDSCH convert rfc822-to-8bit
	(ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Fri, 4 May 2012 14:02:07 -0400
Received: by ghrr11 with SMTP id r11so3043305ghr.19
        for <linux-sparse@vger.kernel.org>; Fri, 04 May 2012 11:02:06 -0700 (PDT)
In-Reply-To: <4FA3B14A.3070609@gaisler.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Konrad Eisele <konrad@gaisler.com>
Cc: Konrad Eisele <eiselekd@gmail.com>, linux-sparse@vger.kernel.org

On Fri, May 4, 2012 at 3:36 AM, Konrad Eisele <konrad@gaisler.com> wrot=
e:
> If it is a no-go it is a no-go.
> If there is no need for the tool i proposed, there is no need. :-)

I think you miss my point.  It is two separate thing. I already
confirm your macro dependency is useful. I want sparse
to support it.

My suggestion is merely how to support it. You purpose
embed the token inside AST. I purpose allow a macro_expand
call back hook.

=46rom my point of view, I can see using the macro_expand
call back hook to accomplish the same macro dependency
analyse, without significant impact the sparse internals.

If you think the macro_expend hook is not good enough,
please let me know where it is not sufficient.

> Still I try: Tokens dont sit around, they are released when
> the program finishes. Treating the preprocessing stage
> like nonexisting doesnt reflect the way most people use
> a compiler. They always use the preprocessor even if
> there might be the possibility to use the compiler with only
> a preprocessed file. Therefore tokens should sit around.

Yes token should sit around for your macro dependency
analyse. But I like it to be an option rather hard code the
token in the to the AST. Sparse is a library, there are several
program use it.

I see a way to allow your do want you want to do on the
macro dependency while not impact other program. Why
not give it a try? The point is, I don't see it is necessary
to force every one accept the expr->tok->pos. It is straightly
worse for program that don't care about the macro expand
dependency. As long as you can accomplish the same
dependency analyse, why do you care it is using the
"embed token" approach rather than macro_expand hook?

>> It is still too invasive. I don't want to keep<tok>->pos in the stat=
ements
>> and expression.
>
>
> If this is invasive a little less than this would mean no change at
> all.

Yes, it would be no change at all from the AST point of view if
we use the macro_expand hook. You just need to maintain
a hash table from old <pos> to new <pos> mapping with the
additional dependency information. You don't even need to
generate the pre-processed file explicitly. I am using that as
the thinking process how to get there.

>> The the second step is just parsing on the pre-processed file. Using
>> the macro expand history to map the position back to the original fi=
le.
>> In this way, you can do your dependency analyse with minimal
>> impact to sparse internals. The macro_expand hook can use to
>> do other useful stuff as well. Will that address your need?
>
>
> Thats not what I want, but rather what you want. If you
> want a macro expand history, it would be faster, easier simpler
> if you would hack it yourself, I dont want a macro expand,
> i have my tool htmltag for that already. I want a macro dependency tr=
ee.
> With only macro_expand hook and only file-scope <pos> it is not
> possible.

Nope, it is possible, that is what I am purposing. Sorry I previous
explain has been very high level, I haven't explain in the implementati=
on
detail of every stage.

So the first patch would be adding the macro_expand hook into sparse.
After a pre-processor macro expend, it will call the the macro_expand
hook if the user register one. (the hook is not NULL).

In the macro_expand hook, it will receive:
- macro before the expand,
- args for the macro
- replacement tokens after the expand.

This will give your macro dependency program a chance to
exam and manipulate the token before it get insert back
to original token list.


Here is how your macro dependency program can use the
macro_expand hook.

The program should create a internal stream call "<pre-processor>".
The content of the file is just the result of macro expand. One
macro at a line, the the order they are expanded. You can use the
pos->line to index when macro expand it is. Notice that you don't
need to actually write out the stream into disk.

Then, inside the macro_expand hook that receive the macro
expand call back.

There will be an array of data structure keep track of the
macro expand. The first macro expand is on the first element
of the array. Let's call this data structure "struct macro_deps".

Inside "struct macro_deps", it will keep track of the original
macro before the expand. The list of the tokens it depends on.
That is your dependency information.

It will allocate one "struct macro_deps" and fill it out, append
to the end of the array.

Before you macro_expand hook return, it walk the replacement
token. For each "token->pos" in the replacement token, it will
replace the stream number to to "pre-processor", and line number
to the index of the "struct macro_deps" in the array. Before the
replacement, if the original stream is already "<pre-processor>",
that means you are expanding the result from another macro expand.
Using the old pos->line to look up the inner macro expand, add
inner macro's dependency list into the current macro dependency list.

Then after the pre-processor stage. All the token from macro
expand will look as if they are expand from the "pre-processor"
file, line number can be use as index to lookup the array to find
out the detail of this macro expand.

Will that work for your dependency file. I notice that it not 100%
the same with your dependency, but with the intact history. You
should able to find that out.

> And: until I would have come up with something that would fit your
> requirements
> months would be gone. It seems that you know exactly how
> it should =A0be done, there is no way for me to know how
> you think a noninvasive solution would look like. The communication
> takes too long.

So here it is. I already give you the details of the implementation.
Of course, the first step for macro_expand hook is much smaller
scope. Please let me know that works or not.

>
> If there is no need for the tool i proposed, there is no need.
> At least I tried :-)

I already confirm that is useful. Just how to implement it.

Chris
--
To unsubscribe from this list: send the line "unsubscribe linux-sparse"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
