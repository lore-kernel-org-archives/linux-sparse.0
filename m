From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH 0/6] testsuite speedup
Date: Thu, 1 Jun 2017 16:05:01 +0200
Message-ID: <CAExDi1SZv31NHPZ2ddCsQQKpr5T-H6j3ZBwi_0p8EfCG-ycYUA@mail.gmail.com>
References: <20170528192906.1023-1-luc.vanoostenryck@gmail.com> <CANeU7Q=DrsNrLdnSH55pUk1fAcNPUzUh5bHQ76fqt18PtRgOPQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-qt0-f175.google.com ([209.85.216.175]:35270 "EHLO
        mail-qt0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751090AbdFAOFD (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 1 Jun 2017 10:05:03 -0400
Received: by mail-qt0-f175.google.com with SMTP id w1so9748149qtg.2
        for <linux-sparse@vger.kernel.org>; Thu, 01 Jun 2017 07:05:02 -0700 (PDT)
In-Reply-To: <CANeU7Q=DrsNrLdnSH55pUk1fAcNPUzUh5bHQ76fqt18PtRgOPQ@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Thu, Jun 1, 2017 at 11:16 AM, Christopher Li <sparse@chrisli.org> wrote:
> BTW, another way to speed up the test suit is using makefile to invoke
> more than one job of test suite. Currently all test suit are execute
> one by one. But there is no inter dependency between the test.
> So in theory we can change the Makefile a bit to run more than one
> job on the test suit using pattern rules.

Yes, but there is a few issues with this:
- 'test-suite single file.c' doesn't exit with the right return code yet
- parallelizing tests with make won't return the summary of the tests
  (which may or may not be needed)
- the error messages could be mixed in
- make would stop at the first error (which may be OK or not)
- would be better used with something like 'test-suite --very-quiet file.c'

-- Luc
