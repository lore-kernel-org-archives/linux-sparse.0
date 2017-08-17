From: Dibyendu Majumdar <mobile@majumdar.org.uk>
Subject: Re: [PATCH 11/29] add PSEUDO_UNDEF
Date: Thu, 17 Aug 2017 17:55:53 +0100
Message-ID: <CACXZuxcQ0KLfmVtk4=cg-5f0Z_mw0WNj8oBrBTaGxNoyaA-5jA@mail.gmail.com>
References: <20170816153455.97693-1-luc.vanoostenryck@gmail.com>
 <20170816153455.97693-12-luc.vanoostenryck@gmail.com> <CANeU7Q=8Q5HtN9mkS3t7GX9E=+eM1kp+57x1mqUBGy2fUZrJFQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-ua0-f170.google.com ([209.85.217.170]:34393 "EHLO
        mail-ua0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752610AbdHQQzz (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 17 Aug 2017 12:55:55 -0400
Received: by mail-ua0-f170.google.com with SMTP id q25so26980732uah.1
        for <linux-sparse@vger.kernel.org>; Thu, 17 Aug 2017 09:55:54 -0700 (PDT)
In-Reply-To: <CANeU7Q=8Q5HtN9mkS3t7GX9E=+eM1kp+57x1mqUBGy2fUZrJFQ@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, Linux-Sparse <linux-sparse@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>

Hi Chris,

On 17 August 2017 at 08:30, Christopher Li <sparse@chrisli.org> wrote:
> On Wed, Aug 16, 2017 at 11:34 AM, Luc Van Oostenryck
> <luc.vanoostenryck@gmail.com> wrote:
>> Processing in the middle-end are much easier if undefined values
>> have been clearly identified. Once done, we can then make
>> choices like:
>> - always initialize them to zero
>> - allow arbitraly simplification,
>
> Can pick arbitrate initialized value, but can't do arbitraly simplification.
>

I agree with that. Perhaps a specific default value can be set?

Regards
Dibyendu
