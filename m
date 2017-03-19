From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: sparse-llvm incorrect type when ealing with union type
Date: Sun, 19 Mar 2017 18:15:51 +0100
Message-ID: <CAExDi1QY0UKpLkMantdMna4LjqB2obDTz_cHdjhW3mLiyyDgBw@mail.gmail.com>
References: <CACXZuxcb=27brA9N=w-tnZ9V0StKnDYZ4y27cS6eoenA7S0ctw@mail.gmail.com>
 <20170319153609.yykbjbbb6v4lw4xb@macpro.local> <CACXZuxcSn=qPJF4S0SPmGr5xd64X6WevnwFcC+UuWPZPQ=odFQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-qk0-f176.google.com ([209.85.220.176]:33408 "EHLO
        mail-qk0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751972AbdCSRoY (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 19 Mar 2017 13:44:24 -0400
Received: by mail-qk0-f176.google.com with SMTP id y76so95725503qkb.0
        for <linux-sparse@vger.kernel.org>; Sun, 19 Mar 2017 10:42:52 -0700 (PDT)
In-Reply-To: <CACXZuxcSn=qPJF4S0SPmGr5xd64X6WevnwFcC+UuWPZPQ=odFQ@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Dibyendu Majumdar <mobile@majumdar.org.uk>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Sun, Mar 19, 2017 at 5:37 PM, Dibyendu Majumdar
<mobile@majumdar.org.uk> wrote:
> Hi Luc,
>
> On 19 March 2017 at 15:36, Luc Van Oostenryck
> <luc.vanoostenryck@gmail.com> wrote:
>>
>> This seems to be fixed in the llvm-fixes-v3 serie I submitted yesterday.
>> But I never saw exactly what was the specific problem here.
>>
>
> I noticed that in the latest patch series for add/sub you are not
> using GEP anymore, and there is a conversion to target type at the end
> of a binary op. I will try out these changes and report back.

Yes. It's not that the GEP was wrong but it was not enough and the more
complete solution made this one unneeded.

Luc
