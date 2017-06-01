From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH 0/6] testsuite speedup
Date: Thu, 1 Jun 2017 02:16:11 -0700
Message-ID: <CANeU7Q=DrsNrLdnSH55pUk1fAcNPUzUh5bHQ76fqt18PtRgOPQ@mail.gmail.com>
References: <20170528192906.1023-1-luc.vanoostenryck@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-it0-f45.google.com ([209.85.214.45]:35393 "EHLO
        mail-it0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751581AbdFAJQM (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 1 Jun 2017 05:16:12 -0400
Received: by mail-it0-f45.google.com with SMTP id f72so30866865ite.0
        for <linux-sparse@vger.kernel.org>; Thu, 01 Jun 2017 02:16:12 -0700 (PDT)
In-Reply-To: <20170528192906.1023-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Sun, May 28, 2017 at 12:29 PM, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
> The goal of this series is to speedup the testsuite,
> mainly by avoiding to unneedlessly spawn child processes.
>
> The resulting speedup here is over 2.5, which is quite appreciable.

This series looks fine to me.

BTW, another way to speed up the test suit is using makefile to invoke
more than one job of test suite. Currently all test suit are execute
one by one. But there is no inter dependency between the test.
So in theory we can change the Makefile a bit to run more than one
job on the test suit using pattern rules.

Chris
