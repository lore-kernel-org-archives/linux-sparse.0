From: Konrad Eisele <eiselekd@gmail.com>
Subject: Re: Fwd: dependency tee from c parser entities downto token
Date: Fri, 11 May 2012 23:48:27 +0200
Message-ID: <4FAD892B.8070709@gmail.com>
References: <4F967865.60809@gaisler.com> <CANeU7Qn7vUzLQAF6JGRECro_pPDnL7MCswkrNACe1wohLHZu7g@mail.gmail.com> <CANeU7QkJJx6A8zfZY9YRJ3GP-msxb3yjQpEO08RbNKE9asPTPA@mail.gmail.com> <4FA5B9E8.7010208@gmail.com> <CANeU7Qm-M7u0h6MswEMw3KZ7wxaxiikpChXJAuhkV0EzcHkH9A@mail.gmail.com> <4FA767BD.8060703@gaisler.com> <CANeU7Q=nHs+f1wKVM0bGDc-uxubBztPxXjiMvDRpph4RJWPHYg@mail.gmail.com> <4FA8BF7D.60606@gaisler.com> <CANeU7QkLrr1p8-Bofx9fnZ82BA2pc7sOxSOa-zim5NhWHXTNQA@mail.gmail.com> <4FAA3D50.8080901@gaisler.com> <CANeU7Q=mq1FsGViTp7L-83Wns6uDLcRKi7usNRiO1D3Ox_Dmww@mail.gmail.com> <4FAB5DEA.5060009@gaisler.com> <4FAB6268.7070908@gaisler.com> <CANeU7Qk-DTs+WL=u2g5WQ1L2J++ZBkCHi8_85bmUWto7rq0-9Q@mail.gmail.com> <4FAB8F9E.8040205@gaisler.com> <CANeU7QnnXk26ybnayuRZ2ZGSArMt1Bne4KGXxt+0d7tBjN=6Kw@mail.gmail
 .com> <4FABB132.1070308@gmail.com> <4FABB467.7030703@gmail.com> <CANeU7Q=_uqwk+ePbErQ9gsX3x945_gATUZ_mJeYuTo2SoYhCpQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:55062 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754718Ab2EKVow (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Fri, 11 May 2012 17:44:52 -0400
Received: by lbbgm6 with SMTP id gm6so2207997lbb.19
        for <linux-sparse@vger.kernel.org>; Fri, 11 May 2012 14:44:51 -0700 (PDT)
In-Reply-To: <CANeU7Q=_uqwk+ePbErQ9gsX3x945_gATUZ_mJeYuTo2SoYhCpQ@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Konrad Eisele <konrad@gaisler.com>, Linux-Sparse <linux-sparse@vger.kernel.org>

On 05/11/2012 09:40 PM, Christopher Li wrote:
> On Thu, May 10, 2012 at 5:28 AM, Konrad Eisele<eiselekd@gmail.com>  wrote:
>>
>>>> A change like this is bound to need some careful discussion and
>>>> planing. Yes, I am guilt of only accepting patches meet some subjective
>>>> stander of mine. But so is to any self respect project maintainers.
>>>> I would rather spend some time to do it right than commit some thing
>>>> I would regret later on.
>>>
>>>
>>> Do a B(B(x)) and your sym->parent linked-list will fail.
>
> You have a valid point that B(B(x)) will break the sym->parent list.
> I remove the sym->parent and just use a token_list to maintain the
> expanding macro. The macro is append to the list when enter and remove
> from the list when untaint token is reached. The change is in the
> same review branch.
>
> That should solve this problem?

This seems ok. expanding_macro has to be global not static to be
used... (?)

>
>> I have to revise my previous assumption though:
>>
>> #define B(y) A(x)
>> B(1)
>>
>> i thought that in the body expansion of B recursion is involved,
>> so that it would yield:
>>
>>   expand_macro(A);
>> expand_macro(B);
>>
>> but that was wrong, so its
>>
>> expand_macro(B);
>> expand_macro(A);
>
> That is right. The macro expansion has 3 stages. The first stage is
> expand the arguments list while the caller macro does not consider
> "tainted" during the argument expansion. The macro can recursively
> appear in the argument list. That is some thing I haven't consider
> previously.

I think the fact that argument expansion is recursive and
body expansion is non-recursive is one of the things that
make the preprocessor kindof hard to grasp.

>
> The second stage is just replace the expanded arguments into body.
>
> The third stage is rescan the replacement string for macro expand.
> In this third stage, the macro itself is consider tainted and can't be
> expand again during the rescan.
>
> Can you take a look at this modify version will fit your need or not?
> I am curious the part weather that will remove the need to add
> empty token to the list for expansion.

I cannot say this before I've tried it.

I'd like to straighten things out a bit: My last emails
where a bit too harsh and I'd like to apologize. Sorry
for that.

The next step then is: I'll write a patch to add a
test-prog that uses this api to trace the token generation
and generate a tree for it.
For a start I'll printout for all tokens of a preprocessor
run all macros-expansions that generated them.

Now, I've learned not to run too fast towards the
goal, (which is still "dependency tee from c parser entities downto
token"), maybe you can think about how to achieve the next steps
in an API :
- An #include #ifdef #else #endif pushdown-stack
   to record the nestings for each token
- How to connect all this to the AST.

-- Konrad

>
> In order words, can we design the API clever enough that you
> don't need to jump through hoops to handle the empty expansion
> token.
>
> Thanks
>
> Chris
>

