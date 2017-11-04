From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [SPARSE] Questions for distros
Date: Sat, 4 Nov 2017 21:01:45 +0100
Message-ID: <CAMHZB6Fve7qv2kvcvscEssHJS1Tg_02rWdv0608oEdxZsQzWsg@mail.gmail.com>
References: <20171104172528.35tzbeh4k6kp6bbg@ltop.local> <1509817409.29302.14.camel@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-vk0-f42.google.com ([209.85.213.42]:47298 "EHLO
        mail-vk0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750959AbdKDUBq (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 4 Nov 2017 16:01:46 -0400
Received: by mail-vk0-f42.google.com with SMTP id j2so3678124vki.4
        for <linux-sparse@vger.kernel.org>; Sat, 04 Nov 2017 13:01:46 -0700 (PDT)
In-Reply-To: <1509817409.29302.14.camel@redhat.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Jeff Layton <jlayton@redhat.com>
Cc: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <uwe@kleine-koenig.org>, Linux-Sparse <linux-sparse@vger.kernel.org>

On Sat, Nov 4, 2017 at 6:43 PM, Jeff Layton <jlayton@redhat.com> wrote:
> On Sat, 2017-11-04 at 18:25 +0100, Luc Van Oostenryck wrote:
>> Hi,
>>
>> I'm making some cleanup in my dev tree and there are a few things
>> I'm curious about concerning what distros are doing.
>>
>> I hope you don't mind to answer to those questions.
>>
>> 1) Do the distros use sparse's shared lib?
>>    I remember there was a mail about it months ago but
>>    I can't find it anymore.
>>
>
> The Fedora and EPEL packages do not. I'm not opposed to adding it, but I
> don't really need it and no one has asked for it.

I also don't see the need for it for now.

>> 2) Do the distros use sparse's install rule?
>>
>
> Yes. rpmbuild basically does a make install in a chrooted dir, and then
> installs the files that end up in there.

OK, that's good to know.

>> 3) Do the distros install sparse with its pkconfig?
>
> No. Since we aren't packaging the shared lib, we don't bother.

OK, that's good because it's broken since 2013 :(


Thanks for the reply,
Luc
