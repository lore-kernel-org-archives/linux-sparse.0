From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH 11/29] add PSEUDO_UNDEF
Date: Thu, 17 Aug 2017 21:01:02 +0200
Message-ID: <CAExDi1SqVXhefyanyKXSQ=RV-nAjoaBzWmFd2kSYkry0TeGi4Q@mail.gmail.com>
References: <20170816153455.97693-1-luc.vanoostenryck@gmail.com>
 <20170816153455.97693-12-luc.vanoostenryck@gmail.com> <CANeU7Q=8Q5HtN9mkS3t7GX9E=+eM1kp+57x1mqUBGy2fUZrJFQ@mail.gmail.com>
 <CACXZuxcQ0KLfmVtk4=cg-5f0Z_mw0WNj8oBrBTaGxNoyaA-5jA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-oi0-f46.google.com ([209.85.218.46]:33125 "EHLO
        mail-oi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752236AbdHQTBD (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 17 Aug 2017 15:01:03 -0400
Received: by mail-oi0-f46.google.com with SMTP id f11so75894565oic.0
        for <linux-sparse@vger.kernel.org>; Thu, 17 Aug 2017 12:01:03 -0700 (PDT)
In-Reply-To: <CACXZuxcQ0KLfmVtk4=cg-5f0Z_mw0WNj8oBrBTaGxNoyaA-5jA@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Dibyendu Majumdar <mobile@majumdar.org.uk>
Cc: Christopher Li <sparse@chrisli.org>, Linux-Sparse <linux-sparse@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>

On Thu, Aug 17, 2017 at 6:55 PM, Dibyendu Majumdar
<mobile@majumdar.org.uk> wrote:
>>> Processing in the middle-end are much easier if undefined values
>>> have been clearly identified. Once done, we can then make
>>> choices like:
>>> - always initialize them to zero
>>> - allow arbitraly simplification,
>>
>> Can pick arbitrate initialized value, but can't do arbitraly simplification.
>>
>
> I agree with that. Perhaps a specific default value can be set?

I was speaking loosely to say that a lot of simplifications are possible once
the involved pseudo(s) is/are undefined.

-- Luc
