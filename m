From: Dibyendu Majumdar <mobile@majumdar.org.uk>
Subject: Re: [PATCH 00/29] Simple & Efficient SSA construction.
Date: Thu, 17 Aug 2017 11:10:05 +0100
Message-ID: <CACXZuxdW5Mu6bzZZRiDySw6U52sPA4do3mP6=H1x9WP77ZtPxg@mail.gmail.com>
References: <20170816153455.97693-1-luc.vanoostenryck@gmail.com> <CANeU7Q=+Jeuz41pDMVwqDNoCVj8C8bk=nx6+LY8uXcdP5pRiPw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-vk0-f53.google.com ([209.85.213.53]:37851 "EHLO
        mail-vk0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752685AbdHQKKG (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 17 Aug 2017 06:10:06 -0400
Received: by mail-vk0-f53.google.com with SMTP id r199so20747657vke.4
        for <linux-sparse@vger.kernel.org>; Thu, 17 Aug 2017 03:10:06 -0700 (PDT)
In-Reply-To: <CANeU7Q=+Jeuz41pDMVwqDNoCVj8C8bk=nx6+LY8uXcdP5pRiPw@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, Linux-Sparse <linux-sparse@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>

Hi Chris,

On 17 August 2017 at 05:42, Christopher Li <sparse@chrisli.org> wrote:
> On Wed, Aug 16, 2017 at 11:34 AM, Luc Van Oostenryck
> <luc.vanoostenryck@gmail.com> wrote:
>> The goal of this series is to implement and integrate to sparse
>> the method described in the paper:
>>     "Simple and Efficient Construction of Static Single Assignment Form"
>>         by Matthias Braun, Sebastian Buchwald, Sebastian Hack,
>>            Roland Leissa, Christoph Mallon and Andreas Zwinkau.
>>     cfr. http://www.cdl.uni-saarland.de/papers/bbhlmz13cc.pdf
>>
> BTW, how do you want your patches to be merged? Assume there is
> some feed back. Do you want to come up with V2 V3 or have them merged
> to master then come up with fix up on master?
>

Please could we avoid redoing the patch series unless there is
something fundamentally wrong with the whole series such as missing
log messages or signoffs? I would suggest that we simply apply fixes
on top of the series if needed - and indeed if you want to change
something that would enable you to apply the fix as well.

This certainly makes downstream projects such as dmrC easier to maintain.

Thanks and Regards
Dibyendu
