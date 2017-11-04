From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [SPARSE] Questions for distros
Date: Sat, 4 Nov 2017 21:13:58 +0100
Message-ID: <CAMHZB6E=Ad23wh8LCn9wV3m285khyDY2o_Ys-+D1jd4ocj5CKQ@mail.gmail.com>
References: <20171104172528.35tzbeh4k6kp6bbg@ltop.local> <1509817409.29302.14.camel@redhat.com>
 <13e9688b-0643-0a87-a87b-6c72192669b6@kleine-koenig.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-ua0-f175.google.com ([209.85.217.175]:47340 "EHLO
        mail-ua0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752156AbdKDUN7 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 4 Nov 2017 16:13:59 -0400
Received: by mail-ua0-f175.google.com with SMTP id e46so4073857uaa.4
        for <linux-sparse@vger.kernel.org>; Sat, 04 Nov 2017 13:13:59 -0700 (PDT)
In-Reply-To: <13e9688b-0643-0a87-a87b-6c72192669b6@kleine-koenig.org>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <uwe@kleine-koenig.org>
Cc: Jeff Layton <jlayton@redhat.com>, Linux-Sparse <linux-sparse@vger.kernel.org>

On Sat, Nov 4, 2017 at 6:56 PM, Uwe Kleine-K=C3=B6nig <uwe@kleine-koenig.or=
g> wrote:
> Hi Luc,
>
> On 11/04/2017 06:43 PM, Jeff Layton wrote:
>> On Sat, 2017-11-04 at 18:25 +0100, Luc Van Oostenryck wrote:
>>> Hi,
>>>
>>> I'm making some cleanup in my dev tree and there are a few things
>>> I'm curious about concerning what distros are doing.
>>>
>>> I hope you don't mind to answer to those questions.
>>>
>>> 1) Do the distros use sparse's shared lib?
>>>    I remember there was a mail about it months ago but
>>>    I can't find it anymore.
>>>
>>
>> The Fedora and EPEL packages do not. I'm not opposed to adding it, but I
>> don't really need it and no one has asked for it.
>>
>>> 2) Do the distros use sparse's install rule?
>>>
>>
>> Yes. rpmbuild basically does a make install in a chrooted dir, and then
>> installs the files that end up in there.
>>
>>> 3) Do the distros install sparse with its pkconfig?
>>
>> No. Since we aren't packaging the shared lib, we don't bother.
>>
>
> The answers for Debian are exactly the same. Ubuntu uses the Debian
> packages as is.

OK, thanks.

> https://packages.debian.org/sid/sparse (and
> https://packages.debian.org/sid/sparse-test-inspect) have "list of
> files" links for each architecture which might be quicker to answer
> similar questions for you. (But I don't mind your questions.)

I see that the .h files are installed as well as sparse.pc.
I've the intention to remove them from the install rule in my tree
because using some .h files are missing since 2013 and I don't think
anybody use it, only the executables are used. But I'm also fine to keep
it if there is some objections.

Best regards,
-- Luc
