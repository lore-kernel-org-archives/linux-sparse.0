From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH] ignore VOID when trying to if-convert phi-nodes
Date: Thu, 11 May 2017 20:50:44 +0200
Message-ID: <CAMHZB6HJ7Rz-S06NF7KZ91MCovnhcOfCHf7F88+vY8vhV8TcWA@mail.gmail.com>
References: <20170509220619.72375-1-luc.vanoostenryck@gmail.com> <CANeU7QmM5Rd6o8keZMHL-N2=_dKZg4iPg=M-FAYjqRpEavrj3Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-qk0-f176.google.com ([209.85.220.176]:33126 "EHLO
        mail-qk0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932391AbdEKSuq (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 11 May 2017 14:50:46 -0400
Received: by mail-qk0-f176.google.com with SMTP id y201so30510556qka.0
        for <linux-sparse@vger.kernel.org>; Thu, 11 May 2017 11:50:45 -0700 (PDT)
In-Reply-To: <CANeU7QmM5Rd6o8keZMHL-N2=_dKZg4iPg=M-FAYjqRpEavrj3Q@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Thu, May 11, 2017 at 7:13 PM, Christopher Li <sparse@chrisli.org> wrote:
> Over all looks good. Some minor comment follows.
>
> On Tue, May 9, 2017 at 3:06 PM, Luc Van Oostenryck
> <luc.vanoostenryck@gmail.com> wrote:
>> +/*
>> + * Essentially the same as linearize_ptr_list()
>> + * but ignoring VOID.
>> + * Returns 0 if the the list contained the expected
>> + * number of element, 1 or -1 if there was more or less.
>> + */
>> +static int get_phi_list(pseudo_t array[], int n, struct pseudo_list *list)
>
> The function name does not reflect that it is going to skip the VOID entry

Well yes, but I wasn't ready to use a name like 'get_real_phi_list()' or
something like this. These VOIDs really mean 'there is no element here/
the entry has been removed'. So, I think that it's the right thing to put
the VOID thing in the comment and have such a function name.

But I can look after another name.

> and the API to return value is a little bit non straight forward. e.g.
> If the result entries is less than the quest one, there is no way to get
> know the exact number of entry returned.

Yes, I know.
My first version did this but then I changed my mind because
it was slightly easier so and having the exact number returned
is not needed (it's not like we're we're doing some dynamic allocation
and redo a malloc() with the right number if the initial guess was too
small). The only thing that really matters here is if the effective number
of phisrc is the one we're interested in: 2.

OTOH, I don't have a strong opinion on how it should best be done
and other uses can maybe be interested in the exact number.

> Just RFC here, how about having one helper function to do
> the normal linearize ptr and skip the VOID entry. Which return how
> many entry it scanned. (it return n+1 if there is more than n request one).
>
> Then the second function you can do the compare to "n" thing.
> After inline it would behave exactly like your current function.

I'll see what I can do in this direction.

>> +{
>> +       pseudo_t phi;
>> +       int i = 0;
>> +
>> +       FOR_EACH_PTR(list, phi) {
>> +               if (phi == VOID)
>> +                       continue;
>> +               if (i >= n)
>> +                       return 1;
>> +               array[i++] = phi;
>> +       } END_FOR_EACH_PTR(phi);
>> +       return (i == n) ? 0 : -1;
>
> Maybe here can be use (i - n)?, it will return -2 if 2 entry less than
> requested.

Yes, it's a possibility.

>> -       pseudo_t array[3];
>> +       pseudo_t array[2];
>>         struct basic_block *parents[3];
>>         struct basic_block *bb, *bb1, *bb2, *source;
>>         struct instruction *br;
>>         pseudo_t p1, p2;
>>
>>         bb = insn->bb;
>> -       if (linearize_ptr_list((struct ptr_list *)insn->phi_list, (void **)array, 3) != 2)
>> +       if (get_phi_list(array, 2, insn->phi_list) != 0)
>
> It is not necessary to compare to zero.

Indeed.

-- Luc
