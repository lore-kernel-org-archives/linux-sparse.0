From: "Alexey Zaytsev" <alexey.zaytsev@gmail.com>
Subject: Re: [PATCH 0/10] Sparse linker
Date: Thu, 4 Sep 2008 08:03:25 +0400
Message-ID: <f19298770809032103h5ea34122g44fda595d775cecf@mail.gmail.com>
References: <1220478954-22678-1-git-send-email-alexey.zaytsev@gmail.com>
	 <70318cbf0809031808u8610f3h4b3d53a7b76a7799@mail.gmail.com>
	 <70318cbf0809031816m69565c5aj9417d9a2e136770d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.180]:48112 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750806AbYIDED0 (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Thu, 4 Sep 2008 00:03:26 -0400
Received: by wa-out-1112.google.com with SMTP id j37so2169954waf.23
        for <linux-sparse@vger.kernel.org>; Wed, 03 Sep 2008 21:03:25 -0700 (PDT)
In-Reply-To: <70318cbf0809031816m69565c5aj9417d9a2e136770d@mail.gmail.com>
Content-Disposition: inline
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: linux-sparse@vger.kernel.org, Josh Triplett <josh@kernel.org>, Codrin Alexandru Grajdeanu <grcodal@gmail.com>

On Thu, Sep 4, 2008 at 5:16 AM, Christopher Li <sparse@chrisli.org> wrote:
> Oops, forget to CC the list.
>
> Chris
>
> ---------- Forwarded message ----------
> From: Chris Li <sparse@chrisli.org>
> Date: Wed, Sep 3, 2008 at 6:08 PM
> Subject: Re: [PATCH 0/10] Sparse linker
> To: alexey.zaytsev@gmail.com
>
>
> On Wed, Sep 3, 2008 at 2:55 PM,  <alexey.zaytsev@gmail.com> wrote:
>
>> more on the subject, I now agree that we should include the
>> intermediate code representation into the object files.
>
> Good.
>
>> for this is a four byte overhead prepended to every
>> serializable structure by the allocation wrapper. Also, you
>
> I would rather not have that 4 byte prepended to every
> structure. Serialize is just one short stage of the life cycle
> of those c structures. Having the permanent extra space
> for just that is unnecessary. That 4 bytes meta data also
> limits what C structure you can work on. All you need
> is being able to map a point into some serialize object
> to keep track which object is tracked and which one is not.
>
> After you serialized the data. The meta data can be drop
> completely. So the price to pay is for every unknown object
> pointer, you need to do a dictionary look up. Only during
> the dumping stage. But that price is actually very small,
> when you dumping objects. You are mostly limit by the disk
> any way. The plus side is: you can work with any objects.
> You don't need to waste extra memory for serialization
> when you are not doing serialization. You can leave the
> object allocation code unchanged.

Thanks for the comment, I will look into this idea. I just
realized that I'm actually unable to serialize stand-alone
arrays right now. The array members should be there,
but not sequentially.

>
>> have to use a macro when declaring a serializable structure
>> (or an array of such) statically. One limitation I was unable
>> to overcome is the inability to work with structures used both
>> stand-alone and embedded into bigger ones. Luckily, we have no
>
> Like the ctype member inside the "struct symbol"?

I still hope I made no mistake that struct ctype is used stand-alone
only as a temporary variable, and is never pointed to from an other
data structure that we would like to serialize.

>
>> list and serializing it [PATCH 07]. The linker needs to dlopen
>
> Do you use the stander share library for dlopen and dynamic linking
> the sparse objects?

If I understand the question right, no. Every "sparse object" .so has a
"struct ptr_list *symbols" entry (in fact, the only non-static entry) that
points to the serialized ptr list of the "struct sold_symbol". The linker
dlopen()'s the .so and hooks to the entry, for every input object file.
After that, it simply calls ptr_list_concat() on the opened symbol lists,
and serializes the resulting combined list. There is of course nothing
wrong if we modify the data obtained from the .so, as it is cow-mmaped.

>
>
>> the input "sparse objects", merge the symbol lists, and
>> serialize the result [PATCH 08]. The generated code compilation
>> is handled by the cgcc, cld and car wrappers [PATCH 09]. To
>> look up symbols in sparse object files, a simple program is
>> included [PATCH 10].
>
> Do you dump your sparse object in ELF format?
Well, I serialize the data into C, and then compile it into .so, if
that was the question. You might want to apply the first patch
and look at the serialization-test output.

>
> Chris
>
