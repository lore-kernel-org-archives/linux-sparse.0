From: Dibyendu Majumdar <mobile@majumdar.org.uk>
Subject: Re: sparse-llvm incorrect type when ealing with union type
Date: Sun, 19 Mar 2017 17:55:44 +0000
Message-ID: <CACXZuxeEgMv2iY=kFi_jWpJ2m5Lmx2qxr738mw8oJ+f=pPR2sw@mail.gmail.com>
References: <CACXZuxcb=27brA9N=w-tnZ9V0StKnDYZ4y27cS6eoenA7S0ctw@mail.gmail.com>
 <20170319153609.yykbjbbb6v4lw4xb@macpro.local> <CACXZuxcSn=qPJF4S0SPmGr5xd64X6WevnwFcC+UuWPZPQ=odFQ@mail.gmail.com>
 <CAExDi1QY0UKpLkMantdMna4LjqB2obDTz_cHdjhW3mLiyyDgBw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-it0-f48.google.com ([209.85.214.48]:36700 "EHLO
        mail-it0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752060AbdCSS1F (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 19 Mar 2017 14:27:05 -0400
Received: by mail-it0-f48.google.com with SMTP id w124so68350354itb.1
        for <linux-sparse@vger.kernel.org>; Sun, 19 Mar 2017 11:27:04 -0700 (PDT)
In-Reply-To: <CAExDi1QY0UKpLkMantdMna4LjqB2obDTz_cHdjhW3mLiyyDgBw@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

Hi Luc,

On 19 March 2017 at 17:15, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
> On Sun, Mar 19, 2017 at 5:37 PM, Dibyendu Majumdar
> <mobile@majumdar.org.uk> wrote:
>> On 19 March 2017 at 15:36, Luc Van Oostenryck
>> <luc.vanoostenryck@gmail.com> wrote:
>>>
>> I noticed that in the latest patch series for add/sub you are not
>> using GEP anymore, and there is a conversion to target type at the end
>> of a binary op. I will try out these changes and report back.
>
> Yes. It's not that the GEP was wrong but it was not enough and the more
> complete solution made this one unneeded.
>

I have now tested the changes to binary op implementation - and I can
confirm that all my tests pass, and this appears to be a better
approach than the previous one that used the GEP instruction.

Thanks and Regards
Dibyendu
