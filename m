From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH] Add -gcc-version option
Date: Wed, 19 Jul 2017 15:16:43 -0400
Message-ID: <CANeU7QnUdVGruZV=acWuOwx5_euJJyY8dxmqLtmTbDNxhD+Urg@mail.gmail.com>
References: <CAN_72e10vHGWwmovq_ra7FKE9EQgo-T+r8AavwFErkEV9Hnuww@mail.gmail.com>
 <CANeU7Qn7Te3kxzcWAzC_4Hn2MLSsGFTdNX2AjJwmWdb6e2n+pA@mail.gmail.com>
 <CAN_72e2SE4pcUNNUSOJVRW31YdXmm-tR0ybOjpT7QDV2fmne4g@mail.gmail.com>
 <CANeU7Q=HYVQY3HkSqKPekxSMhzFsxpV2UV905h3Qyf2sNGF1ug@mail.gmail.com> <CAN_72e0f6Zg3YeDrMmb5OOHHr4qj14Wc_WeomeZirjXx0zOU=w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-pf0-f171.google.com ([209.85.192.171]:36348 "EHLO
        mail-pf0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934027AbdGSTQo (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 19 Jul 2017 15:16:44 -0400
Received: by mail-pf0-f171.google.com with SMTP id o88so3454646pfk.3
        for <linux-sparse@vger.kernel.org>; Wed, 19 Jul 2017 12:16:44 -0700 (PDT)
In-Reply-To: <CAN_72e0f6Zg3YeDrMmb5OOHHr4qj14Wc_WeomeZirjXx0zOU=w@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Pavel Roskin <plroskin@gmail.com>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Wed, Jul 19, 2017 at 1:27 PM, Pavel Roskin <plroskin@gmail.com> wrote:
>
> I did not realize that sparse supports -include. It turns out it does,
> which is even better than specifying three defines.
>
> I don't see any references to -D or -include in the sparse manual
> page. I think they should be documented.

It is kind of expected due to usage of cgcc. cgcc expect to be run like
gcc but with one extra step of sparse check checking on it. In order to
duplicate the gcc behavior on macro, sparse will need to  accept most
of the gcc preprocessor command line options.

As for the document, patch are welcome :-)

Chris
