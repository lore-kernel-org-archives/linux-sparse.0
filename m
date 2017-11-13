From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH 0/2] Fix illegal simplification of volatile stores
Date: Mon, 13 Nov 2017 09:27:26 +0800
Message-ID: <CANeU7Qn0o+_wVaq3Q9usBduq0Jx=K=Sc7Kq70sdeW=+QEsyQrg@mail.gmail.com>
References: <20171111162500.69476-1-luc.vanoostenryck@gmail.com>
 <CANeU7QnJgGdWtM3KkJOtWG72v_soBZfeXGkqMUmQcv-L=NM5oQ@mail.gmail.com>
 <20171111225218.m3cqbid6ug7r57jw@ltop.local> <CANeU7QnSOro=WkH_VBoGGCPonAaw-hMGJTVG_8OQPzm19zKvaQ@mail.gmail.com>
 <CAExDi1QwQFQ+dci=j5KrB6_Q65JD496J0U4w_Hv7usHwb-qj-g@mail.gmail.com>
 <CANeU7Q=o+90-BL9RSwONBLmVfvD-RWkDubBskksuvLah1zi8fg@mail.gmail.com>
 <20171112111039.qo6uan73jazriu7n@ltop.local> <CANeU7QnLjm1cSD-KY49wXrx1WPNzoXu8TXuym7gei2Aioe+mTQ@mail.gmail.com>
 <20171112184811.ciaoudtwo5bazaj6@ltop.local> <CANeU7QnW5x7nmrsXdR9WP+dtbGsZdYsp4nk4fUn0NZx8SnGwkg@mail.gmail.com>
 <20171112230609.ch3u4vfnasaex3sz@ltop.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-yw0-f180.google.com ([209.85.161.180]:50455 "EHLO
        mail-yw0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751125AbdKMB12 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 12 Nov 2017 20:27:28 -0500
Received: by mail-yw0-f180.google.com with SMTP id i198so12233149ywe.7
        for <linux-sparse@vger.kernel.org>; Sun, 12 Nov 2017 17:27:27 -0800 (PST)
In-Reply-To: <20171112230609.ch3u4vfnasaex3sz@ltop.local>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Mon, Nov 13, 2017 at 7:06 AM, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
>
> But did you sent this review out? When?
>

I start to send review for this series out at Oct 30 and Nov 5.

For this peculiarity OP_PUSH, I thought I have send out already
but I just find a few days ago I did not. That was my bad.

But the whole process of evaluating your OP_PUSH start much
earlier. Not only do I join the discussion of the thread that
cause the OP_PUSH in the first place. I also purpose the
alternative patch at Aug 13.
https://patchwork.kernel.org/patch/9897573/

That is before you send out the git pull for llvm-fix at Sep.

You drop out of the email discussion.
There is many level of participation of the review process.
Email discussion is one. Sending out patches are the higher
level of participation.

Those email are not directly response to your llvm-fix.
But you know very well those are alternative approach to
OP_PUSH. You make claim that I did not response to
your git pull request for 8 month and you know that is not true.
It just more mud on the wall.

> I have already explained that giving some review in a reasonable
> amount of time after a series is first submitted is one thing.
> Asking for cosmetic changes (or what I tend to call "surface"
> changes) months later is another thing.
> The difference being that new code is developed on top
> of the old one. And yes, it's always possible to rebase
> everything, when it's valuable functional changes.

But the OP_PUSH vs OP_SETVAL.size is not surface change.
Your OP_PUSH break the byte code compatibility and
increase the instruction count.

I would let the surface change slide and just merge it
consider you have other change depend on it.

>
>> You are making your series not touchable. Amount all
>> all patch email send over the mailing list. How much can
>> I actually pull from according our agreement? Zero.
>
> I consider our agreement as finished.

Per our agreement. If I am not complete happy about any
thing in the series. The solutions is I don't pull and you are
going to purpose a new git pull request address my concerns.

Given that you have patch depend on it and I have this
in my backlog for a long time. I am willing to help out and
create fix up patches.

I do care about make things easy for you. But I have to make
a stand on some critical issue like OP_PUSH.

>
> The reason why I insisted about the llvm series is that
> because it's the oldest and a lot of further development
> depends on it.

I understand the pain. But is it possible for you to pick a stable
point as your base like master? In the old days the master
update not very frequently. Now days master are update
reasonably. Wouldn't master serve better as base for the
topic branch?

>
> You seem to have missed the word "code" here above.
> I'll rephrase:
>    I don't comment on code if I disagree with the code
>    or if the code is not to my taste but still I find
>    the code valuable enough that I don't want to block
>    it's inclusion.

That is just a cryptic way of saying I don't like your code.

>
>> And what is the reason for not reviewing this:
>> "Simplify expr->flags assignement":
>>
>> https://patchwork.kernel.org/patch/10042019/
>
> That's exactly the kind of code I find completly without any
> value:
> - if you make some measurement, please add the mean value
>   *AND* the standard deviation
> - it's a change for some "optimization" but you state yourself
>   in the mail that you don't know if it make any kind of difference.

OK. That establish you did saw  the email and chose not
to response to it.

Let me ask this question. If this exact patch is not send by me,
It is send by let say  Ramsay Jones. Would it be much more likely
you did reply to the email? I think so. After all, that did match you
behavior pattern promptly reply to patch by others just not me.

That is the different between you and me. I did not response
due to lack of time. I treat your patch the same way as mine.
If I am not happy about it, I want to make it better. You ignore patch
intentionally and has strong correlation base on me send the patch or not.

And you are still saying this is not personal?

> I don't insist on anything. You have said yourself that I gave no
> arguments and it's kinda true.
> What I have is a working, integrated and tested set of patches.

Thanks. Will do then.

> Funny thing when you have yourself said in late July:
>         Warning ahead, the OP_PUSH need more discussion.
>         It is not going to apply very quickly.
>
> To which I replied:
>         The fact that you said in advance, without any
>         kind of discussion, and without having participated
>         in any sort of way in the initial discussion, that
>         it will be a slow thing (thus a painful thing) make me
>         just want to drop the whole thing and move on with
>         something else.
>
>
> I've now spend enough time with this and this is my last email
> on the whole subject.

Guilty.

That is why I did dig out the discussion and have exchange
some email with you.  I point out your mistake of using earler
Linus' email to counter his own later suggestion.
Your don't have an validate argument and you are the last one
did not response to my reasoning.

Further more, I send out alternative patch to match my suggestion.
You did not follow up.

Luc, I do have a lot of respect for you. Thank you for your contribution
to sparse.

I do want to merge your patches. I do want to do it in a way
that is less painful for you.

I might be a moron of insist certain things at times. Actually,
remove the might, I am.

I do mean to do good with sparse with the best intentions.
I don't want to screw you and I don't want to fork sparse.

Let me see what I can do with the OP_SETVAL.size.

Chris
