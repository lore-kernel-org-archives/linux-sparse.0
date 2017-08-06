From: Dibyendu Majumdar <mobile@majumdar.org.uk>
Subject: Re: Potential incorrect simplification
Date: Sun, 6 Aug 2017 18:58:38 +0100
Message-ID: <CACXZuxfyC1KPVviEGCJkFmt9MQ-C8LT73kxNPk2kPy-QAooRTg@mail.gmail.com>
References: <CACXZuxeRXsYWgwihs1nmmTYaLoyhw+PDAy6jEemkZJFpySdfQA@mail.gmail.com>
 <CAExDi1TtcpZtnEV6ctyA9MacJA_9h4njmhd-MSA3KgOq8oK_gA@mail.gmail.com>
 <CACXZuxfxNNh+ThcT=7Xr98tToL2GimFi7UOTSwgNq6mfLLGNfA@mail.gmail.com>
 <20170328141113.kbrwdva6ttsrokts@macpro.local> <CACXZuxen9UFGNp8=-OQHoqRQJ5F__rwQoCJJ6TdkAo6HEXWOQw@mail.gmail.com>
 <CA+55aFx6g3-+6tJ_6Uqu4K1pQoDnqcXrjSGYsryLjjksEtT06A@mail.gmail.com>
 <CANeU7Qk-4U2G_6CZ7KHbGZiqRe9=fpNOzE4eyfLjz3fnd_n3ww@mail.gmail.com>
 <20170806140035.f2tqkmiufjytiwri@ltop.local> <CANeU7QnjRSnnSc8ew69-0M7XP2zoSVh3jhCciYDRVF0i24d=sQ@mail.gmail.com>
 <CACXZuxd30jwczag_GHW3cmqPcBybEi7jfwfku81vW2nHzo_kyA@mail.gmail.com>
 <CAMHZB6FH7431uaYzuQN4jxhwMSYHLXjrVkUs4xuwsvUsAgkDBQ@mail.gmail.com>
 <CACXZuxcQEnZopJEcvRTAEpU=giRfykLP_rZLkqdRZ=hFJBpVAA@mail.gmail.com> <CAMHZB6Eq2D9NhZ_xiq1PZ_vioodQWVU85CnPvwg5fwwU+nZW=Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f172.google.com ([209.85.128.172]:36816 "EHLO
        mail-wr0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751331AbdHFR6k (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 6 Aug 2017 13:58:40 -0400
Received: by mail-wr0-f172.google.com with SMTP id y43so32149330wrd.3
        for <linux-sparse@vger.kernel.org>; Sun, 06 Aug 2017 10:58:40 -0700 (PDT)
In-Reply-To: <CAMHZB6Eq2D9NhZ_xiq1PZ_vioodQWVU85CnPvwg5fwwU+nZW=Q@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Christopher Li <sparse@chrisli.org>, Linus Torvalds <torvalds@linux-foundation.org>, Linux-Sparse <linux-sparse@vger.kernel.org>

On 6 August 2017 at 18:45, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
> On Sun, Aug 6, 2017 at 7:04 PM, Dibyendu Majumdar
> <mobile@majumdar.org.uk> wrote:
>> Wouldn't have thought so - as the variable is not initialized at the
>> point of declaration. The assignment occurs after declaring the struct
>> variable s3.
>
> IIRC, this patch was written specifically for the case you reported here.
>
>> I haven't tried that patch though.
>
> You'll need the full series:
> https://github.com/lucvoo/sparse/tree/fix-bitfield-init-v3
>

I will have a look at it. I did report separately the issue of not
zeroing out structs when they are initialized and the change you
mentioned earlier looks more for addressing that issue.

Regards
Dibyendu
