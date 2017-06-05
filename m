From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH 3/3] allow to normalize the pseudos
Date: Mon, 5 Jun 2017 21:54:23 +0200
Message-ID: <CAExDi1T7_8cniYqznotzTyJWSD_XJ1he2G-hpQJfTPc=EQ7HiQ@mail.gmail.com>
References: <20170603073416.66808-1-luc.vanoostenryck@gmail.com>
 <20170603073416.66808-4-luc.vanoostenryck@gmail.com> <CANeU7QnyLhPVAMDTGHLFnmgzcXWLeedr6mW=sCHZDL3C6igX=Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-qt0-f193.google.com ([209.85.216.193]:34619 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751188AbdFETyZ (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 5 Jun 2017 15:54:25 -0400
Received: by mail-qt0-f193.google.com with SMTP id o21so14762888qtb.1
        for <linux-sparse@vger.kernel.org>; Mon, 05 Jun 2017 12:54:24 -0700 (PDT)
In-Reply-To: <CANeU7QnyLhPVAMDTGHLFnmgzcXWLeedr6mW=sCHZDL3C6igX=Q@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Mon, Jun 5, 2017 at 8:45 PM, Christopher Li <sparse@chrisli.org> wrote:
> On Sat, Jun 3, 2017 at 12:34 AM, Luc Van Oostenryck
> <luc.vanoostenryck@gmail.com> wrote:
>> Using the output of test-linearize for testing is not
>> ideal because some details of this output are very dependent
>> to small changes in linearization or optimization while the
>> test in itself may very well not concerned about those changes.
>>
>> One of the things that are particulary sensitive to these changes
>> is the number of the pseudos (%r123, ...).
>>
>> Make these tests much less sensitive to these changes by adding
>> a normalization phase called just before emitting the output.
>> This normalization will renumber all the pseudos sequentially,
>> restarting at %r1 at each functions.
>
> I have a totally untested idea might be able to simplify this
> normalize process. It seems most of the pseudo output is
> come from show_pseudo(). We can use the generation number
> idea. All we need to do is just keep track of the base of the pseudo
> number. If you need new series of number just set the base to a number bigger
> than all of the pseudo number. That might means make alloc_pseudo::nr
> visible to other function we know what is the max pseudo number.
>
> Initialize the normalization is easy, just set
>      pseudo_base = ++pseudo_max;
>
> Then in show_pseudo() we can do the normalize as following:
>
> if (pseudo->nr - pseudo_base < 0)
>      pseudo->nr = ++pseudo_max;
>
> For the output of the number, we have:
> nr = pseudo->nr - pseudo_base;

The problem that the patch here tries to solve is that *between* different
versions of sparse, because of some subtle (or not so subtle) changes
in the details of linearization or the optimization, a function, while
having essentially the same intermediate code have in fact different
name (here just the number) for its pseudos.
And these differences are annoying when comparing results, during
development and for the test suite. Also, given the 'problem', it's very
fine to keep the code simple and only make the changes in a separate
pass only used for dev & test.

I have already tried several things in the past 6 months and anything
a bit smart had some problems, it's why, finally, I opted for the brute force
here in this patch.

I think that what you propose here, will just allow to have consecutive
pseudo numbers but I don't see how it will give the guarantee that
"same code" will give "same pseudo numbers" and this will be easily
be 'diffed out' so that only real differences will show up in diff output.

> One problem I can see if the pseudo->nr wrap around then it
> will create confusion. Maybe not some thing we need to worry
> about any time soon.
Indeed, with even with 32bit ::nr, I'm not really worried :)

> Another thing is the pseudo->nr only
> make sense in the function scope. We might able to use that
> to handle overflowing if it really became a problem.
Well, it's true for now that we could reset the counter at each function
and this would already 'solve' most of the cases I had. But what if
we begin to add a second pass of automatic inlining?
And keeping unique names every pseudo has advantages.

-- Luc
