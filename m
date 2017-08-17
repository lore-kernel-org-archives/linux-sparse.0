From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH 11/29] add PSEUDO_UNDEF
Date: Thu, 17 Aug 2017 03:30:28 -0400
Message-ID: <CANeU7Q=8Q5HtN9mkS3t7GX9E=+eM1kp+57x1mqUBGy2fUZrJFQ@mail.gmail.com>
References: <20170816153455.97693-1-luc.vanoostenryck@gmail.com> <20170816153455.97693-12-luc.vanoostenryck@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-yw0-f179.google.com ([209.85.161.179]:34078 "EHLO
        mail-yw0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750939AbdHQHa3 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 17 Aug 2017 03:30:29 -0400
Received: by mail-yw0-f179.google.com with SMTP id s143so36183540ywg.1
        for <linux-sparse@vger.kernel.org>; Thu, 17 Aug 2017 00:30:29 -0700 (PDT)
In-Reply-To: <20170816153455.97693-12-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>

On Wed, Aug 16, 2017 at 11:34 AM, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
> Processing in the middle-end are much easier if undefined values
> have been clearly identified. Once done, we can then make
> choices like:
> - always initialize them to zero
> - allow arbitraly simplification,

Can pick arbitrate initialized value, but can't do arbitraly simplification.

The chance looks good. I need to take a crash now.

To be continue...

Chris
