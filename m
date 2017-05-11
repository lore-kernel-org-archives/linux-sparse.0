From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH] ignore VOID when trying to if-convert phi-nodes
Date: Thu, 11 May 2017 21:58:24 +0200
Message-ID: <CAMHZB6E6HCbino_9GXvGQ9zL-AMw7QyrMrMZ9ws0+D6f+vTuxw@mail.gmail.com>
References: <20170509220619.72375-1-luc.vanoostenryck@gmail.com>
 <CANeU7QmM5Rd6o8keZMHL-N2=_dKZg4iPg=M-FAYjqRpEavrj3Q@mail.gmail.com> <CAMHZB6HJ7Rz-S06NF7KZ91MCovnhcOfCHf7F88+vY8vhV8TcWA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-qk0-f170.google.com ([209.85.220.170]:36297 "EHLO
        mail-qk0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751370AbdEKT60 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 11 May 2017 15:58:26 -0400
Received: by mail-qk0-f170.google.com with SMTP id u75so31803982qka.3
        for <linux-sparse@vger.kernel.org>; Thu, 11 May 2017 12:58:26 -0700 (PDT)
In-Reply-To: <CAMHZB6HJ7Rz-S06NF7KZ91MCovnhcOfCHf7F88+vY8vhV8TcWA@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Thu, May 11, 2017 at 8:50 PM, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
> On Thu, May 11, 2017 at 7:13 PM, Christopher Li <sparse@chrisli.org> wrote:
>> Over all looks good. Some minor comment follows.
>>
>> On Tue, May 9, 2017 at 3:06 PM, Luc Van Oostenryck
>> <luc.vanoostenryck@gmail.com> wrote:
>>> +/*
>>> + * Essentially the same as linearize_ptr_list()
>>> + * but ignoring VOID.
>>> + * Returns 0 if the the list contained the expected
>>> + * number of element, 1 or -1 if there was more or less.
>>> + */
>>> +static int get_phi_list(pseudo_t array[], int n, struct pseudo_list *list)
>>
>> The function name does not reflect that it is going to skip the VOID entry
>
> Well yes, but I wasn't ready to use a name like 'get_real_phi_list()' or
> something like this. These VOIDs really mean 'there is no element here/
> the entry has been removed'. So, I think that it's the right thing to put
> the VOID thing in the comment and have such a function name.
>
> But I can look after another name.
>
>> and the API to return value is a little bit non straight forward. e.g.
>> If the result entries is less than the quest one, there is no way to get
>> know the exact number of entry returned.
>
> Yes, I know.
> My first version did this but then I changed my mind because
> it was slightly easier so and having the exact number returned
> is not needed (it's not like we're we're doing some dynamic allocation
> and redo a malloc() with the right number if the initial guess was too
> small). The only thing that really matters here is if the effective number
> of phisrc is the one we're interested in: 2.
>
> OTOH, I don't have a strong opinion on how it should best be done
> and other uses can maybe be interested in the exact number.
>
>> Just RFC here, how about having one helper function to do
>> the normal linearize ptr and skip the VOID entry. Which return how
>> many entry it scanned. (it return n+1 if there is more than n request one).
>>
>> Then the second function you can do the compare to "n" thing.
>> After inline it would behave exactly like your current function.
>
> I'll see what I can do in this direction.

I've looked at this and I really think that it would make things more
complicated than needed for no advantages.

The function is really a local helper, something specialized, unlike
linearize_ptr_list(). So I've changed a bit the name, the comment,
the prototype and the meaning of the function to make this more
obvious (and yes avoid to (mis)reuse this function in others contexts).

New version is coming.

-- Luc
