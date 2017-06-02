From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH 0/6] testsuite speedup
Date: Fri, 2 Jun 2017 12:57:38 +0200
Message-ID: <CAMHZB6FBiEdKMWMLBpmNQhoG1=P1hzXKg=r2eM4iGWkzD11SJA@mail.gmail.com>
References: <20170528192906.1023-1-luc.vanoostenryck@gmail.com>
 <CANeU7Q=DrsNrLdnSH55pUk1fAcNPUzUh5bHQ76fqt18PtRgOPQ@mail.gmail.com>
 <CAExDi1SZv31NHPZ2ddCsQQKpr5T-H6j3ZBwi_0p8EfCG-ycYUA@mail.gmail.com> <CANeU7QkDj5eKxGZHpJ_QZVpq5dhbxYRu4_+D93PzO8to+THaqQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-qk0-f175.google.com ([209.85.220.175]:35254 "EHLO
        mail-qk0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750910AbdFBK5k (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 2 Jun 2017 06:57:40 -0400
Received: by mail-qk0-f175.google.com with SMTP id 19so56783065qke.2
        for <linux-sparse@vger.kernel.org>; Fri, 02 Jun 2017 03:57:40 -0700 (PDT)
In-Reply-To: <CANeU7QkDj5eKxGZHpJ_QZVpq5dhbxYRu4_+D93PzO8to+THaqQ@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Fri, Jun 2, 2017 at 9:29 AM, Christopher Li <sparse@chrisli.org> wrote:
> On Thu, Jun 1, 2017 at 7:05 AM, Luc Van Oostenryck
> <luc.vanoostenryck@gmail.com> wrote:
>> Yes, but there is a few issues with this:
>> - 'test-suite single file.c' doesn't exit with the right return code yet
>> - parallelizing tests with make won't return the summary of the tests
>>   (which may or may not be needed)
>> - the error messages could be mixed in
>> - make would stop at the first error (which may be OK or not)
>> - would be better used with something like 'test-suite --very-quiet file.c'
>
> How about the parallel running just run individual test and
> save the result/error in per test file. Have the a report target that process
> all the individual run result. That will get rid of the result
> ordering issue, no
> error mix in, no early stop etc.

Yes, it's a possibility.

> test-suite will need to change a bit for the separate report phrase.
> I am not suggesting make that into this series. This series is fine
> as it is. I am only making suggestion that parallelizing can speed
> up the check run by a few times.

Yes, it's how I understood it.
I'll see about it next time I make some changes at the testsuite.

-- Luc
