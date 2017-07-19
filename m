From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH] Add -gcc-version option
Date: Wed, 19 Jul 2017 09:07:03 -0400
Message-ID: <CANeU7Q=HYVQY3HkSqKPekxSMhzFsxpV2UV905h3Qyf2sNGF1ug@mail.gmail.com>
References: <CAN_72e10vHGWwmovq_ra7FKE9EQgo-T+r8AavwFErkEV9Hnuww@mail.gmail.com>
 <CANeU7Qn7Te3kxzcWAzC_4Hn2MLSsGFTdNX2AjJwmWdb6e2n+pA@mail.gmail.com> <CAN_72e2SE4pcUNNUSOJVRW31YdXmm-tR0ybOjpT7QDV2fmne4g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-pf0-f181.google.com ([209.85.192.181]:32937 "EHLO
        mail-pf0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753601AbdGSNHE (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 19 Jul 2017 09:07:04 -0400
Received: by mail-pf0-f181.google.com with SMTP id s70so133399pfs.0
        for <linux-sparse@vger.kernel.org>; Wed, 19 Jul 2017 06:07:04 -0700 (PDT)
In-Reply-To: <CAN_72e2SE4pcUNNUSOJVRW31YdXmm-tR0ybOjpT7QDV2fmne4g@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Pavel Roskin <plroskin@gmail.com>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Tue, Jul 18, 2017 at 7:46 PM, Pavel Roskin <plroskin@gmail.com> wrote:
> Yes, that works! I wish I thought of it earlier and did not waste time
> writing that patch.
>
> That option may still be useful if sparse attempts to imitate the
> behavior of specific gcc versions (in addition to the defines).

I will skip the patch  for now. Yes it is more convenient to give one
command line
options and it set 3 macros. I am not sure the complexity justify it.

When you specify the gcc version, there is also implicit version
specific behavior
go with it. I can see user file bugs said I give sparse gcc version X,
but gcc has
macro Y in X. That is not the case with sparse, that is a bug. I don't
want to give
the user false impression that sparse can set a gcc version and simulate the gcc
version specific behavior.

It is simpler just put the version specific macro into a header file and ask
sparse to include it. You should be able to add that to command line as well.

Chris
