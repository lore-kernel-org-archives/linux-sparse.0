From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: Re: [PATCH v3] sparse: treat function pointers as pointers to const data
Date: Tue, 14 Oct 2014 14:55:35 +0200
Message-ID: <CAKv+Gu_7tgBVJ9uLRDazhMoj88xu5JS89VkW2UumFxKq65ze7g@mail.gmail.com>
References: <1410157803-3658-1-git-send-email-ard.biesheuvel@linaro.org>
	<CAKv+Gu-jTrCnhuS0GEkifj1rA0gjh=cLLEXO9GLxNdw6ctn-Ug@mail.gmail.com>
	<CANeU7QmR-HCp5--PhihSfM1Aan8bNGsPLgtewVVptjbfEZCj6A@mail.gmail.com>
	<CAKv+Gu92fB1oHxn4jDCvNYZ4jhWpbtS-ANhX7LUx73w-+je-0Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-lb0-f177.google.com ([209.85.217.177]:63853 "EHLO
	mail-lb0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755239AbaJNMzh (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Tue, 14 Oct 2014 08:55:37 -0400
Received: by mail-lb0-f177.google.com with SMTP id w7so7932176lbi.8
        for <linux-sparse@vger.kernel.org>; Tue, 14 Oct 2014 05:55:35 -0700 (PDT)
In-Reply-To: <CAKv+Gu92fB1oHxn4jDCvNYZ4jhWpbtS-ANhX7LUx73w-+je-0Q@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>, Will Deacon <will.deacon@arm.com>

On 8 October 2014 20:06, Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
> On 8 October 2014 20:00, Christopher Li <sparse@chrisli.org> wrote:
>> On Mon, Oct 6, 2014 at 10:44 PM, Ard Biesheuvel
>> <ard.biesheuvel@linaro.org> wrote:
>>>> we only address the case where the function pointer is the target of
>>>> an assignment.
>>
>> I apply the patch in my private branch but haven't push out yet.
>>
>> I just want to confirm, you didn't find this kind of assignment in the
>> kernel, right?
>>
>
> I noticed this patch
>
> https://git.kernel.org/cgit/linux/kernel/git/kvmarm/kvmarm.git/commit/?h=queue&id=de56fb1923ca11f428bf557870e0faa99f38762e
>
> and saw that it was bogus: changing the return type of the pointed-to
> function to 'const int' makes no sense at all, and yet it shuts up
> sparse.
>
> With my sparse patch, that patch could have been dropped (although I
> think it was merged after all)
>

Ping?
